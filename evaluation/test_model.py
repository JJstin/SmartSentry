import torch
import torch.nn as nn
import torchvision.transforms as transforms
from torchvision.models import resnet18
from PIL import Image
import sys
import os

# Define the necessary transformations
transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor(),
    transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])
])

# Define the class names, UPDATE this based on usecase

# class_names = ['joe', 'justin']
# num_classes = 2

class_names = ['face', 'streetview', 'animal', 'joe']
num_classes = 4

# Load the saved model
model = resnet18(weights=None)  # Initialize the model without pre-trained weights
model.fc = nn.Linear(model.fc.in_features, num_classes)

# Load model, UPDATE this based on usecase

# model.load_state_dict(torch.load('fine_tuned_resnet18_local.pth')) # 2-classes model
model.load_state_dict(torch.load('fine_tuned_resnet18.pth')) # 4-classes model

model.eval()

# Set device
device = torch.device("cuda" if torch.cuda.is_available() else "mps")
model.to(device)

def predict(image_path):
    image = Image.open(image_path).convert('RGB')
    image = transform(image)
    image = image.unsqueeze(0)  # Add batch dimension

    image = image.to(device)
    with torch.no_grad():
        outputs = model(image)
        probabilities = torch.softmax(outputs, dim=1)
        _, predicted = torch.max(probabilities, 1)
        predicted_class = class_names[predicted.item()]
        class_probabilities = probabilities.cpu().numpy()[0]

    return predicted_class, class_probabilities

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python test_model.py <image_path>")
        sys.exit(1)

    image_path = sys.argv[1]
    if not os.path.exists(image_path):
        print(f"Image path {image_path} does not exist.")
        sys.exit(1)

    predicted_class, class_probabilities = predict(image_path)
    print(f"Predicted Class: {predicted_class}")
    for i, prob in enumerate(class_probabilities):
        print(f"{class_names[i]}: {prob:.4f}")
