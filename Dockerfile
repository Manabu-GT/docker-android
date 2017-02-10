# Version 1.0.8

FROM ubuntu:14.04

MAINTAINER manabugt <manabu1984+github@gmail.com>

# Install dependencies
RUN apt-get update -y && apt-get install -y apt-file expect git wget python curl make maven
RUN apt-file update -y
RUN apt-get install -y software-properties-common
RUN dpkg --add-architecture i386 && apt-get update -y && apt-get install -y --force-yes libc6-i386 libncurses5:i386 libstdc++6:i386 zlib1g:i386

# Java 7 and 8 setup
RUN \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    add-apt-repository -y ppa:webupd8team/java && \
    apt-get update -y && \
    apt-get install -y oracle-java7-installer && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/oracle-jdk7-installer
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update -y && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Copy necessary files to install Android SDK components
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools

# Install Android SDK
ENV ANDROID_HOME /opt/android-sdk
RUN mkdir -p ${ANDROID_HOME}
RUN cd ${ANDROID_HOME} && wget -O android-sdk-tools.zip -q https://dl.google.com/android/repository/tools_r25.2.3-linux.zip && unzip -q android-sdk-tools.zip && rm -f android-sdk-tools.zip

# Install Android NDK
RUN cd /opt && wget -O android-ndk-r13b.zip -q https://dl.google.com/android/repository/android-ndk-r13b-linux-x86_64.zip && unzip -q android-ndk-r13b.zip && rm -f android-ndk-r13b.zip && ln -sf /opt/android-ndk-r13b /opt/android-ndk

# Setup additional environments
ENV JAVA8_HOME /usr/lib/jvm/java-8-oracle
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV JAVA7_HOME /usr/lib/jvm/java-7-oracle
ENV ANDROID_SDK /opt/android-sdk
ENV ANDROID_NDK /opt/android-ndk
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${JAVA_HOME}/bin

# Install Android SDK components
RUN cd /opt/android-sdk && cp -a tools copy-tools && /opt/tools/expect-android-update.sh platform-tools,build-tools-23.0.3,build-tools-24.0.3,build-tools-25.0.3,android-21,android-22,android-23,android-24,android-25,extra-android-support,extra-android-m2repository,extra-google-m2repository,extra-google-google_play_services && rm -rf temp

# Check
RUN which adb
RUN which android
RUN java -version

# Clean up
RUN apt-get clean

# Go to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
