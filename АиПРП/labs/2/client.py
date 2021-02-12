import socket

HOST = '127.0.0.1'
PORT = 1235

# with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
#     s.connect((HOST, PORT))
#     s.sendall(b'Hello, world')
#     data = s.recv(1024)
# print('Received', repr(data))


with socket.socket() as s:
    print('Waiting for connection response')
    try:
        s.connect((HOST, PORT))
    except socket.error as e:
        print(str(e))

    res = s.recv(2048)
    while True:
        Input = input('Money withdrowal ammount: ') 
        s.send(str.encode(Input))
        res = s.recv(2048)
        print(f"recieved from server: <{res.decode('utf-8')}>\n")
