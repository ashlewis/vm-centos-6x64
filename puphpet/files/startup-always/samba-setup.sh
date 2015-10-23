#!/bin/bash
#
VAGRANT_CORE_FOLDER=$(cat '/.puphpet-stuff/vagrant-core-folder.txt')

OS=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" ID)
RELEASE=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" RELEASE)
CODENAME=$(/bin/bash "${VAGRANT_CORE_FOLDER}/shell/os-detect.sh" CODENAME)


CONFIG_FILE=${VAGRANT_CORE_FOLDER}/files/private/build.conf

if [[ -f $CONFIG_FILE ]]; then
    . $CONFIG_FILE
fi


echo 'Adding user password'

if [ "${OS}" == 'debian' ] || [ "${OS}" == 'ubuntu' ]; then
    echo vagrant:$vagrantPassword | chpasswd
    echo root:$rootPassword | chpasswd

elif [[ "${OS}" == 'centos' ]]; then
    echo $vagrantPassword | passwd vagrant --stdin
    echo $rootPassword | passwd root --stdin
fi

echo 'Adding Samba config'

if ! grep -R "\[www\]" "/etc/samba/smb.conf"; then
    echo 'Adding Samba config'
    printf "[www]\n    comment = Samba share\n    read only = no\n    browseable = yes\n    writable = yes\n    guest ok = yes\n    path = /var/www" >> /etc/samba/smb.conf
fi


echo 'Adding Samba user/password'

(echo "$vagrantPassword"; echo "$vagrantPassword") | smbpasswd -s -a vagrant
(echo "$rootPassword"; echo "$rootPassword") | smbpasswd -s -a root


echo 'Setting share directory permissions'

if [ "${OS}" == 'debian' ] || [ "${OS}" == 'ubuntu' ]; then
    chown root:www-data /var/www/ -R

elif [[ "${OS}" == 'centos' ]]; then
    chown root:www-data /var/www/ -R
fi

chmod 775 /var/www/ -R


echo 'Restarting Samba'

if [ "${OS}" == 'debian' ] || [ "${OS}" == 'ubuntu' ]; then
    service smbd restart
    
elif [[ "${OS}" == 'centos' ]]; then
    /sbin/service smb restart
fi