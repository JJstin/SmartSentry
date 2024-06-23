# the pictures generted from the video is not in order, running this makes the name nicer
import os
import shutil

def rename_images(directory):
    """
    Renames image files in the specified directory to a systematic format: face_x.jpg,
    where x is a sequential number starting from 1.
    """

    # Get a list of all files in the directory
    input_dir = os.path.join(directory, "raw")
    files = os.listdir(input_dir)
    counter = 1  # Initialize a counter for numbering the images
    
    destination_directory = os.path.join(directory, "ordered")
    if os.path.exists(destination_directory):
        shutil.rmtree(destination_directory)
    os.makedirs(destination_directory, exist_ok=True)

    # Loop through each file in the directory
    for file in files:
        # Check if the file is an image by its extension
        if file.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp')):
            new_filename = f"face_{counter}.jpg"
            shutil.move(os.path.join(input_dir, file), os.path.join(destination_directory, new_filename))
            counter += 1

if __name__ == "__main__":
    # Define the directory containing the raw images
    INPUT_DIR = '../datasets/joe'
    rename_images(INPUT_DIR)
