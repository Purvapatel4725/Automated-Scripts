import subprocess

def execute_command(command):
    subprocess.run(command, shell=True)

def kill_processes():
    execute_command("killall hostapd dnsmasq")
    execute_command("iptables --table nat --flush")
    execute_command("iptables --flush")
    execute_command("echo 0 > /proc/sys/net/ipv4/ip_forward")

def remove_directory():
    execute_command("rm -rf /root/fap")

def main():
    #print Logo:
    print(r"""
     ____                          ____       _       _ 
    |  _ \ _   _ _ ____   ____ _  |  _ \ __ _| |_ ___| |                                                                                                                    
    | |_) | | | | '__\ \ / / _` | | |_) / _` | __/ _ \ |                                                                                                                    
    |  __/| |_| | |   \ V / (_| | |  __/ (_| | ||  __/ |                                                                                                                    
    |_|    \__,_|_|    \_/ \__,_| |_|   \__,_|\__\___|_|                                                                                                                                                                                                                                                                       
          """)

    kill_processes()
    remove_directory()

if __name__ == "__main__":
    main()
           
