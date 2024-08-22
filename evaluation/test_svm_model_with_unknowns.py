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
    filenames = []
    image_files = glob.glob(os.path.join(folder, '*.jpg')) + glob.glob(os.path.join(folder, '*.png'))
    if not image_files:
        print(f"No images found in {folder}.")
    else:
        print(f"Found {len(image_files)} images in {folder}.")
    for image_file in tqdm(image_files, desc=f'Loading images from {folder}'):
        print(f"Processing file: {image_file}")
        image = face_recognition.load_image_file(image_file)
        face_bounding_boxes = face_recognition.face_locations(image, number_of_times_to_upsample=2, model="cnn")
        print(f"Found {len(face_bounding_boxes)} faces in file: {image_file}")
        if face_bounding_boxes:
            face_encodings = face_recognition.face_encodings(image, known_face_locations=face_bounding_boxes)
            if face_encodings:
                images.append(face_encodings[0])
                labels.append('unknown')
                filenames.append(image_file)
            else:
                print(f"No face encodings found in file: {image_file}")
        else:
            print(f"No faces found in file: {image_file}, trying to proceed with the whole image.")
            face_encodings = face_recognition.face_encodings(image)
            if face_encodings:
                images.append(face_encodings[0])
                labels.append('unknown')
                filenames.append(image_file)
            else:
                print(f"Still no face encodings found in file: {image_file}.")
    return images, labels, filenames

def test_svm_model_on_unknowns(model_filename, unknown_folders):
    test_images = []
    test_labels = []
    test_filenames = []

    total_unknown_images = 0
    for unknown_folder in unknown_folders:
        print(f"Loading unknown images from {unknown_folder}...")
        unknown_images, unknown_labels, unknown_filenames = load_images_from_folder(unknown_folder)
        total_unknown_images += len(unknown_images)

        test_images.extend(unknown_images)
        test_labels.extend(unknown_labels)
        test_filenames.extend(unknown_filenames)

    print(f"Total unknown images loaded: {total_unknown_images}")
    print(f"Total test images after including unknowns: {len(test_images)}")

    if not test_images:
        print("No images found or no faces detected in the images.")
        return

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
        filename = test_filenames[i]

        probabilities = svm_model.predict_proba(face_embedding)[0]
        max_prob_index = np.argmax(probabilities)
        predicted_label = svm_model.classes_[max_prob_index]
        max_probability = probabilities[max_prob_index]

        if max_probability >= 0.90:  # Set threshold for recognition
            if predicted_label == label:
                correct_predictions += 1
            print(f"File: {filename}, Predicted: {predicted_label} Probability: {max_probability:.2f}, Actual: {label}")
        else:
            if label == 'unknown':
                correct_predictions += 1  # Correctly identified as unknown
            print(f"File: {filename}, Face not found! Actual: {label}")

    accuracy = correct_predictions / total_predictions
    print(f"Accuracy: {accuracy:.2%}")

if __name__ == "__main__":
    model_filename = 'face_recognition_svm_model.pkl'
    unknown_folders = [
        os.path.join(ROOT_DIR, 'datasets/random_test/Xavier'),
        os.path.join(ROOT_DIR, 'datasets/random_test/joe'),
        os.path.join(ROOT_DIR, 'datasets/random_test/yifei')
    ]
    for unknown_folder in unknown_folders:
        if not os.path.exists(unknown_folder):
            print(f"Unknown folder {unknown_folder} does not exist.")
            exit()
    test_svm_model_on_unknowns(model_filename, unknown_folders)
