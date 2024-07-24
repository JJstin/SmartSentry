from data_preprocessing.face_detection import *
from data_preprocessing.data_preprocess import *
from training.train_model import *
from evaluation.test_model import *

FLAG = 2

# set this to the path of the video to decode
PATH_TO_VIDEO = "videos/Joe 1080_1920 60fps BackCam.MOV"

# set this to name of the person
NAME = "Joe"

# set this to the path of any random image to test
IMAGE_PATH = "datasets/random_test/face_1.jpg"

# TODO: this needs to turn into a function after connecting to db
OUTPUT_CLASS_NUMBER = 2

# these are variable to hold the return from training
MODEL_NAME = "resnet_finetuned.pth"
CLASS_LABELS = ['jack', 'bob']

# NOTE: to test the flow WITHOUT analysing video, create a sub-folder, raw, under datasets,
# add two subfolders called jack and bob, and put two images in each of jack and bob
# The dir should look like following
# root_directory/
# ├── datasets/
# │   ├── raw/
# │   │   ├── jack/
# │   │   │   ├── image1.jpg
# │   │   │   └── image2.jpg
# │   │   ├── bob/
# │   │   │   ├── image1.jpg
# │   │   │   └── image2.jpg

if FLAG == 0:
    # 1. Fetching frames from server's queue (or fetching from db)
    # Will need a db.info to know how many classes of familiar people and the int to str map

    # TODO

    # 2. Extract face and resize to 224*224 and store under datasets/raw/"name"
    # (if doing the test according to note, comment this out)
    extract(PATH_TO_VIDEO, 1, NAME)

    # 3. Apply transform. For every pic, generate 5 more pictures with transform.
    # Shuffle these pictures and split into dir/train/"name", dir/val/"name",
    # dir/test/"name" (70/15/15), where dir = datasets/processed
    # Note that normalization is applied on-the-fly in train_model so image can display normally
    process_and_split_images(NAME)

elif FLAG == 1:
    # 4. Train
    class_labels, model_name = train_model(OUTPUT_CLASS_NUMBER)
    print(class_labels)
    print(model_name)

elif FLAG == 2:
    # 5. load the just trained model and give it a path to a image and output the result
    predict_image_class(MODEL_NAME, CLASS_LABELS, OUTPUT_CLASS_NUMBER, IMAGE_PATH)
