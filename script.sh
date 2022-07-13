###########################################
#This script is to be run in root account #
#any options unless specified or needed   #
#This script is tested on Ubuntu16.04     #
#Version: 1.0			          #
#Release: 26-June-2019		          #
#Author: S N Banerjee                     #
#How to run: sh +x script file name       #
###########################################
#!/bin/bash

echo $HOME    # checking whether system HOME is defined or not
var1=`echo $?` # checking whether there is any non-zero value
var2=0
PWD1=`pwd`
account=root

echo " " >> $HOME/script.log
echo " " >> $HOME/script.log

if [ "$var1" -ne "$var2" ];
	then
	{
		echo "Warning: System Home Variable is not set" 
	}
else
	{
		echo "System home variable is set....Good to go...please wait.. gathering resources"
	}
fi

sleep 2

USER=`whoami`
if [ $USER != $account ];
	then
	{
		echo "Warning: Please Login to root account and proceed";exit 1;
	}
else
	{
		echo "Super admin account is used...Good to go...please wait.."
	}
fi

sleep 2

#Checking whether system has Internet Connection with 4 packets
ping google.com -c 4 | grep icmp
a0=`echo $?`
if [ "$a0" -eq "$var2" ]
then
	{
		echo "Internet Connection is Detected.. may proceed" 
	}
else
	{
		echo "Please check your Internet Connection";exit 1;
	}
fi

sleep 2

# updating the system to fix any broken packages
apt-get update -y

# Installing SSH to login
apt-get openssh-* -y

# Installing Net-Tools, 
apt-get install net-tools -y

mast=`hostname`  # capturing the hostname of the system into variable mast
echo "The hostname of the system is $mast" > $HOME/script.log   # logging of data
echo " " >> $HOME/script.log

Date1=`date` # capturing the system date into variable Date1 upon start of the job#
echo "Job started at $Date1" >> $HOME/script.log
echo " " >> $HOME/script.log

IPADDR=`ifconfig | grep inet | grep Bcast | awk {'print $2'} | cut -b 6-`  # capturing IP Address of the system
echo "The IP address of the system is $IPADDR" >> $HOME/script.log
echo " " >> $HOME/script.log

# Capturing System Resource Details

cpucount=`cat /proc/cpuinfo | grep processor | wc -l`   # capturing the number of CPU in the system
echo "The number of Processor in the system is $cpucount" >> $HOME/script.log
echo " " >> $HOME/script.log

phyram=`cat /proc/meminfo | grep MemTotal | awk '{print $2" "$3}'`    # capturing amount of physical memory
echo "The amount of Physical Memory available in the system is $phyram" >> $HOME/script.log
echo " " >> $HOME/script.log

HDD=`sudo fdisk -l | grep iB | awk '{print $1" "$2" "$3" "$4}' | cut -d "," -f1`    # capturing amount of HDD
echo "The amount of Hard Disk Space available in the system is $HDD" >> $HOME/script.log
echo " " >> $HOME/script.log

echo "The OS installed in the machine is ..." >> $HOME/script.log
cat /etc/lsb-release >> $HOME/script.log
echo " " >> $HOME/script.log

# Gathering List of System Users who are qualified to Login
USERS=`cat /etc/passwd | grep bash | awk 'NR !=1' | cut -d: -f1`
echo "The list of users are $USERS" >> $HOME/script.log

sleep 2  # sleeping the system for 2 seconds
echo "Sleeping for 2 seconds" >> $HOME/script.log

echo "Downloading Miniconda using command: wget --no-check-certificate https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh" >> $HOME
/script.log
wget --no-check-certificate https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
a1=`echo $?`
if [ "$a1" -eq "$var2" ]
then
	{
		echo "Miniconda Download Successfull" 
	}
else
	{
		echo "Problem in Downloading Miniconda... please check your Internet Connection";exit 1;
	}
fi
echo " " >> $HOME/script.log

sleep 2 # Sleeping for 2 seconds
echo " " >> $HOME/script.log
echo "Sleeping for 2 seconds" >> $HOME/script.log
echo " " >> $HOME/script.log

echo "Download and Install npm and nodejs" >> $HOME/script.log
echo " " >> $HOME/script.log

apt-get install npm nodejs-legacy -y
echo $?
a2=`echo $?`
if [ "$a2" -eq "$var2" ]
then
	{
		echo "Installation of npm and nodejs Successfull" 
	}
else
	{
		echo "Problem in Installing npm and nodejs... please report";exit 1;
	}
fi

sleep 2
echo " " >> $HOME/script.log

echo "Installing Miniconda using command: bash Miniconda3-latest-Linux-x86_64.sh" >> $HOME/script.log
bash Miniconda3-latest-Linux-x86_64.sh  
# press enter 
# type yes 
# type /usr/bin/miniconda3 (instead of the offered path, so that all system local users can login to jupyterhub) 
# type yes ....to accept the license and proceed
echo $?
a3=`echo $?`
if [ "$a3" -eq "$var2" ]
then
	{
		echo "Installation of Miniconda Successfull" 
	}
else
	{
		echo "Problem in Installation of Miniconda... please report";exit 1;
	}
fi
echo " " >> $HOME/script.log

sleep 2

# Activate the Conda Env
/usr/bin/miniconda3/bin/conda config --set auto_activate_base true  # please logout and relogin once to continue
echo $?
a4=`echo $?`
if [ "$a4" -eq "$var2" ]
then
	{
		echo "Activation of Conda is Successfull" 
	}
else
	{
		echo "Problem in Activation of conda... please report";exit 1;
	}
fi
echo " " >> $HOME/script.log

sleep 2

echo "Installing the channels and JupyterHub" >> $HOME/script.log
conda install -c conda-forge jupyterhub -y
echo $?
a5=`echo $?`
if [ "$a5" -eq "$var2" ]
then
	{
		echo "Installation of Conda-Forge and JupyterHub is Successfull" 
	}
else
	{
		echo "Problem in Installation of conda-forge and JupyterHub ... please report";exit 1;
	}
fi

sleep 2

echo " " >> $HOME/script.log

echo "Installing notebook" >> $HOME/script.log
conda install notebook -y
echo $?
a6=`echo $?`
if [ "$a6" -eq "$var2" ]
then
	{
		echo "Installation of Notebook is Successfull" 
	}
else
	{
		echo "Problem in Installation of Notebook... please report";exit 1;
	}
fi

sleep 2

echo " " >> $HOME/script.log

#Generating the jupyterhub_config.py file
jupyterhub --generate-config
echo $?
a7=`echo $?`
if [ "$a7" -eq "$var2" ]
then
	{
		echo "Generation of jupyterhub_config.py file is Successfull" 
	}
else
	{
		echo "Problem in Generation... please report";exit 1;
	}
fi

sleep 2

echo " " >> $HOME/script.log

ls -lrt jupyterhub_config.py >> $HOME/script.log
mv jupyterhub_config.py bkp_jupyterhub_config.py_bkp ##rename and backup the file
> jupyterhub_config.py

##Generate SSL keys ... please keep on pressing multiple Enter Key unless next line starts
echo 
openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout jupyterhub.key -out jupyterhub.crt
echo $?
ls -lrt *.key
echo " " >> $HOME/script.log

ls -lrt *.crt
echo " " >> $HOME/script.log

setcap 'cap_net_bind_service=+ep' `which node`

#Configuring SSL Keys in jupyter_config.key file
echo "c.JupyterHub.ssl_key = '$HOME/jupyterhub.key'
c.JupyterHub.ssl_cert = '$HOME/jupyterhub.crt'
c.JupyterHub.ip = '$IPADDR'
c.JupyterHub.port = 443 	
" >> $HOME/jupyterhub_config.py


#Run JupyterHub in the background .. Open any browser (other than Safari) and access with your system IP Address in the form: https:<IP ADDRESS>:443
jupyterhub &


Date2=`date` # capturing the system date into variable Date2 upon end of the job#
echo "Job ended at $Date2" >> $HOME/script.log
