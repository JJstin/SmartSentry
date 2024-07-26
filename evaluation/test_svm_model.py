import torch
import torch.nn as nn
import torchvision.transforms as transforms
from torchvision.models import resnet18, ResNet18_Weights
from PIL import Image
import joblib  # For loading the SVM model
import numpy as np
import os

# Define the necessary transformations
transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor(),
    transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])
])

def load_resnet_model():
    # Initialize the model with pre-trained weights
    model = resnet18(weights=ResNet18_Weights.IMAGENET1K_V1)

    # Modify the fully connected layer to output features instead of classification scores
    num_features = model.fc.in_features
    model.fc = nn.Identity()  # Remove the fully connected layer

    # Set device
    device = torch.device("cuda" if torch.cuda.is_available() else "mps" if torch.backends.mps.is_available() else "cpu")
    model.to(device)

    return model, device

def extract_features(model, image, device):
    model.eval()
    with torch.no_grad():
        image = image.to(device)
        features = model(image)
    return features.cpu().numpy()

def flatten_features(features):
    return features.reshape(features.shape[0], -1)

def predict_with_svm(resnet_model, svm_model, scaler, device, image_path):
    image = Image.open(image_path).convert('RGB')
    image = transform(image)
    image = image.unsqueeze(0)  # Add batch dimension

    image = image.to(device)
    with torch.no_grad():
        # Extract features using the model
        features = extract_features(resnet_model, image, device)
    
    # Flatten the features
    features = flatten_features(features)

    # Standardize the features
    features = scaler.transform(features)
    
    # Predict if the features represent a familiar face
    is_familiar = svm_model.predict(features)

    return is_familiar

def test_svm_model(svm_model_path, scaler_path, image_path):
    resnet_model, device = load_resnet_model()
    svm_model = joblib.load(svm_model_path)
    scaler = joblib.load(scaler_path)
    
    is_familiar = predict_with_svm(resnet_model, svm_model, scaler, device, image_path)

    if is_familiar == -1:
        print(f"The person in the image is a stranger.")
    else:
        print(f"The person in the image is familiar.")

# Example usage
if __name__ == "__main__":
    import sys

    if len(sys.argv) != 4:
        print("Usage: python test_svm_model.py <svm_model_path> <scaler_path> <image_path>")
        sys.exit(1)

    svm_model_path = sys.argv[1]
    scaler_path = sys.argv[2]
    image_path = sys.argv[3]

    if not os.path.exists(svm_model_path):
        print(f"SVM model path {svm_model_path} does not exist.")
        sys.exit(1)

    if not os.path.exists(scaler_path):
        print(f"Scaler path {scaler_path} does not exist.")
        sys.exit(1)

    if not os.path.exists(image_path):
        print(f"Image path {image_path} does not exist.")
        sys.exit(1)

    test_svm_model(svm_model_path, scaler_path, image_path)
