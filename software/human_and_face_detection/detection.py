# Currently, this code takes a video and extracts frames of faces detected
# Quite a few false positives for now when running this video of our living room (due to boxes on the ground)
# Tracking of the face seems to be decent. I will add human detection for better accuracy later

import cv2
import os
import shutil

def extract(filename=None, thread_num="", name="joe"):
    # Directory to save frames with detected faces
    dirpath = os.path.dirname(__file__)
    save_dir = os.path.join(dirpath, "..", "..", "datasets", name, "raw")

    if os.path.exists(save_dir):
        shutil.rmtree(save_dir)
    os.makedirs(save_dir)

    # Load the pre-trained Haar Cascade classifier for face detection
    face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')


    # Feel free to replace name of video here with one in the directory
    video = 'Joe 1080_1920 60fps BackCam.MOV'
    cap = cv2.VideoCapture(os.path.join(dirpath, "videos", video))
    if filename:
        video = filename

    if not cap.isOpened():
        print("Error: Could not open video.")
        exit()

    frame_index = 0

    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            print("End of video or error in reading video.")
            break

        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

        # Detect faces in the frame
        faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=7, minSize=(50, 50))

        for (x, y, w, h) in faces:
            # Perform aspect ratio check (assuming face boxes are more square)
            if 0.75 < w/h < 1.33:
                # cv2.rectangle(frame, (x, y), (x+w, y+h), (255, 0, 0), 2)

                # Crop the face frame out
                face_frame = frame[y:y+h, x:x+w]

                # Save the cropped face to the designated directory
                frame_path = os.path.join(save_dir, f'face_{thread_num}_{frame_index}.jpg')
                cv2.imwrite(frame_path, face_frame)

        # Display the frame with the rectangles
        cv2.imshow('Face Detection', frame)

        # Break the loop if 'q' is pressed
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

        frame_index += 1

    cap.release()
    cv2.destroyAllWindows()



if __name__ == "__main__":
    extract()