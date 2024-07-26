from data_preprocessing.face_detection import *
from data_preprocessing.data_preprocess import *
from training.train_model import *
from training.train_svm_model import *
from evaluation.test_model import *
from evaluation.test_svm_model import *

# set this FLAG for different mode
# Data-Processing: 0
# Training: 1
# Evaluation: 2
FLAG = 2

# set this to the path of the video to decode
PATH_TO_VIDEO = "datasets/videos/Joe 1080_1920 60fps BackCam.MOV"

# set this to name of the person
NAME = "Justin"

# set this to the path of any random image to test
# correct
# IMAGE_PATH = "datasets/processed/train/Joe/face_0000_0.png" # [familiar - correct this is training data]
# IMAGE_PATH = "datasets/raw/bob/face__1136.jpg" # [familiar - correct this is not training data]
# IMAGE_PATH = "datasets/processed/val/Joe/face_0000_2.png" # [familiar - correct this is not training data]
# IMAGE_PATH = "datasets/processed/train/Jack/face_0000_0.png" # [familiar - correct this training data]
# IMAGE_PATH = "datasets/random_test/image_js.png"
IMAGE_PATH = "datasets/random_test/face_1.jpg"
# incorrect
# IMAGE_PATH = "datasets/random_test/face_1.jpg" # [stranger - incorrect this is me]
# IMAGE_PATH = "datasets/random_test/flip.png" [stranger - incorrect this is me]
# IMAGE_PATH = "datasets/raw/Justin/face__229.jpg" # [familiar - incorrect this is justin]
# IMAGE_PATH = "datasets/random_test/IMG_0324.jpg" # [stranger - incorrect this is me]
IMAGE_DIR = "datasets/random_test/joe"

# TODO: this needs to turn into a function after connecting to db
OUTPUT_CLASS_NUMBER = 2

# these are variable to hold the return from training
MODEL_NAME = "resnet_finetuned_20240726_020653.pth"
SVM_MODEL_NAME = "one_class_svm_model_GJ.pkl"
CLASS_LABELS = ['George', 'Justin']
SCALER_NAME = 'scaler_GJ.pkl'

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

# TODO: in future, when connect with db, need to refactor all the data-loading from file based
# to db based
if FLAG == 0:
    # 1. Fetching frames from server's queue (or fetching from db)
    # Will need a db.info to know how many classes of familiar people and the int to str map

    # TODO

    # 2. Extract face and resize to 224*224 and store under datasets/raw/"name"
    # (if doing the test according to note, comment this out)
    # TODO: Try Upperbody detection, YuNet and YOLO for face detection
    # extract(PATH_TO_VIDEO, 1, NAME)
    # extract_faces_from_folders(ROOT_DIR, thread_num="1")

    # 3. Apply transform. For every pic, generate 5 more pictures with transform.
    # Shuffle these pictures and split into dir/train/"name", dir/val/"name",
    # dir/test/"name" (70/15/15), where dir = datasets/processed
    # Note that normalization is applied on-the-fly in train_model so image can display normally
    process_and_split_images(NAME)

elif FLAG == 1:
    # 4. Train
    # class_labels, model_name = train_model(OUTPUT_CLASS_NUMBER)
    # print(class_labels)
    # print(model_name)

    ## TODO: Add training for SVM

    train_svm_model()
elif FLAG == 2:
    # 5. load the just trained model and give it a path to a image and output the result
    # TODO: Add SVM
    # TODO: implement multi-image testing, and combine the result
    # predict_image_class(MODEL_NAME, CLASS_LABELS, OUTPUT_CLASS_NUMBER, IMAGE_PATH)
    # test_svm_model(SVM_MODEL_NAME, SCALER_NAME, IMAGE_PATH)
    test_svm_model_directory(SVM_MODEL_NAME, SCALER_NAME, IMAGE_DIR)
