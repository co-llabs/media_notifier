FROM ubuntu:16.04
MAINTAINER discr33t <cpisano86@gmail.com>

# Env Vars for Installs
ENV GITHUB="https://github.com"
ENV TUSK_VER="0.3.2"
ENV NOTIFIER_VER="0.2.0"
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Where everthing runs from
WORKDIR /opt

# Prep OS
RUN apt-get update -y
RUN apt-get install -y python3-pip wget
RUN wget ${GITHUB}/rliebz/tusk/releases/download/v${TUSK_VER}/tusk_${TUSK_VER}_linux_amd64.deb
RUN dpkg -i tusk_${TUSK_VER}_linux_amd64.deb
RUN wget ${GITHUB}/co-llabs/plex_notifier/archive/v${NOTIFIER_VER}.tar.gz
RUN tar xvfz v${NOTIFIER_VER}.tar.gz

# Install Deps and Test
WORKDIR /opt/plex_notifier-${NOTIFIER_VER}
RUN tusk bootstrap
RUN tusk test_suite

# Cleanup Artifacts
RUN rm -rf /opt/tusk_${TUSK_VER}_linux_amd64.deb
RUN rm -rf /opt/v${NOTIFIER_VER}.tar.gz
