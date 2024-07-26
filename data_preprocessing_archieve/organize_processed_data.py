# this may not be useful, after the sub-dir thing is done
import os

def organize_images(base_dir, person_name):
    class_dir = os.path.join(base_dir, person_name)
    os.makedirs(class_dir, exist_ok=True)

    # Move all images into the class-specific directory
    for item in os.listdir(base_dir):
        if item.lower().endswith(('.png', '.jpg', '.jpeg')):
            os.rename(os.path.join(base_dir, item), os.path.join(class_dir, item))

# Usage
person_name = 'Joe'  # Change as appropriate
organize_images('../datasets/processed/train', person_name)
organize_images('../datasets/processed/val', person_name)
organize_images('../datasets/processed/test', person_name)
