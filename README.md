docker-android
===================

This is a Dockerfile to make the image suitable for most Android projects including NDK.

Included
----------

* Android SDK: r25.2.3
* Android NDK: r13b
* Build tools: 23.0.3, 24.0.3, 25.0.3
* Android API: 21, 22, 23, 24, 25
* Support maven repository
* Google maven repository
* Platform tools
* Make: 3.8.1
* Maven: 3.0.5
* oracle-java7
* oracle-java8

## ex..How to build image

```bash
docker build -t manabugt/android .
```

To run an interactive shell in the built image:

```bash
docker run -i -t manabugt/android /bin/bash
```

## ex..Push build image to repository

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
