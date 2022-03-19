# Install Stackdriver logging agent
curl -sSO https://dl.google.com/cloudagents/install-logging-agent.sh
sudo bash install-logging-agent.sh

# Install or update needed software
apt-get update
apt-get install git -y
apt-get install python3-pip -y
apt-get install -yq \
    supervisor python-dev python-pip
pip install --upgrade pip virtualenv

# Account to own server process
useradd -m -d /home/pythonapp pythonapp

# Fetch source code
export HOME=/root
git clone https://github.com/GoogleCloudPlatform/getting-started-python.git /opt/app

# Python environment setup
virtualenv -p python3 /opt/app/gce/env
/bin/bash -c "source /opt/app/gce/env/bin/activate"
/opt/app/gce/env/bin/pip3 install -r /opt/app/gce/requirements.txt

# Set ownership to newly created account
chown -R pythonapp:pythonapp /opt/app

# Put supervisor configuration in proper place
cp /opt/app/gce/python-app.conf /etc/supervisor/conf.d/python-app.conf

# Start service via supervisorctl
supervisorctl reread
supervisorctl update
