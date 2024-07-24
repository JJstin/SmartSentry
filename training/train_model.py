import torch
import torch.nn as nn
import torch.optim as optim
import torchvision.transforms as transforms
from torchvision.models import resnet18, ResNet18_Weights
from torch.utils.data import DataLoader
import matplotlib.pyplot as plt
from datasets import load_dataset
import numpy as np
from datetime import datetime
import os

def train_model(OUTPUT_CLASS_NUMBER):
    # Set the device
    device = torch.device("cuda" if torch.cuda.is_available() else "mps" if torch.backends.mps.is_available() else "cpu")

    # Load the pretrained ResNet model
    resnet = resnet18(weights=ResNet18_Weights.IMAGENET1K_V1)

    # Unfreeze the last 3 layers
    for param in resnet.parameters():
        param.requires_grad = False

    for param in list(resnet.parameters())[-6:]:
        param.requires_grad = True

    # Modify the fully connected layer
    num_features = resnet.fc.in_features
    resnet.fc = nn.Sequential(
        nn.Linear(num_features, 512),
        nn.ReLU(),
        nn.Dropout(0.5),
        nn.Linear(512, 256),
        nn.ReLU(),
        nn.Linear(256, OUTPUT_CLASS_NUMBER)
    )

    resnet = resnet.to(device)

    # Define the transforms
    transform = transforms.Compose([
        transforms.ToTensor(),
        transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225]),
    ])

    # Load the datasets from Hugging Face
    dataset = load_dataset("imagefolder", data_dir="datasets/processed", drop_labels=False)

    train_dataset = dataset["train"]
    val_dataset = dataset["validation"]
    test_dataset = dataset["test"]

    # Create label map
    label_map = {i: dataset['train'].features['label'].int2str(i) for i in range(OUTPUT_CLASS_NUMBER)}

    # Custom Dataset class to handle transformations
    class CustomDataset(torch.utils.data.Dataset):
        def __init__(self, dataset, transform=None):
            self.dataset = dataset
            self.transform = transform

        def __len__(self):
            return len(self.dataset)

        def __getitem__(self, idx):
            image = self.dataset[idx]['image']
            label = self.dataset[idx]['label']

            if self.transform:
                image = self.transform(image)

            return image, label

    # Create datasets
    train_dataset = CustomDataset(train_dataset, transform=transform)
    val_dataset = CustomDataset(val_dataset, transform=transform)
    test_dataset = CustomDataset(test_dataset, transform=transform)

    # Define the data loaders
    train_loader = DataLoader(train_dataset, batch_size=32, shuffle=True)
    val_loader = DataLoader(val_dataset, batch_size=32, shuffle=False)
    test_loader = DataLoader(test_dataset, batch_size=32, shuffle=False)

    # Compute class weights
    class_counts = np.bincount([label['label'] for label in dataset["train"]])
    class_weights = 1.0 / class_counts
    class_weights = class_weights / class_weights.sum()  # Normalize weights
    class_weights = torch.tensor(class_weights, dtype=torch.float).to(device)

    # Define the loss function with class weights
    criterion = nn.CrossEntropyLoss(weight=class_weights)

    # Define the optimizer
    optimizer = optim.Adam(filter(lambda p: p.requires_grad, resnet.parameters()), lr=0.001)

    # Lists to store loss and accuracy values
    train_losses = []
    val_losses = []
    train_accuracies = []
    val_accuracies = []

    # Create a logs directory if it doesn't exist
    os.makedirs("logs", exist_ok=True)

    # Generate a unique filename for the log file
    current_time = datetime.now().strftime('%Y%m%d_%H%M%S')
    log_filename = f'logs/training_log_{current_time}.txt'

    # Open the log file for writing
    with open(log_filename, 'w') as log_file:
        log_file.write(f"Training session started at {current_time}\n")
        log_file.write(f"Model: ResNet18\n")
        log_file.write(f"Output classes: {OUTPUT_CLASS_NUMBER}\n")
        log_file.write(f"Device: {device}\n\n")

        log_file.write("Dataset Information:\n")
        log_file.write(f"Train dataset size: {len(train_dataset)}\n")
        log_file.write(f"Validation dataset size: {len(val_dataset)}\n")
        log_file.write(f"Test dataset size: {len(test_dataset)}\n\n")

        # Training loop
        num_epochs = 25
        for epoch in range(num_epochs):
            resnet.train()
            running_loss = 0.0
            correct_train = 0
            total_train = 0
            for inputs, labels in train_loader:
                inputs, labels = inputs.to(device), labels.to(device)

                optimizer.zero_grad()

                outputs = resnet(inputs)
                loss = criterion(outputs, labels)
                loss.backward()
                optimizer.step()

                running_loss += loss.item() * inputs.size(0)

                _, predicted = torch.max(outputs, 1)
                total_train += labels.size(0)
                correct_train += (predicted == labels).sum().item()

            epoch_loss = running_loss / len(train_loader.dataset)
            epoch_acc = 100 * correct_train / total_train
            train_losses.append(epoch_loss)
            train_accuracies.append(epoch_acc)

            # Validation loop
            resnet.eval()
            val_running_loss = 0.0
            correct_val = 0
            total_val = 0
            with torch.no_grad():
                for inputs, labels in val_loader:
                    inputs, labels = inputs.to(device), labels.to(device)

                    outputs = resnet(inputs)
                    loss = criterion(outputs, labels)

                    val_running_loss += loss.item() * inputs.size(0)

                    _, predicted = torch.max(outputs, 1)
                    total_val += labels.size(0)
                    correct_val += (predicted == labels).sum().item()

            val_loss = val_running_loss / len(val_loader.dataset)
            val_acc = 100 * correct_val / total_val
            val_losses.append(val_loss)
            val_accuracies.append(val_acc)

            print(f'Epoch {epoch+1}/{num_epochs}, Training Loss: {epoch_loss:.4f}, Validation Loss: {val_loss:.4f}, Training Accuracy: {epoch_acc:.2f}%, Validation Accuracy: {val_acc:.2f}%')

            log_file.write(f'Epoch {epoch+1}/{num_epochs}, Training Loss: {epoch_loss:.4f}, Validation Loss: {val_loss:.4f}, Training Accuracy: {epoch_acc:.2f}%, Validation Accuracy: {val_acc:.2f}%\n')

        # Save the model with a timestamp
        model_filename = f'resnet_finetuned_{current_time}.pth'
        torch.save(resnet.state_dict(), model_filename)

        # Log model save information
        log_file.write(f"\nModel saved as {model_filename}\n")

        # Evaluate the model on the test set
        resnet.eval()
        test_running_loss = 0.0
        correct_test = 0
        total_test = 0
        with torch.no_grad():
            for inputs, labels in test_loader:
                inputs, labels = inputs.to(device), labels.to(device)

                outputs = resnet(inputs)
                loss = criterion(outputs, labels)

                test_running_loss += loss.item() * inputs.size(0)

                _, predicted = torch.max(outputs, 1)
                total_test += labels.size(0)
                correct_test += (predicted == labels).sum().item()

        test_loss = test_running_loss / len(test_loader.dataset)
        test_accuracy = 100 * correct_test / total_test

        print(f'Test Loss: {test_loss:.4f}, Test Accuracy: {test_accuracy:.2f}%')
        log_file.write(f'\nTest Loss: {test_loss:.4f}, Test Accuracy: {test_accuracy:.2f}%\n')

    # Plotting the results
    epochs = range(1, num_epochs + 1)

    plt.figure(figsize=(14, 5))

    plt.subplot(1, 2, 1)
    plt.plot(epochs, train_losses, label='Training Loss')
    plt.plot(epochs, val_losses, label='Validation Loss')
    plt.xlabel('Epochs')
    plt.ylabel('Loss')
    plt.legend()
    plt.title('Loss vs Epochs')

    plt.subplot(1, 2, 2)
    plt.plot(epochs, train_accuracies, label='Training Accuracy')
    plt.plot(epochs, val_accuracies, label='Validation Accuracy')
    plt.xlabel('Epochs')
    plt.ylabel('Accuracy')
    plt.legend()
    plt.title('Accuracy vs Epochs')

    plt.tight_layout()
    plt.show()

    return label_map, model_filename

