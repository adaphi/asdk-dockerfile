FROM ubuntu:16.04

USER root

# Install some basics
RUN apt-get update && \
    apt-get install -y \
        git \
        software-properties-common \
        sudo \
    && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# Install java
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    apt-get install -y \
        oracle-java8-installer \
        oracle-java8-set-default

# Install Atlassian SDK
RUN echo "deb https://sdkrepo.atlassian.com/debian/ stable contrib" >> /etc/apt/sources.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys B07804338C015B73 && \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y atlassian-plugin-sdk && \
    ln --symbolic /usr/share/atlassian-plugin-sdk-* /usr/share/atlassian-plugin-sdk && \
    ln --symbolic /usr/share/atlassian-plugin-sdk/apache-maven-* /usr/share/atlassian-plugin-sdk/apache-maven

# Expose bitbucket port
EXPOSE 7990
