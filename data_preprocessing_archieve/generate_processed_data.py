# This randomly picks x images from (each person's) transformed raw data and split into
# training set (70%), cross-validation set (15%), and testing set (15%)
import os
import numpy as np
from sklearn.model_selection import train_test_split
import argparse
import shutil

# Constants
ROOT_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
TEMP_DIR = os.path.join(ROOT_DIR, 'datasets', 'joe', 'processed_raw')  # Temporary directory to store all images


def clear_directory(directory):
    """Clear all files in the given directory."""
    if not os.path.exists(directory) or not os.path.isdir(directory):
        return
    shutil.rmtree(directory)
    os.makedirs(directory)

def split_data(all_images, x):
    # Shuffle and pick the first x images if x is specified and less than total images
    np.random.shuffle(all_images)
    if x is not None and x < len(all_images):
        all_images = all_images[:x]

    train_size = int(0.7 * len(all_images))
    val_size = int(0.15 * len(all_images))
    test_size = len(all_images) - train_size - val_size

    train_images = all_images[:train_size]
    val_images = all_images[train_size:train_size + val_size]
    test_images = all_images[train_size + val_size:]

    return train_images, val_images, test_images

# Function to move images to their respective directories
def move_images(images, target_dir):
    for image_path in images:
        os.rename(image_path, os.path.join(target_dir, os.path.basename(image_path)))

def shuffle(all_images, max=None, output_dir=None, clear=False):
    OUTPUT_DIR = os.path.join(ROOT_DIR, 'datasets', 'joe', 'processed')
    if output_dir:
        OUTPUT_DIR = output_dir
    TRAIN_DIR = os.path.join(OUTPUT_DIR, 'train')
    VAL_DIR = os.path.join(OUTPUT_DIR, 'val')
    TEST_DIR = os.path.join(OUTPUT_DIR, 'test')

    if clear:
        clear_directory(TRAIN_DIR)
        clear_directory(VAL_DIR)
        clear_directory(TEST_DIR)

    # Ensure directories exist
    os.makedirs(TRAIN_DIR, exist_ok=True)
    os.makedirs(VAL_DIR, exist_ok=True)
    os.makedirs(TEST_DIR, exist_ok=True)

    # Split the dataset into train, validation, and test sets
    train_images, val_images, test_images = split_data(all_images, max)

    # Move images to respective directories
    move_images(train_images, TRAIN_DIR)
    move_images(val_images, VAL_DIR)
    move_images(test_images, TEST_DIR)


if __name__ == "__main__":
    # Parse command-line arguments
    parser = argparse.ArgumentParser(description="Generate training, validation, and test sets from temp directory.")
    parser.add_argument('--x', type=int, default=None, help="Number of images to use from the temp data")
    parser.add_argument('--clear_output', action='store_true', help="Clear the output directories before generating sets")
    args = parser.parse_args()

    # Clear the output directories if the flag is set
    clear = True if args.clear_output else False
       

    # Collect all images from the temp directory
    all_images = [os.path.join(TEMP_DIR, f) for f in os.listdir(TEMP_DIR) if os.path.isfile(os.path.join(TEMP_DIR, f))]
    shuffle(all_images, output_dir=None, max=args.x, clear=clear)
