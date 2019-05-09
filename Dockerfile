FROM ubuntu:16.04
MAINTAINER Shai Coleman <git@shaicoleman.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && \
  apt-get install -y eatmydata wget curl software-properties-common sudo htop

ENV LD_PRELOAD /usr/lib/x86_64-linux-gnu/libeatmydata.so

RUN \
  apt-add-repository ppa:brightbox/ruby-ng && \
  apt-get update && \
  apt-get install -y ruby2.6 ruby2.6-dev build-essential git && \
  adduser --disabled-password --gecos '' es

ADD gemrc /etc
ADD rubygems_bin_path.sh /etc/profile.d

USER es
ENV HOME /home/es
WORKDIR /home/es
CMD /bin/bash -l

ADD es-bug.rb /home/es
ADD Gemfile /home/es

RUN /bin/bash -lc "gem install bundler && bundle install --path ~/.bundle"
