import torch
import torch.nn as nn
import torchvision.transforms as transforms
from torchvision.models import resnet18
from PIL import Image
import os
import numpy as np

# Define the necessary transformations
transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor(),
    transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])
])

import torch
import torch.nn as nn
from torchvision.models import resnet18, ResNet18_Weights

def load_model(model_path, num_classes):
    # Initialize the model with pre-trained weights
    model = resnet18(weights=ResNet18_Weights.IMAGENET1K_V1)

    # Unfreeze the last 3 layers
    for param in model.parameters():
        param.requires_grad = False

    for param in list(model.parameters())[-6:]:
        param.requires_grad = True

    # Modify the fully connected layer
    num_features = model.fc.in_features
    model.fc = nn.Sequential(
        nn.Linear(num_features, 512),
        nn.ReLU(),
        nn.Dropout(0.5),
        nn.Linear(512, 256),
        nn.ReLU(),
        nn.Linear(256, num_classes)
    )

    # Load the model weights
    model.load_state_dict(torch.load(model_path))
    model.eval()

    # Set device
    device = torch.device("cuda" if torch.cuda.is_available() else "mps" if torch.backends.mps.is_available() else "cpu")
    model.to(device)

    return model, device


def predict(model, device, class_names, images):
    # Initialize a dictionary to count class votes
    class_votes = {class_name: 0 for class_name in class_names}
    combined_probabilities = np.zeros(len(class_names))

    for im in images:
        image = transform(im)
        image = image.unsqueeze(0)  # Add batch dimension
        image = image.to(device)

        with torch.no_grad():
            outputs = model(image)
            probabilities = torch.softmax(outputs, dim=1)
            _, predicted = torch.max(probabilities, 1)
            predicted_class = class_names[predicted.item()]
            class_votes[predicted_class] += 1
            combined_probabilities += probabilities.cpu().numpy()[0]

    # Find the class with the most votes
    most_voted_class = max(class_votes, key=class_votes.get)
    print("max vote is:", most_voted_class)
    average_probabilities = combined_probabilities / len(images)

    return most_voted_class, average_probabilities

# Example usage
if __name__ == "__main__":
    import sys

    if len(sys.argv) != 5:
        print("Usage: python test_model.py <model_path> <num_classes> <class_labels> <image_path>")
        sys.exit(1)

    model_path = sys.argv[1]
    num_classes = int(sys.argv[2])
    class_labels = sys.argv[3].split(',')
    image_path = sys.argv[4]

    if not os.path.exists(model_path):
        print(f"Model path {model_path} does not exist.")
        sys.exit(1)

    if not os.path.exists(image_path):
        print(f"Image path {image_path} does not exist.")
        sys.exit(1)

    model, device = load_model(model_path, num_classes)
    predicted_class, class_probabilities = predict(model, device, class_labels, image_path)
    print(f"Predicted Class: {predicted_class}")
    for i, prob in enumerate(class_probabilities):
        print(f"{class_labels[i]}: {prob:.4f}")

def predict_image_class(model_path, class_labels, num_classes, image_path):
    model, device = load_model(model_path, num_classes)
    # predicted_class, class_probabilities = predict(model, device, class_labels, image_path)

    predicted_class, class_probabilities = predict(model, device, class_labels, get_images(image_path))

    print(f"Predicted Class: {predicted_class}")
    for i, prob in enumerate(class_probabilities):
        print(f"{class_labels[i]}: {prob:.4f}")
    return predicted_class, class_probabilities

# TODO: change this to fetch a list of images from the server's queue
def get_images(image_path):
    return [Image.open(image_path).convert('RGB'), Image.open(image_path).convert('RGB'), Image.open(image_path).convert('RGB')]
