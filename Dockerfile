
FROM alpine:3.7

MAINTAINER yatzek

ENV BAZEL_VERSION 0.9.0
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

RUN apk add --no-cache --virtual=.build-deps \
    coreutils \
    wget \
    python \
    python-dev \
    bash \
    musl-dev \
    openjdk8 \
    zip \
    unzip \
    \
    && ln -s /usr/lib/jvm/java-1.8-openjdk/bin/javac /usr/bin \
    && ln -s /usr/lib/jvm/java-1.8-openjdk/bin/jar /usr/bin \
    \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.26-r0/glibc-2.26-r0.apk \
    && apk add glibc-2.26-r0.apk \
    \
    && wget -q -O /etc/apk/keys/david@ostrovsky.org-5a0369d6.rsa.pub https://raw.githubusercontent.com/davido/bazel-alpine-package/master/david@ostrovsky.org-5a0369d6.rsa.pub \
    && wget https://github.com/davido/bazel-alpine-package/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-r0.apk \
    && apk add bazel-${BAZEL_VERSION}-r0.apk \
    && bazel version

ENTRYPOINT ["bash"]