# Version 1.0.5

FROM ubuntu:14.04

MAINTAINER manabugt <manabu1984+github@gmail.com>

# Install java7
RUN apt-get install -y software-properties-common && add-apt-repository -y ppa:webupd8team/java && apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer

# Install dependencies
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl make maven

# Copy necessary files to install Android SDK components
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && tar xzf android-sdk.tgz && rm -f android-sdk.tgz && chown -R root.root android-sdk-linux && ln -sf /opt/android-sdk-linux /opt/android-sdk

# Install Android NDK
RUN cd /opt && wget --output-document=android-ndk.bin --quiet http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin && chmod a+x android-ndk.bin && ./android-ndk.bin && rm -f android-ndk.bin && chown -R root.root android-ndk-r10e && ln -sf /opt/android-ndk-r10e /opt/android-ndk

# Setup environment
ENV ANDROID_HOME /opt/android-sdk
ENV ANDROID_SDK /opt/android-sdk
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:/opt/java/jdk1.7/bin

# Install Android SDK components
RUN cd /opt/android-sdk && cp -a tools copy-tools && /opt/tools/expect-android-update.sh platform-tools,build-tools-23.0.0,build-tools-23.0.1,build-tools-23.0.2,build-tools-23.0.3,android-21,android-22,android-23,extra-android-support,extra-android-m2repository,extra-google-m2repository,extra-google-google_play_services && rm -rf temp

# Check
RUN which adb
RUN which android

# Clean up
RUN apt-get clean

# Go to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
