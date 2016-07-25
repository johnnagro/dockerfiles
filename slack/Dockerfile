# Run slack-desktop in a container
#
# This is pretty ALPHA
#

FROM ubuntu:16.04
MAINTAINER John Nagro <john.nagro@gmail.com>

RUN apt-get clean && apt-get update

RUN apt-get update && apt-get install -y \
  alsa-utils \
  apt-utils \
	dbus-x11 \
	unity8 \
	apt-transport-https \
	ca-certificates \
	gconf2 \
	gconf-service \
	gvfs-bin \
	hunspell-en-us \
	libasound2 \
	libgtk2.0-0 \
	libnotify4 \
	libnss3 \
	libxss1 \
	libxtst6 \
	locales \
	python \
	xdg-utils \
	libgnome-keyring0 \
	gir1.2-gnomekeyring-1.0 \
	libappindicator1 \
	unity-gtk-module-common \
	libcanberra-gtk-module \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

ADD https://downloads.slack-edge.com/linux_releases/slack-desktop-2.1.0-amd64.deb /tmp/slack-desktop-2.1.0-amd64.deb

RUN dpkg -i /tmp/slack-desktop-2.1.0-amd64.deb

# Autorun atom
ENTRYPOINT [ "slack" ]
