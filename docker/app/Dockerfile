FROM ruby:2.4.3

RUN apt-get update && \
    apt-get install -y \
      build-essential \
      libpq-dev \
      postgresql-client \
      nodejs \
      sudo \
      ghostscript

ARG uid
ARG gid

# add user
RUN groupadd -g $gid docker && \
    useradd -u $uid -g docker -G sudo -m -s /bin/bash docker && \
    echo 'docker:docker' | chpasswd

USER docker
