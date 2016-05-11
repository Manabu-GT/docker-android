# Version 1.0.6

FROM ubuntu:14.04

MAINTAINER manabugt <manabu1984+github@gmail.com>

# Install java7
RUN apt-get update -y && apt-get install -y apt-file && apt-get install -y software-properties-common && add-apt-repository -y ppa:webupd8team/java && apt-get update -y
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java7-installer && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/oracle-jdk7-installer

# Install java8
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && add-apt-repository -y ppa:webupd8team/java && apt-get update -y
RUN apt-get install -y oracle-java8-installer && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/oracle-jdk8-installer

# Install dependencies
RUN dpkg --add-architecture i386 && apt-get update -y && apt-get install -y --force-yes expect git wget libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1 python curl make maven

# Copy necessary files to install Android SDK components
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz && tar xzf android-sdk.tgz && rm -f android-sdk.tgz && chown -R root.root android-sdk-linux && ln -sf /opt/android-sdk-linux /opt/android-sdk

# Install Android NDK
RUN cd /opt && wget --output-document=android-ndk.bin --quiet http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin && chmod a+x android-ndk.bin && ./android-ndk.bin && rm -f android-ndk.bin && chown -R root.root android-ndk-r10e && ln -sf /opt/android-ndk-r10e /opt/android-ndk

# Setup environment
ENV JAVA8_HOME /usr/lib/jvm/java-8-oracle
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV JAVA7_HOME /usr/lib/jvm/java-7-oracle
ENV ANDROID_HOME /opt/android-sdk
ENV ANDROID_SDK /opt/android-sdk
ENV ANDROID_NDK /opt/android-ndk
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${JAVA_HOME}/bin

# Install Android SDK components
RUN cd /opt/android-sdk && cp -a tools copy-tools && /opt/tools/expect-android-update.sh platform-tools,build-tools-23.0.0,build-tools-23.0.1,build-tools-23.0.2,build-tools-23.0.3,android-21,android-22,android-23,extra-android-support,extra-android-m2repository,extra-google-m2repository,extra-google-google_play_services && rm -rf temp

# Check
RUN which adb
RUN which android
RUN java -version

# Clean up
RUN apt-get clean

# Go to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
