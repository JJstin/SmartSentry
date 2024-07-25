import socket
import threading

import queue

# import matplotlib.pyplot as plt
# import matplotlib.image as mpimg

import io

import cv2
import numpy

#Variables for holding information about connections
connections = []
total_connections = 0

images = queue.Queue()

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
            print(buf)
            print(image_size)
            buf = self.recvall(image_size)
            if(buf is None):
                self.close()
                break
            # print(buf)
            print("image with len: " + str(len(buf)) + " put in buffer, there are " + str(images.qsize()) + " in the buffer")
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
        print("consumer: started")
        window_name = 'stream'
        cv2.namedWindow(window_name, cv2.WINDOW_NORMAL) 
        # cv2.resizeWindow(window_name, 600, 800)
        while self.signal:
            buf = images.get()
            print("consumer: read data from images queue, length " + str(len(buf)))
            # print(buf)
            # process buf
            nparr = numpy.frombuffer(buf, numpy.uint8)
            img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)
            if(img is None):
                continue
            #     print("Got invalid image of size " + str(len(buf)) + ", saving to img3.txt")
            with open("img3.txt", "wb") as f:
                f.write(buf)
                # continue
            cv2.imwrite("recv_img2.jpg",img)
            cv2.imshow(window_name,img)
            cv2.waitKey(1)

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
    
main()