#!/bin/bash
## Script created by Jorge de la Cruz
## This Script doesn't have any kind of Support
## Use it under your own responsibility

## Moving and operating from /tmp
cd /tmp
## Making a Backup of the original Files
echo "Making a Backup of the original Files"
mv /opt/zimbra/jetty/webapps/zimbra/skins/_base/base2/skin.css /opt/zimbra/jetty/webapps/zimbra/skins/_base/base2/skin.css.old
mv /opt/zimbra/jetty/webapps/zimbra/skins/_base/base3/skin.css /opt/zimbra/jetty/webapps/zimbra/skins/_base/base3/skin.css.old

## Downloading the fixed Files from GitHub
echo "Downloading the fixed Files from GitHub"
wget https://raw.githubusercontent.com/jorgedlcruz/Zimbra/master/Zimbra%20Google%20Chrome%2045%20Fix/_base2skin.css
wget https://raw.githubusercontent.com/jorgedlcruz/Zimbra/master/Zimbra%20Google%20Chrome%2045%20Fix/_base3skin.css

## Move the downloaded Files into the proper folder
echo "Move the downloaded Files into the proper folder"
mv _base2skin.css /opt/zimbra/jetty/webapps/zimbra/skins/_base/base2/skin.css
mv _base3skin.css /opt/zimbra/jetty/webapps/zimbra/skins/_base/base3/skin.css

## Fixing the rights
echo "Fixing the rights"
chown zimbra:zimbra /opt/zimbra/jetty/webapps/zimbra/skins/_base/base2/skin.css
chown zimbra:zimbra /opt/zimbra/jetty/webapps/zimbra/skins/_base/base3/skin.css

## Restart the Mailbox Service
echo "Restart the Mailbox Service"
su - zimbra -c 'zmmailboxdctl restart'

echo "Now, all the users must do logout and login, and everything should work"
