FROM jlesage/baseimage-gui:ubuntu-18.04
ARG DOCKER_IMAGE_VERSION=4.3.1

RUN apt-get update && apt-get install -y wget nano
WORKDIR /tmp
RUN wget --no-check-certificate https://download.raise3d.com/ideamaker/release/4.3.1/ideaMaker_4.3.1.6452-ubuntu_amd64.deb
RUN apt install -y ./ideaMaker_4.3.1.6452-ubuntu_amd64.deb && apt-get autoremove --yes && apt-get clean
RUN ln -s /usr/share/ideamaker /ideamaker

COPY rootfs/ /

VOLUME ["/ideamaker/profile"]
VOLUME ["/ideamaker/config"]

LABEL \
      org.label-schema.name="ideaMaker" \
      org.label-schema.description="Docker container for ideaMaker" \
      org.label-schema.version="$DOCKER_IMAGE_VERSION" \
      org.label-schema.vcs-url="https://github.com/siriostar89/docker-ideaMaker" \
      org.label-schema.schema-version="1.0"
