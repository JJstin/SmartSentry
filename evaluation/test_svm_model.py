import os
import glob
import face_recognition
import numpy as np
import joblib
from tqdm import tqdm
from definitions import ROOT_DIR

def load_images_from_folder(folder):
    images = []
    labels = []
    class_names = os.listdir(folder)
    if not class_names:
        print(f"No class directories found in {folder}.")
    for class_name in class_names:
        class_folder = os.path.join(folder, class_name)
        if os.path.isdir(class_folder):
            image_files = glob.glob(os.path.join(class_folder, '*.jpg')) + glob.glob(os.path.join(class_folder, '*.png'))
            if not image_files:
                print(f"No images found in {class_folder}.")
            else:
                print(f"Found {len(image_files)} images in {class_folder}.")
            for image_file in tqdm(image_files, desc=f'Loading {class_name} images'):
                image = face_recognition.load_image_file(image_file)
                face_bounding_boxes = face_recognition.face_locations(image)
                if len(face_bounding_boxes) == 1:  # Ensure only one face per image
                    face_encodings = face_recognition.face_encodings(image, known_face_locations=face_bounding_boxes)
                    if face_encodings:
                        images.append(face_encodings[0])
                        labels.append(class_name)
    return images, labels

def test_svm_model(model_filename, test_folder):
    print(f"Loading test images from {test_folder}...")
    test_images, test_labels = load_images_from_folder(test_folder)

    if not test_images:
        print("No images found or no faces detected in the images.")
        return

    print("Number of test images loaded:", len(test_images))
    print("Loading the SVM model...")
    svm_model = joblib.load(model_filename)

    print("Predicting test images...")
    X_test = np.array(test_images)
    y_test = np.array(test_labels)

    correct_predictions = 0
    total_predictions = len(y_test)

    for i in range(total_predictions):
        face_embedding = X_test[i].reshape(1, -1)
        label = y_test[i]

        probabilities = svm_model.predict_proba(face_embedding)[0]
        max_prob_index = np.argmax(probabilities)
        predicted_label = svm_model.classes_[max_prob_index]
        max_probability = probabilities[max_prob_index]

        if max_probability >= 0.9:  # Set threshold for recognition
            if predicted_label == label:
                correct_predictions += 1
            print(f"Predicted: {predicted_label}, Actual: {label}, Probability: {max_probability:.2f}")
        else:
            print(f"Face not found! Actual: {label}")

    accuracy = correct_predictions / total_predictions
    print(f"Accuracy: {accuracy:.2%}")

if __name__ == "__main__":
    model_filename = 'face_recognition_svm_model.pkl'
    test_folder = os.path.join(ROOT_DIR, 'datasets/processed/test')
    if not os.path.exists(test_folder):
        print(f"Test folder {test_folder} does not exist.")
    else:
        test_svm_model(model_filename, test_folder)
