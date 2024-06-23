import sys
import os
from data_preprocessing.rename_raw import *
from data_preprocessing.transform_raw import *
from data_preprocessing.generate_processed_data import *
from software.human_and_face_detection import detection




# take in person's first name as an argument, starting analyzing all videos 
# for this person and generate processed images
def process_all_for(name):
    # find all videos matching this person
    dirpath = os.path.dirname(__file__)
    video_dir = os.path.join(dirpath, "software", "human_and_face_detection", "videos")
    thread = 0
    for file in os.listdir(video_dir):
        if(file.split(" ")[0].lower() == name):
            detection.extract(os.path.join(video_dir, file), str(thread), name)
            thread += 1

    person_dir = os.path.join(dirpath, "datasets", name)

    # rename images
    rename_images(person_dir)

    # process images
    all_images = process_images(input_dir=os.path.join(person_dir, "ordered"),
     temp_dir=os.path.join(person_dir, "processed_raw"), clear=True)

    # generate
    shuffle(all_images, output_dir=os.path.join(person_dir, "processed"), clear=True)


    
if __name__ == "__main__":
    if len(sys.argv) == 1:
        print("enter a person name for processing")
    else: 
        process_all_for(sys.argv[1].lower())
    