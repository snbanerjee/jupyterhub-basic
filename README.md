# jupyterhub-basic
ready-made installation bash script for Ubuntu-16.04

Please make sure that your system is having an active internet connection.

In case you are running it in a VM, (likewise in our case), please make sure that the Network is configured as Bridged Adapter instead of NAT.

It is recommended to have minimum 2 vcpu and 1GB RAM; in our case it is 3 vcpu and 2GB RAM.

The script is designed to run on Ubuntu 16.04 LTS, although it is expected to run in other latest versions of Ubuntu OS as well.

Please login to the root account of the system using command sudo su -

The script may be run as is: sh +x task1.sh  to see the results at the terminal.

While installing miniconda, please react interactively by pressing ‘Enter’ button from keyboard, then Space Bar, then yes, then type /usr/bin/miniconda3 , then yes.

While configuring the openssl, please enter the requisite information of Country, State, City, Name, FQDN, Email Address etc details as asked interactively or you may press ‘Enter’ key multiple times.

In the output of the screen, many times you will see numeric zero ‘0’ getting printed; this means that the immediate preceding command has executed successfully without any error. In case there is any non-zero value, then may be there is some error (please report the same to snbanerjee@iitgn.ac.in)

Please check the script1.log file for detailed log saved in the same directory.

If the script.sh runs fine without any error, please open a browser (apart from Safari) and type in the URL https://<your VM IP Address>:443

In order to get the VM IP address, please open a separate terminal and type command /sbin/ifconfig and look for inet addr parameter for either Ethernet or Wireless Lan

The URL runs on a self-signed HTTPS and hence the browser may prompt a potential Risk message; please do not worry and proceed to continue.

Type your VM Login credentials and things should run fine.

Note: The script does not deploy any GitHub Authentication using Client_ID and Client_secret and callback_URL since I do not expect the end-user to have a GitHub account.
