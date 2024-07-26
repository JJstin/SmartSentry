import torch
import torch.nn as nn
import torchvision.transforms as transforms
from torchvision.models import resnet18, ResNet18_Weights
from torch.utils.data import DataLoader
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.svm import OneClassSVM
import joblib  # For saving and loading the SVM model
from torchvision.datasets import ImageFolder
import os

# Define the feature extraction function
def extract_features(model, dataloader, device):
    model.eval()
    features = []
    with torch.no_grad():
        for inputs, _ in dataloader:
            inputs = inputs.to(device)
            outputs = model(inputs)
            features.extend(outputs.cpu().numpy())
    return np.array(features)

def flatten_features(features):
    return features.reshape(features.shape[0], -1)

def train_svm_model():
    # Set the device
    device = torch.device("cuda" if torch.cuda.is_available() else "mps" if torch.backends.mps.is_available() else "cpu")

    # Load the pretrained ResNet model
    resnet = resnet18(weights=ResNet18_Weights.IMAGENET1K_V1)

    # Modify the fully connected layer to output features instead of classification scores
    num_features = resnet.fc.in_features
    resnet.fc = nn.Identity()  # Remove the fully connected layer

    resnet = resnet.to(device)

    # Define the transforms
    transform = transforms.Compose([
        transforms.Resize((224, 224)),
        transforms.ToTensor(),
        transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225]),
    ])

    # Load the dataset
    dataset = ImageFolder(root='datasets/processed/train', transform=transform)
    dataloader = DataLoader(dataset, batch_size=32, shuffle=True)

    # Extract features from the training dataset
    train_features = extract_features(resnet, dataloader, device)

    # Flatten the features
    train_features = flatten_features(train_features)

    # Standardize the features
    scaler = StandardScaler()
    train_features = scaler.fit_transform(train_features)

    # Train the One-Class SVM on the extracted features
    svm_model = OneClassSVM(gamma='auto', kernel='rbf', nu=0.1)
    svm_model.fit(train_features)

    # Save the SVM model and the scaler
    svm_model_filename = 'one_class_svm_model.pkl'
    scaler_filename = 'scaler.pkl'
    joblib.dump(svm_model, svm_model_filename)
    joblib.dump(scaler, scaler_filename)

    print(f"One-Class SVM model trained and saved as {svm_model_filename}")
    print(f"Scaler saved as {scaler_filename}")

if __name__ == "__main__":
    train_svm_model()
