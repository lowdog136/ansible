#/bin/bash
arr=(
"zooloo ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOY+sZ+gg6rc77zn+z872c1SlpPsiBU9aW/MYvrAfA6q zooloo@home"
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
    sudo echo "$LOGIN ALL=(ALL) NOPASSWD:ALL" >> /tmp/zooloo-home--users 
done
sudo chown root:root /tmp/zooloo-home-users
sudo mv /tmp/wzilla-users /etc/sudoers.d/zooloo-home-users
sudo chown root:root /etc/sudoers.d/zooloo-home-users
sudo chmod 440 /etc/sudoers.d/zooloo-home-users