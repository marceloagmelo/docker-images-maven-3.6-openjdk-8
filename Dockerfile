FROM marceloagmelo/openjdk-8

LABEL maintainer="Marcelo Melo marceloagmelo@gmail.com"

USER root

ENV USER_HOME_DIR="/root"
ENV SHA=c35a1803a6e70a126e80b2b3ae33eed961f83ed74d18fcd16909b2d44d7dada3203f1ffe726c17ef8dcca2dcaa9fca676987befeadc9b9f759967a8cb77181c0
ENV MAVEN_VERSION 3.6.3
ENV MAVEN_ARTIFACTORY_URL https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

ADD scripts $IMAGE_SCRIPTS_HOME
COPY Dockerfile $IMAGE_SCRIPTS_HOME/Dockerfile
COPY settings-docker.xml $MAVEN_HOME/ref/

RUN curl -fsSL -o /tmp/apache-maven.tar.gz $MAVEN_ARTIFACTORY_URL/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - && \
    tar -xzvf /tmp/apache-maven.tar.gz -C $MAVEN_HOME --strip-components=1 && \
    ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn && \
    echo "running..." >> /opt/run.log && \
    yum clean all && \
    rm -Rf /tmp/* && rm -Rf /var/tmp/*

EXPOSE 8080  

WORKDIR $IMAGE_SCRIPTS_HOME

ENTRYPOINT [ "./control.sh" ]
CMD [ "start" ]