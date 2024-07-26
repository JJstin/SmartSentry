import os
from PIL import Image

# Function to resize images and save them back
def resize_and_save(image, save_dir, base_name, size=(224, 224)):
    img = image.resize(size)
    save_path = os.path.join(save_dir, base_name)
    img.save(save_path)
    return save_path

# Create a directory to store resized images
temp_dir = 'temp_images'
os.makedirs(temp_dir, exist_ok=True)

# Directory containing xxx's images, change
images_path = 'datasets/raw/justin'
save_dir = 'datasets/resized/justin'
os.makedirs(save_dir, exist_ok=True)

# Resize images and collect their new paths
images = [resize_and_save(Image.open(os.path.join(images_path, img)), save_dir, img) for img in os.listdir(images_path) if img.endswith(('jpg', 'jpeg', 'png'))]
