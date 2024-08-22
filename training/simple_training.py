import torch
import torch.nn as nn
import torch.optim as optim
import torchvision.transforms as transforms
from torchvision.models import resnet18, ResNet18_Weights
from torch.utils.data import DataLoader
import matplotlib.pyplot as plt
from datasets import load_from_disk

# Load the dataset from disk
save_path = 'datasets/balanced_dataset_local_data_only'
balanced_dataset = load_from_disk(save_path)

# save_path = 'datasets/balanced_dataset_transformed_local'
# balanced_dataset = load_from_disk(save_path)

# Define transformations
transform = transforms.Compose([
    transforms.RandomHorizontalFlip(),
    transforms.RandomRotation(10),
    transforms.ColorJitter(brightness=0.2, contrast=0.2),
    transforms.RandomResizedCrop(224, scale=(0.8, 1.0), ratio=(1.0, 1.0)),
    transforms.ToTensor(),
    transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])
])

original_transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor(),
    transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])
])

class CustomDataset(torch.utils.data.Dataset):
    def __init__(self, dataset, transform=None, original_transform=None):
        self.dataset = dataset
        self.transform = transform
        self.original_transform = original_transform

    def __len__(self):
        return len(self.dataset) * 3  # Each image will have 3 versions

    def __getitem__(self, idx):
        original_idx = idx // 3
        image = self.dataset[original_idx]['image']
        label = self.dataset[original_idx]['label']

        # Apply different transformations
        if idx % 3 == 0:
            if self.original_transform:
                image = self.original_transform(image)
        else:
            if self.transform:
                image = self.transform(image)

        return image, label

# Create dataset and dataloader
dataset = CustomDataset(balanced_dataset, transform=transform, original_transform=original_transform)

# or simply use the dataset form the transformed raw
# dataset = balanced_dataset

dataloader = DataLoader(dataset, batch_size=32, shuffle=True)

# Load pre-trained ResNet18 model with new weights parameter
model = resnet18(weights=ResNet18_Weights.IMAGENET1K_V1)
num_classes = 2  # Update this based on your dataset
model.fc = nn.Linear(model.fc.in_features, num_classes)

# Freeze all layers except the last one
for param in model.parameters():
    param.requires_grad = False
for param in model.fc.parameters():
    param.requires_grad = True

# Set device
device = torch.device("cuda" if torch.cuda.is_available() else "mps" if torch.backends.mps.is_available() else "cpu")
model.to(device)

# Loss function and optimizer
criterion = nn.CrossEntropyLoss()
optimizer = optim.SGD(model.fc.parameters(), lr=0.01, momentum=0.9)

# Training and validation metrics
train_losses = []
train_accuracies = []

# Training loop
num_epochs = 10  # Adjust as needed
for epoch in range(num_epochs):
    print("starting epoch ", epoch)
    model.train()
    running_loss = 0.0
    correct = 0
    total = 0
    for i, data in enumerate(dataloader, 0):
        inputs, labels = data
        inputs, labels = inputs.to(device), labels.to(device)

        optimizer.zero_grad()

        outputs = model(inputs)
        loss = criterion(outputs, labels)
        loss.backward()
        optimizer.step()

        running_loss += loss.item()
        _, predicted = torch.max(outputs.data, 1)
        total += labels.size(0)
        correct += (predicted == labels).sum().item()

    train_loss = running_loss / len(dataloader)
    train_accuracy = 100 * correct / total
    train_losses.append(train_loss)
    train_accuracies.append(train_accuracy)

    print(f"Epoch {epoch+1}/{num_epochs}.. "
          f"Train loss: {train_loss:.3f}.. "
          f"Train accuracy: {train_accuracy:.3f}")

# Plotting training metrics
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.plot(train_losses, label='Train Loss')
plt.legend()
plt.subplot(1, 2, 2)
plt.plot(train_accuracies, label='Train Accuracy')
plt.legend()
plt.savefig('training_metrics_local.png')  # Save the plot
plt.show()

# Save the model, update path for new train
torch.save(model.state_dict(), 'fine_tuned_resnet18.pth')
