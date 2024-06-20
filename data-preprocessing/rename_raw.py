# the pictures generted from the video is not in order, running this makes the name nicer
import os

def rename_images(directory):
    """
    Renames image files in the specified directory to a systematic format: face_x.jpg,
    where x is a sequential number starting from 1.
    """
    # Change to the specified directory
    os.chdir(directory)

    # Get a list of all files in the directory
    files = os.listdir()
    counter = 1  # Initialize a counter for numbering the images
    
    destination_directory = os.path.join(directory, "raw")
    os.makedirs(destination_directory, exist_ok=True)

    # Loop through each file in the directory
    for file in files:
        # Check if the file is an image by its extension
        if file.lower().endswith(('.png', '.jpg', '.jpeg', '.gif', '.bmp')):
            new_filename = f"face_{counter}.jpg"

            # Check if the file is already correctly named to avoid reprocessing
            if file != new_filename:
                os.rename(file, os.path.join(destination_directory, new_filename))
                counter += 1  # Increment the counter only if a file is renamed

if __name__ == "__main__":
    # Define the directory containing the raw images
    INPUT_DIR = '../datasets'
    rename_images(INPUT_DIR)
