import socket
import os
import time


sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  
sock.connect(('127.0.0.1', 12345))  
print("connected to server!")

f1 = open("recv_img.jpg", "rb")
buf1 = f1.read()
size1 = os.path.getsize("recv_img.jpg")

f2 = open("./captured_frames/128x128.png", "rb")
buf2 = f2.read()
size2 = os.path.getsize("./captured_frames/128x128.png")

f3 = open("./captured_frames/frame_6000.jpg", "rb")
buf3 = f3.read()
size3 = os.path.getsize("./captured_frames/frame_6000.jpg")

f4 = open("./captured_frames/frame_9000.jpg", "rb")
buf4 = f4.read()
size4 = os.path.getsize("./captured_frames/frame_9000.jpg")

f5 = open("./captured_frames/frame_9000.jpg", "rb")
buf5 = f5.read()
size5 = os.path.getsize("./captured_frames/frame_9000.jpg")

while True:
    sock.sendall(size3.to_bytes(4,'big'))
    sock.sendall(buf3)
    # print("sent image!")
    time.sleep(0.03)
    sock.sendall(size4.to_bytes(4,'big'))
    sock.sendall(buf4)
    # print("sent image!")
    time.sleep(0.03)
    sock.sendall(size5.to_bytes(4,'big'))
    sock.sendall(buf5)
    print("sent images!")
    time.sleep(0.03)
    