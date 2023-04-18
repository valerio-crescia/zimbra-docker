#################################################################
# Dockerfile to build Zimbra Collaboration 8.8.15 container images
# Based on Ubuntu 20.04
# Created by Jorge de la Cruz
#################################################################
FROM ubuntu:20.04
MAINTAINER Jorge de la Cruz <jorgedlcruz@gmail.com>

RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install \
  wget \
  dialog \
  openssh-client \
  software-properties-common \
  dnsmasq \
  dnsutils \
  net-tools \
  sudo \
  rsyslog \
  unzip \
  apt-utils 

VOLUME ["/opt/zimbra"]

# Expose ports
# -----------------------------------------------------------------------------
# 25/tcp   - SMTP (for incoming mail)
# 80/tcp   - HTTP (for web mail clients)
# 110/tcp  - POP3 (for mail clients)
# 143/tcp  - IMAP (for mail clients)
# 443/tcp  - HTTP over TLS (for web mail clients)
# 465/tcp  - SMTP over SSL (for mail clients)
# 587/tcp  - SMTP (submission, for mail clients)
# 993/tcp  - IMAP over TLS (for mail clients)
# 995/tcp  - POP3 over TLS (for mail clients)
# 5222/tcp - XMPP
# 5223/tcp - XMPP (default legacy port)
# 7071/tcp - HTTPS (admin panel, https://<host>/zimbraAdmin)
# -----------------------------------------------------------------------------
EXPOSE 25 80 110 143 443 465 587 993 995 5222 5223 7071

EXPOSE 22 25 465 587 110 143 993 995 80 443 8080 8443 7071

COPY opt /opt/

COPY etc /etc/

CMD ["/bin/bash", "/opt/start.sh", "-d"]
