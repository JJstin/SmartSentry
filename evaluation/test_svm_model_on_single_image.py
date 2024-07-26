import os
import face_recognition
import numpy as np
import joblib
from definitions import ROOT_DIR

def test_svm_model_on_single_image(model_filename, image_path):
    print(f"Testing image: {image_path}")
    
    # Load the image
    image = face_recognition.load_image_file(image_path)
    
    # Detect faces in the image
    face_bounding_boxes = face_recognition.face_locations(image, number_of_times_to_upsample=2, model="cnn")
    
    if len(face_bounding_boxes) != 1:
        print(f"Image {image_path} contains {len(face_bounding_boxes)} faces, skipping.")
        return
    
    # Get face encodings for the detected faces
    face_encodings = face_recognition.face_encodings(image, known_face_locations=face_bounding_boxes)
    
    if not face_encodings:
        print(f"No face encodings found in {image_path}, skipping.")
        return
    
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
        print(f"File: {image_path}, Predicted: {predicted_label}, Probability: {max_probability:.2f}")
    else:
        print(f"File: {image_path}, Predicted: Unfamiliar, closest to class {predicted_label} with {max_probability:.2f} probability")
    
    return predicted_label if max_probability >= 0.90 else "Unknown", max_probability

def test_svm_model_on_list_of_images(model_filename, image_list):
    if not image_list:
        print("No images to process.")
        return
    
    results = []
    for i, image in enumerate(image_list):
        predicted_label, max_probability, result_message = test_svm_model_on_single_image(model_filename, np.array(image))
        results.append({
            'image_index': i,
            'predicted_label': predicted_label,
            'max_probability': max_probability,
            'result_message': result_message
        })
        print(f"Image {i}: {result_message}")
    
    return results
