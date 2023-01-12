#!/bin/bash
#Install Python 3.8, pip and Ansible on new control node

#Install Python3.8
cd /home/ec2-user
curl -O https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tgz
tar -xzf Python-3.8.12.tgz
sudo yum update
sudo yum install gcc openssl-devel bzip2-devel libffi-devel
sed -i "s/enabled=1/enabled=0/" /etc/yum/pluginconf.d/subscription-manager.conf
sudo yum clean all
cd /home/ec2-user/Python-3.8.12
sudo yum groupinfo "Development Tools"
sudo yum groupinstall "Development Tools"
sudo ./configure --enable-optimizations
sudo make altinstall

#sleep 10
#export PATH=$PATH:/sbin:/bin:/usr/sbin:/usr/bin
#export PATH=$PATH:/usr/local/bin
PATH+=:/usr/local/bin

#Validate Python3.8 is installed
python3.8 --version
exit_status="$(echo $?)"

if [ ${exit_status} -ge 1 ]
then
  echo "Python3.8 failed to install, try again"
else
  echo "Python3.8 successfully installed"
fi

#Add pip to PATH
location_to_path="$(echo $PATH)"
echo "alias pip='${location_to_path}'" >> /home/ec2-user/.bashrc
source /home/ec2-user/.bashrc

#Install and validate Ansible, AWS CLI and Boto3
python3.8 -m pip install --user ansible
python3.8 -m pip install awscli
python3.8 -m pip boto boto3
