import os
import time

def scan_wifi_adapters():
    result = os.popen("iw dev | grep Interface | awk '{print $2}'").read().split()
    return result

def select_wifi_adapter(adapters):
    print("Available network adapters:")
    for i, adapter in enumerate(adapters, 1):
        print(f"{i}. {adapter}")
    adapter_index = int(input("Enter the index of the WiFi adapter to use: ")) - 1
    return adapters[adapter_index]

def create_hostapd_conf(wifi_adapter, wifi_name, channel, password=None):
    if not os.path.exists("/root/fap"):
        os.makedirs("/root/fap")
        
    hostapd_content = f"""\
interface={wifi_adapter}
driver=nl80211
ssid={wifi_name}
hw_mode=g
channel={channel}
macaddr_acl=0
ignore_broadcast_ssid=0
"""
    if password:
        hostapd_content += f"wpa=2\nwpa_passphrase={password}\n"

    # Add beacon interval
    hostapd_content += "beacon_int=1000\n"  # Modify the beacon interval as needed (in milliseconds)

    with open("/root/fap/hostapd.conf", "w") as f:
        f.write(hostapd_content)

def start_hostapd():
    os.system("hostapd /root/fap/hostapd.conf &")

def start_dnsmasq():
    os.system("dnsmasq -C /root/fap/dnsmasq.conf -d &")

def configure_wifi_adapter(wifi_adapter):
    os.system(f"ifconfig {wifi_adapter} up 192.168.1.1 netmask 255.255.255.0")
    os.system("route add -net 192.168.1.0 netmask 255.255.255.0 gw 192.168.1.1")
    os.system("iptables --table nat --append POSTROUTING --out-interface eth0 -j MASQUERADE")
    os.system("iptables --append FORWARD --in-interface wlan0 -j ACCEPT")
    os.system("echo 1 > /proc/sys/net/ipv4/ip_forward")

def main():
    #Print Logo
    print(r"""
     ____                          ____       _       _ 
    |  _ \ _   _ _ ____   ____ _  |  _ \ __ _| |_ ___| |                                                                                                                    
    | |_) | | | | '__\ \ / / _` | | |_) / _` | __/ _ \ |                                                                                                                    
    |  __/| |_| | |   \ V / (_| | |  __/ (_| | ||  __/ |                                                                                                                    
    |_|    \__,_|_|    \_/ \__,_| |_|   \__,_|\__\___|_|                                                                                                                                                                                                                                                                       
          """)
    adapters = scan_wifi_adapters()
    wifi_adapter = select_wifi_adapter(adapters)
    wifi_name = input("Enter the name of the WiFi network: ")
    channel = input("Enter the channel number for the WiFi network: ")
    password_choice = input("Do you want to set up a password for the Wi-Fi network? (yes/no): ").lower()
    if password_choice == "yes":
        password = input("Enter the password for the Wi-Fi network: ")
    else:
        password = None

    # Create hostapd configuration
    create_hostapd_conf(wifi_adapter, wifi_name, channel, password)

    # Start hostapd
    start_hostapd()

    # Configure dnsmasq
    os.system("touch /root/fap/dnsmasq.conf")
    with open("/root/fap/dnsmasq.conf", "w") as f:
        f.write("interface=wlan0\n")
        f.write("dhcp-range=192.168.1.2,192.168.1.30,255.255.255.0,24h\n")
        f.write("dhcp-option=3,192.168.1.1\n")
        f.write("dhcp-option=6,192.168.1.1\n")
        f.write("server=8.8.8.8\n")
        f.write("log-queries\n")
        f.write("log-dhcp\n")
        f.write("listen-address=127.0.0.1\n")

    # Start dnsmasq
    start_dnsmasq()

    # Configure WiFi adapter
    configure_wifi_adapter(wifi_adapter)

    print("Fake Access Point started successfully!")

    # Keep script running
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print("\nExiting...")
        os.system("killall hostapd")
        os.system("killall dnsmasq")

if __name__ == "__main__":
    main()
