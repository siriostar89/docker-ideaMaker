FROM jlesage/baseimage-gui:ubuntu-18.04
ARG DOCKER_IMAGE_VERSION=unknown

RUN apt-get update && apt-get install -y wget xfce4 libglu1-mesa libgomp1 sqlite3
WORKDIR /tmp
RUN wget --no-check-certificate https://download.raise3d.com/ideamaker/release/4.3.1/ideaMaker_4.3.1.6452-ubuntu_amd64.deb
RUN apt install -y ./ideaMaker_4.3.1.6452-ubuntu_amd64.deb && apt-get autoremove --yes && apt-get clean
RUN \
    APP_ICON_URL=https://raw.githubusercontent.com/siriostar89/docker-ideaMaker/main/ideamaker.png && \
    install_app_icon.sh "$APP_ICON_URL"
RUN ln -s /config/.ideamaker /ideamaker

COPY rootfs/ /

ENV APP_NAME="ideaMaker" \
    KEEP_APP_RUNNING=0

VOLUME ["/ideamaker"]
VOLUME ["/user-data"]

LABEL \
      org.label-schema.name="ideaMaker" \
      org.label-schema.description="Docker container for ideaMaker" \
      org.label-schema.version="$DOCKER_IMAGE_VERSION" \
      org.label-schema.vcs-url="https://github.com/siriostar89/docker-ideaMaker" \
      org.label-schema.schema-version="1.0"
