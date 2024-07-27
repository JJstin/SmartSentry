import cv2
import os
import shutil
import sys
import time
from deepface import DeepFace
from PIL import Image
from definitions import ROOT_DIR

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.dirname(os.path.dirname(current_dir))
sys.path.append(project_root)

def extract_list_of_images(images):
    if images is None:
        print("error: empty image list")
        return

    face_images = []
    for frame in images:
        faces = DeepFace.extract_faces(frame, detector_backend='yolov8', enforce_detection = False)

        for face in faces:
            face_rect = face["facial_area"]
            x, y, w, h = face_rect["x"], face_rect["y"], face_rect["w"], face_rect["h"]
            # Perform aspect ratio check (assuming face boxes are more square)
            if not 0.75 < w/h < 1.33:
                continue

            face_frame = frame[y:y+h, x:x+w]
            # Resize the face frame to 224x224, convert from numpy array to PIL image
            resized_face_frame = cv2.resize(face_frame, (224, 224))

            face_images.append(resized_face_frame)
    return face_images


def extract(path_to_video=None, thread_num="", name="joe"):
    # Directory to save frames with detected faces
    save_dir = os.path.join(ROOT_DIR, "datasets", "raw", name)

    print(save_dir)

    if os.path.exists(save_dir):
        shutil.rmtree(save_dir)
    os.makedirs(save_dir)

    start = time.time()
    # Feel free to replace the name of the video here with one in the directory
    if path_to_video:
        cap = cv2.VideoCapture(path_to_video)
    else:
        video = 'Joe 1080_1920 60fps BackCam.MOV'
        cap = cv2.VideoCapture(os.path.join("..", "datasets", "videos", video))

    if not cap.isOpened():
        print("Error: Could not open video.")
        exit()

    frame_index = 1
    img_index = 1

    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            print("End of video or error in reading video.")
            break

        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

        # Detect faces in the frame
        faces = DeepFace.extract_faces(frame, detector_backend='yolov8', enforce_detection = False)

        for face in faces:
            face_rect = face["facial_area"]
            x, y, w, h = face_rect["x"], face_rect["y"], face_rect["w"], face_rect["h"]
            # Perform aspect ratio check (assuming face boxes are more square)
            if not 0.75 < w/h < 1.33:
                continue

            face_frame = frame[y:y+h, x:x+w]
            # Resize the face frame to 224x224
            resized_face_frame = cv2.resize(face_frame, (224, 224))

            # Save the cropped and resized face to the designated directory
            frame_path = os.path.join(save_dir, f'face_{thread_num}_{img_index}.jpg')
            cv2.imwrite(frame_path, resized_face_frame)
            img_index += 1

            # Display the frame with the rectangles (commented out)
            # cv2.imshow('Face Detection', frame)

        # Break the loop if 'q' is pressed
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

        frame_index += 1
    print(f"execution time: {time.time()-start} seconds")
    cap.release()
    cv2.destroyAllWindows()
    print(f"total {frame_index} frames, extracted {img_index-1} images")


def extract_faces_from_folders(root_folder, thread_num=""):
    # Path to the 'frames' directory
    frames_dir = os.path.join(root_folder, "datasets", "frames")
    raw_dir = os.path.join(root_folder, "datasets", "raw")

    # Ensure the 'raw' directory exists
    if not os.path.exists(raw_dir):
        os.makedirs(raw_dir)

    start = time.time()

    # Iterate over each folder in the 'frames' directory
    for folder_name in os.listdir(frames_dir):
        folder_path = os.path.join(frames_dir, folder_name)

        if os.path.isdir(folder_path):
            # Create corresponding folder in the 'raw' directory
            save_dir = os.path.join(raw_dir, folder_name)

            if os.path.exists(save_dir):
                shutil.rmtree(save_dir)
            os.makedirs(save_dir)

            img_index = 1

            # Iterate over all image files in the current folder
            for filename in os.listdir(folder_path):
                if filename.endswith(('.jpg', '.jpeg', '.png', '.bmp', '.tiff')):  # Adjust file extensions as needed
                    file_path = os.path.join(folder_path, filename)
                    frame = cv2.imread(file_path)

                    if frame is None:
                        print(f"Error: Could not read image {file_path}")
                        continue

                    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

                    # Detect faces in the frame
                    faces = DeepFace.extract_faces(frame, detector_backend='yolov8', enforce_detection=False)

                    for face in faces:
                        face_rect = face["facial_area"]
                        x, y, w, h = face_rect["x"], face_rect["y"], face_rect["w"], face_rect["h"]
                        # Perform aspect ratio check (assuming face boxes are more square)
                        if not 0.75 < w/h < 1.33:
                            continue

                        face_frame = frame[y:y+h, x:x+w]
                        # Resize the face frame to 224x224
                        if not face_frame.size:
                            continue

                        resized_face_frame = cv2.resize(face_frame, (224, 224))

                        # Save the cropped and resized face to the designated directory
                        frame_path = os.path.join(save_dir, f'face_{thread_num}_{img_index}.jpg')
                        cv2.imwrite(frame_path, resized_face_frame)
                        img_index += 1

            print(f"Processed folder: {folder_name}, extracted {img_index - 1} images")

    print(f"Total execution time: {time.time() - start} seconds")


if __name__ == "__main__":
    extract(name="joe")
