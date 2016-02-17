#!/bin/sh
## Preparing all the variables like IP, Hostname, etc, all of them from the container
sleep 5
HOSTNAME=$(hostname -a)
DOMAIN=$(hostname -d)
CONTAINERIP=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
RANDOMHAM=$(date +%s|sha256sum|base64|head -c 10)
RANDOMSPAM=$(date +%s|sha256sum|base64|head -c 10)
RANDOMVIRUS=$(date +%s|sha256sum|base64|head -c 10)

## Installing the DNS Server ##
echo "Configuring DNS Server"
sed "s/-u/-4 -u/g" /etc/default/bind9 > /etc/default/bind9.new
mv /etc/default/bind9.new /etc/default/bind9
rm /etc/bind/named.conf.options
mv /etc/bind/db.domain /etc/bind/db.$DOMAIN

sed -i 's/\$DOMAIN/'$DOMAIN'/g' \
  /etc/bind/db.$DOMAIN \
  /etc/bind/named.conf.local

sed -i 's/\$HOSTNAME/'$HOSTNAME'/g' /etc/bind/db.$DOMAIN

sed -i 's/\$CONTAINERIP/'$CONTAINERIP'/g' /etc/bind/db.$DOMAIN

sudo service bind9 restart

##Install the Zimbra Collaboration ##
echo "Downloading Zimbra Collaboration 8.6"
wget -O /opt/zimbra-install/zimbra-zcs-8.6.0.tar.gz https://files.zimbra.com/downloads/8.6.0_GA/zcs-8.6.0_GA_1153.UBUNTU14_64.20141215151116.tgz

echo "Extracting files from the archive"
tar xzvf /opt/zimbra-install/zimbra-zcs-8.6.0.tar.gz -C /opt/zimbra-install/

echo "Installing Zimbra Collaboration just the Software"
cd /opt/zimbra-install/zcs-* && ./install.sh -s < /opt/zimbra-install/installZimbra-keystrokes

echo "Installing Zimbra Collaboration injecting the configuration"
/opt/zimbra/libexec/zmsetup.pl -c /opt/zimbra-install/installZimbraScript

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
