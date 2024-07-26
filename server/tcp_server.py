import socket
import threading
import keyboard
import queue
import time
# import matplotlib.pyplot as plt
# import matplotlib.image as mpimg

import sys
import os

import cv2
import numpy

# Get the parent directory
parent_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))

# Add the parent directory to sys.path
sys.path.append(parent_dir)

from data_preprocessing.face_detection import *

# set this FLAG for different mode
# Data-Processing: 0
# Training: 1
# Evaluation: 2
FLAG = 2

# set this to the path of the video to decode
PATH_TO_VIDEO = "datasets/videos/Joe 1080_1920 60fps BackCam.MOV"

# set this to name of the person
NAME = "Joe"

# set this to the path of any random image to test
IMAGE_PATH = "datasets/random_test/face_1.jpg"

# TODO: this needs to turn into a function after connecting to db
OUTPUT_CLASS_NUMBER = 2

# these are variable to hold the return from training
MODEL_NAME = "resnet_finetuned_20240726_000932.pth"
CLASS_LABELS = ['jack', 'bob']# set this FLAG for different mode
# Data-Processing: 0
# Training: 1
# Evaluation: 2
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

#Variables for holding information about connections
connections = []
total_connections = 0

images = queue.Queue()
use_images = 0
to_use_images = []
start = 0

def on_key_event(event):
    pass

def interrupt_routine():
    global use_images
    global to_use_images
    keyboard.hook(on_key_event)
    while True:
        # Wait indefinitely to keep the script running and listening for events
        if keyboard.read_key() == 17:
            if len(to_use_images) != 0:
                continue
            print()
            global start
            start = time.time()
            print("key pressed")
            use_images = 1

# byte = b''
# print(byte)
# print(not byte)
# exit()

#Client class, new instance created for each connected client
#Each instance has the socket and address that is associated with items
#Along with an assigned ID and a name chosen by the client
class Client(threading.Thread):
    def __init__(self, socket, address, id, name, signal):
        threading.Thread.__init__(self)
        self.socket = socket
        self.address = address
        self.id = id
        self.name = name
        self.signal = signal

    def __str__(self):
        return str(self.id) + " " + str(self.address)

    #Attempt to get data from client
    #If unable to, assume client has disconnected and remove him from server data
    #If able to and we get data back, print it in the server and send it back to every
    #client aside from the client that has sent it
    #.decode is used to convert the byte data into a printable string
    def run(self):
        endian = 'little' # camera sends little
        while self.signal:
            buf = self.recvall(4)
            if(buf is None):
                self.close()
                break

            image_size = int.from_bytes(buf,endian)
            # print(buf)
            # print(image_size)
            buf = self.recvall(image_size)
            if(buf is None):
                self.close()
                break
            # print(buf)
            # print("image with len: " + str(len(buf)) + " put in buffer, there are " + str(images.qsize()) + " in the buffer")
            images.put(buf)

    def recvall(self, n):
        data = bytearray()
        while n > 0:
            packet = self.socket.recv(n)
            if(not packet):
                return None
            data.extend(packet)
            n = n - len(packet)
        return data

    def close(self):
        print("Client " + str(self.address) + " has disconnected")
        self.signal = False
        connections.remove(self)
        self.socket.close()

class Consumer(threading.Thread):
    def __init__(self, signal):
        threading.Thread.__init__(self)
        self.signal = signal

    def __str__(self):
        return "consumer"

    def run(self):
        global to_use_images
        global use_images
        print("consumer: started")
        window_name = 'stream'
        # cv2.namedWindow(window_name, cv2.WINDOW_NORMAL)
        # cv2.resizeWindow(window_name, 600, 800)
        while self.signal:
            buf = images.get()
            # print("consumer: read data from images queue, length " + str(len(buf)))
            # print(buf)
            # process buf
            nparr = numpy.frombuffer(buf, numpy.uint8)
            img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
            if(img is None):
                print("Got invalid image of size " + str(len(buf)))
                continue
            #     print("Got invalid image of size " + str(len(buf)) + ", saving to img3.txt")
            # with open("img3.txt", "wb") as f:
            #     f.write(buf)
            #     # continue
            img = cv2.flip(img,0)
            img = cv2.flip(img,1)

            # cv2.imwrite("joe/image"+str(time.time())+".jpg",img)

            # # cv2.imshow(window_name,img)
            # cv2.waitKey(1)

            # using images to model
            if use_images:
                if len(to_use_images) >= 5:
                    face_images = extract_list_of_images(to_use_images)
                    predict_image_class(MODEL_NAME, CLASS_LABELS, OUTPUT_CLASS_NUMBER, face_images)
                    for img in to_use_images:
                        cv2.imwrite("joe/image"+str(time.time())+".jpg",img)
                    use_images = 0
                    to_use_images = []
                else:
                    if len(to_use_images) == 0:
                        global start
                        print(f"latency: {time.time()-start}s")
                    to_use_images.append(img)

#Wait for new connections
def newConnections(socket):
    while True:
        sock, address = socket.accept()
        global total_connections
        connections.append(Client(sock, address, total_connections, "Name", True))
        connections[len(connections) - 1].start()
        print("New connection at ID " + str(connections[len(connections) - 1]))
        print("Address: " + str(address))
        total_connections += 1

from evaluation.test_model import *

def predict_image_class(model_path, class_labels, num_classes, images):
    model, device = load_model(model_path, num_classes)
    # predicted_class, class_probabilities = predict(model, device, class_labels, image_path)

    predicted_class, class_probabilities = predict(model, device, class_labels, images)

    print(f"Predicted Class: {predicted_class}")
    for i, prob in enumerate(class_probabilities):
        print(f"{class_labels[i]}: {prob:.4f}")
    return predicted_class, class_probabilities


def main():
    #Get host and port
    host = "192.168.1.100"
    # host = "127.0.0.1"
    port = 12345

    #Create new server socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.bind((host, port))
    sock.listen(5)
    print("Listening on: " + host + ":" + str(port))

    #Create new thread to wait for connections
    newConnectionsThread = threading.Thread(target = newConnections, args = (sock,))
    newConnectionsThread.start()
    print("Starting consumer")
    consumer = Consumer(True)
    consumer.start()

    # setup keyboard interrupt
    interrupt_routine()

main()