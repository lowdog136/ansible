#/bin/bash
arr=(
"ns ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEjGEPeysnwZOK2cN0TJTHIM6PHR2PVm15jsZmW4CvLt ns@webzilla"
)
for index in ${!arr[*]}
do
    IFS=' ' read -r -a array <<< ${arr[$index]}
    LOGIN=${array[0]}
    KEY="${array[1]} ${array[2]} ${array[3]}"
    sudo adduser $LOGIN
    sudo usermod -aG wheel $LOGIN
    sudo su $LOGIN -c "mkdir /home/$LOGIN/.ssh"
    sudo su $LOGIN -c "chmod 700 /home/$LOGIN/.ssh"
    sudo su $LOGIN -c "touch /home/$LOGIN/.ssh/authorized_keys"
    sudo su $LOGIN -c "chmod 600 /home/$LOGIN/.ssh/authorized_keys"
    sudo su $LOGIN -c "echo $KEY > /home/$LOGIN/.ssh/authorized_keys"
    sudo echo "$LOGIN ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/wzilla-users 
done
sudo chown root:root /tmp/wzilla-users
sudo mv /tmp/wzilla-users /etc/sudoers.d/wzilla-users
sudo chown root:root /etc/sudoers.d/wzilla-users
sudo chmod 440 /etc/sudoers.d/wzilla-users