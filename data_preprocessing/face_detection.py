import cv2
import os
import shutil
import sys
import time
from deepface import DeepFace

current_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.dirname(os.path.dirname(current_dir))
sys.path.append(project_root)


def extract(path_to_video=None, thread_num="", name="joe"):
    # Directory to save frames with detected faces
    save_dir = os.path.join("..", "datasets", "raw", name)

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

if __name__ == "__main__":
    extract(name="joe")