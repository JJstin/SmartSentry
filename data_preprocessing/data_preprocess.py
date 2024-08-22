import os
import shutil
from PIL import Image
from torchvision import transforms
import numpy as np

# Constants
IMAGE_SIZE = 224
ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))

def clear_directory(directory):
    """Clear all files in the given directory."""
    if os.path.exists(directory):
        shutil.rmtree(directory)
    os.makedirs(directory)

def process_and_split_images(name):
    input_dir = os.path.join(ROOT_DIR, 'datasets', 'raw', name)
    temp_dir = os.path.join(ROOT_DIR, 'datasets', 'temp', name)
    output_dir = os.path.join(ROOT_DIR, 'datasets', 'processed')
    train_dir = os.path.join(output_dir, 'train', name)
    val_dir = os.path.join(output_dir, 'val', name)
    test_dir = os.path.join(output_dir, 'test', name)

    # Ensure directories exist
    os.makedirs(temp_dir, exist_ok=True)
    os.makedirs(train_dir, exist_ok=True)
    os.makedirs(val_dir, exist_ok=True)
    os.makedirs(test_dir, exist_ok=True)

    # Clear the output directories
    clear_directory(train_dir)
    clear_directory(val_dir)
    clear_directory(test_dir)

    # Image transformations for augmentation
    transform = transforms.Compose([
        transforms.RandomHorizontalFlip(),
        transforms.RandomRotation(10),
        transforms.ColorJitter(brightness=0.2, contrast=0.2),
        transforms.RandomResizedCrop(IMAGE_SIZE, scale=(0.8, 1.0), ratio=(1.0, 1.0)),
        transforms.ToTensor()
    ])

    def augment_images(input_dir, temp_dir):
        filenames = os.listdir(input_dir)
        all_images = []

        for i, filename in enumerate(filenames):
            if filename.lower().endswith(('.png', '.jpg', '.jpeg')):
                with Image.open(os.path.join(input_dir, filename)) as img:
                    img = img.convert('RGB')  # Ensure image is RGB
                    img = img.resize((IMAGE_SIZE, IMAGE_SIZE), Image.LANCZOS)
                    base_filename = f'face_{i:04d}.png'
                    img_path = os.path.join(temp_dir, base_filename)
                    img.save(img_path)
                    all_images.append(img_path)

                    # Generate additional images via augmentation
                    for j in range(5):  # Generate 5 augmented images per original
                        augmented_image = transform(img)
                        augmented_path = os.path.join(temp_dir, f'face_{i:04d}_{j}.png')
                        transforms.ToPILImage()(augmented_image).save(augmented_path)
                        all_images.append(augmented_path)

        return all_images

    def split_data(all_images):
        # Shuffle images
        np.random.shuffle(all_images)

        train_size = int(0.7 * len(all_images))
        val_size = int(0.15 * len(all_images))

        train_images = all_images[:train_size]
        val_images = all_images[train_size:train_size + val_size]
        test_images = all_images[train_size + val_size:]

        return train_images, val_images, test_images

    def move_images(images, target_dir):
        for image_path in images:
            shutil.move(image_path, os.path.join(target_dir, os.path.basename(image_path)))

    # Process and collect all images in a temp directory
    all_images = augment_images(input_dir, temp_dir)

    # Split the dataset into train, validation, and test sets
    train_images, val_images, test_images = split_data(all_images)

    # Move images to respective directories
    move_images(train_images, train_dir)
    move_images(val_images, val_dir)
    move_images(test_images, test_dir)

    # Clear the temp directory
    clear_directory(temp_dir)
    os.removedirs(temp_dir)

if __name__ == "__main__":
    name = "justin"  # Change this to the appropriate name
    process_and_split_images(name)
