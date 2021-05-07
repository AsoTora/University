import socket
from _thread import *

HOST = '127.0.0.1'
PORT = 1235
ThreadCount = 0
ammount = 1000

with socket.socket() as s:
    s.bind((HOST, PORT)) # associate the socket with a specific network interface and port number

    print('Socket is listening..')
    s.listen(2) # listen to 2 connections

    def multi_threaded_client(connection):
        connection.send(str.encode('Server is working:'))
        global ammount
        
        while True:
            data = connection.recv(2048)
            if not data:
                break

            ammount -= int(data.decode('utf-8'))
            if not (ammount < 0):
                response = f"Money left: {ammount}"
            else:
                response = "Your balance is < 0"
            connection.sendall(str.encode(response))
        connection.close()

    
    while True:
        Client, address = s.accept()
        print(f"Connected to: {address[0]}:{str(address[1])}")

        start_new_thread(multi_threaded_client, (Client, ))
        ThreadCount += 1
        print(f"Thread Count: {str(ThreadCount)}")
