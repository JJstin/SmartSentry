import os
import face_recognition
import numpy as np
import joblib
import glob
from tqdm import tqdm
from definitions import ROOT_DIR

def test_svm_model_on_single_image(model_filename, image_path):
    print(f"Testing image: {image_path}")
    
    # Load the image
    image = face_recognition.load_image_file(image_path)
    
    # Detect faces in the image
    face_bounding_boxes = face_recognition.face_locations(image, number_of_times_to_upsample=2, model="cnn")
    
    if len(face_bounding_boxes) != 1:
        print(f"Image {image_path} contains {len(face_bounding_boxes)} faces, skipping.")
        return None, None, None
    
    # Get face encodings for the detected faces
    face_encodings = face_recognition.face_encodings(image, known_face_locations=face_bounding_boxes)
    
    if not face_encodings:
        print(f"No face encodings found in {image_path}, skipping.")
        return None, None, None
    
    face_encoding = face_encodings[0]
    
    # Load the trained SVM model
    svm_model = joblib.load(model_filename)
    
    # Predict using the SVM model
    face_encoding = face_encoding.reshape(1, -1)
    probabilities = svm_model.predict_proba(face_encoding)[0]
    max_prob_index = np.argmax(probabilities)
    predicted_label = svm_model.classes_[max_prob_index]
    max_probability = probabilities[max_prob_index]
    
    if max_probability >= 0.90:
        result_message = f"File: {image_path}, Predicted: {predicted_label}, Probability: {max_probability:.2f}"
        print(f"File: {image_path}, Predicted: {predicted_label}, Probability: {max_probability:.2f}")
    else:
        result_message = f"File: {image_path}, Predicted: Unfamiliar, closest to class {predicted_label} with {max_probability:.2f} probability"
        print(f"File: {image_path}, Predicted: Unfamiliar, closest to class {predicted_label} with {max_probability:.2f} probability")
    
    return predicted_label if max_probability >= 0.90 else "Unknown", max_probability, result_message


def test_svm_model_on_folder(model_filename, folder_path):
    image_files = glob.glob(os.path.join(folder_path, '*.jpg')) + glob.glob(os.path.join(folder_path, '*.png'))
    
    if not image_files:
        print(f"No images found in {folder_path}.")
        return

    print(f"Found {len(image_files)} images in {folder_path}.")
    results = []

    for image_file in tqdm(image_files, desc=f'Processing images in {folder_path}'):
        predicted_label, max_probability, result_message = test_svm_model_on_single_image(model_filename, image_file)
        if predicted_label is not None:
            results.append({
                'predicted_label': predicted_label,
                'max_probability': max_probability,
                'result_message': result_message
            })
    
    if results:
        average_probability = np.mean([r['max_probability'] for r in results])
        most_common_label = max(set([r['predicted_label'] for r in results]), key=[r['predicted_label'] for r in results].count)
        print(f"Average probability: {average_probability:.2f}")
        print(f"Most common label: {most_common_label}")
        final_outcome = most_common_label if average_probability >= 0.90 else "Unknown"
        print(f"Final outcome for folder: {final_outcome}")
    else:
        final_outcome = "Unknown"
        print("No faces were recognized in the folder.")
    
    return final_outcome


def test_svm_model_on_list_of_images(model_filename, image_list):
    if not image_list:
        print("No images to process.")
        return
    
    results = []
    for i, image in enumerate(image_list):
        predicted_label, max_probability, result_message = test_svm_model_on_single_image(model_filename, np.array(image))
        if predicted_label is not None:
            results.append({
                'predicted_label': predicted_label,
                'max_probability': max_probability,
                'result_message': result_message
            })
        print(f"Image {i}: {result_message}")
    
    if results:
        average_probability = np.mean([r['max_probability'] for r in results])
        most_common_label = max(set([r['predicted_label'] for r in results]), key=[r['predicted_label'] for r in results].count)
        print(f"Average probability: {average_probability:.2f}")
        print(f"Most common label: {most_common_label}")
        final_outcome = most_common_label if average_probability >= 0.90 else "Unknown"
        print(f"Final outcome for list of images: {final_outcome}")
    else:
        final_outcome = "Unknown"
        print("No faces were recognized in the list of images.")
    
    return final_outcome


if __name__ == "__main__":
    model_filename = 'face_recognition_svm_model.pkl'
    folder_path = os.path.join(ROOT_DIR, 'datasets/random_test')
    
    if not os.path.exists(folder_path):
        print(f"Folder {folder_path} does not exist.")
        exit()
    
    final_outcome_folder = test_svm_model_on_folder(model_filename, folder_path)
    print(f"Final outcome for the folder: {final_outcome_folder}")

    # Example usage for list of images
    image_list = [...]  # Your list of images here
    final_outcome_list = test_svm_model_on_list_of_images(model_filename, image_list)
    print(f"Final outcome for the list of images: {final_outcome_list}")
