# apply random transofrmation to raw images
import os
import shutil
from PIL import Image
from torchvision import transforms
import argparse

# Constants
IMAGE_SIZE = 160
ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
INPUT_DIR = os.path.join(ROOT_DIR, 'datasets', 'joe', 'ordered')
TEMP_DIR = os.path.join(ROOT_DIR, 'datasets', 'joe', 'processed_raw')  # Directory to store all transformed raw images

# Image transformations for augmentation
transform = transforms.Compose([
    transforms.RandomHorizontalFlip(),
    transforms.RandomRotation(10),
    transforms.ColorJitter(brightness=0.2, contrast=0.2),
    transforms.RandomResizedCrop(IMAGE_SIZE, scale=(0.8, 1.0), ratio=(1.0, 1.0)),
    transforms.ToTensor()
])

def clear_directory(directory):
    """Clear all files in the given directory."""
    # if os.path.exists(directory):
    #     for filename in os.listdir(directory):
    #         file_path = os.path.join(directory, filename)
    #         if os.path.isfile(file_path) or os.path.islink(file_path):
    #             os.unlink(file_path)
    #         elif os.path.isdir(file_path):
    #             shutil.rmtree(file_path)
    if not os.path.exists(directory) or not os.path.isdir(directory):
        return
    shutil.rmtree(directory)
    os.makedirs(directory)

def process_images(input_dir, temp_dir, augment=True, clear=False):
    # Ensure directories exist
    if clear:
        clear_directory(TEMP_DIR)
    os.makedirs(TEMP_DIR, exist_ok=True)
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

                if augment:
                    # Generate additional images via augmentation
                    img = transforms.ToPILImage()(transform(img))
                    for j in range(5):  # Generate 5 augmented images per original
                        augmented_image = transform(img)
                        augmented_path = os.path.join(temp_dir, f'face_{i:04d}_{j}.png')
                        transforms.ToPILImage()(augmented_image).save(augmented_path)
                        all_images.append(augmented_path)

    return all_images

if __name__ == "__main__":
    # Parse command-line arguments
    parser = argparse.ArgumentParser(description="Process raw images and save to temp directory.")
    parser.add_argument('--clear_temp', action='store_true', help="Clear the temporary directory before processing")
    args = parser.parse_args()

    # Clear the temp directory if the flag is set
    clear = False
    if args.clear_temp:
        clear = True

    # Process and collect all images in a temp directory
    process_images(INPUT_DIR, TEMP_DIR, augment=True, clear=clear)


