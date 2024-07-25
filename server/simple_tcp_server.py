#! /usr/bin/python
# a simple tcp server
import socket,os
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)  
sock.bind(('192.168.1.100', 12345))  
sock.listen(5)  
while True:  
    connection,address = sock.accept() 
    print("sock accepted",address) 
    # buf = connection.recv(32)  
    # print(buf)
    # image_size = int.from_bytes(buf,'big')
    # print(image_size)
    buf = connection.recv(4)
    print(buf)
    size = int.from_bytes(buf,'big')
    print(size)
    size1 = int.from_bytes(buf,'little')
    print(size1)
    break
    with open("recv_img.jpg", "wb") as binary_file:
    # Write bytes to file
        binary_file.write(buf)
    connection.close()
    break