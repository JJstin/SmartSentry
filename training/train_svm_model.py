import os
import glob
import numpy as np
import joblib
import face_recognition
from sklearn.svm import SVC
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from tqdm import tqdm
from definitions import ROOT_DIR

def load_images_and_labels(folder):
    images = []
    labels = []
    class_names = os.listdir(folder)
    for class_name in class_names:
        class_folder = os.path.join(folder, class_name)
        if os.path.isdir(class_folder):
            image_files = glob.glob(os.path.join(class_folder, '*.jpg')) + glob.glob(os.path.join(class_folder, '*.png'))
            for image_file in tqdm(image_files, desc=f'Loading {class_name} images'):
                image = face_recognition.load_image_file(image_file)
                face_bounding_boxes = face_recognition.face_locations(image)
                if len(face_bounding_boxes) == 1:
                    face_encodings = face_recognition.face_encodings(image, known_face_locations=face_bounding_boxes)
                    if face_encodings:
                        images.append(face_encodings[0])
                        labels.append(class_name)
    return images, labels

def train_svm_model(train_folder):
    print(f"Loading training images from {train_folder}...")
    X_train, y_train = load_images_and_labels(train_folder)

    if not X_train:
        print("No images found or no faces detected in the training data.")
        return

    print("Creating face embeddings...")
    X_train = np.array(X_train)
    y_train = np.array(y_train)

    print("Training SVM model...")
    svm_model = Pipeline([
        ('scaler', StandardScaler()),
        ('svc', SVC(kernel='linear', probability=True))
    ])
    svm_model.fit(X_train, y_train)

    model_filename = 'face_recognition_svm_model.pkl'
    joblib.dump(svm_model, model_filename)
    print(f"SVM model saved as {model_filename}")

if __name__ == "__main__":
    train_folder = os.path.join(ROOT_DIR, "datasets/processed/train")
    train_svm_model(train_folder)
