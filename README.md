docker-android
===================

manabugt/android:latest
https://registry.hub.docker.com/u/manabugt/android/

This is a Dockerfile for Android projects.

Included
----------

* Android SDK: r24.4.1
* Android NDK: r10e
* Build tools: 23.0.0, 23.0.1, 23.0.2, 23.0.3
* Android API: 21, 22, 23
* Support maven repository
* Google maven repository
* Platform tools
* Make: 3.8.1
* Maven: 3.0.5
* oracle-java7
* oracle-java8

## How to build image

```bash
docker build -t manabugt/android .
```

To run an interactive shell in the built image:

```bash
docker run -i -t manabugt/android /bin/bash
```

## Push build image to repository

```bash
docker push manabugt/android:latest
```

License
----------

    Copyright 2015 Manabu Shimobe

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
