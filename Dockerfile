FROM ubuntu

RUN apt-get update && apt-get install -y locales openjdk-8-jdk && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

ENV CATALINA_HOME /usr/local/tomcat
ENV TOMCAT_VERSION 8.5.34
ENV JAVA_HOME /usr/local/java
ENV ORACLE_JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64/

RUN ln -s $ORACLE_JAVA_HOME $JAVA_HOME
RUN apt-get update && apt-get -y install libreoffice imagemagick liblog4j1.2-java ant curl unzip sudo tar

RUN rm -fr /usr/local/tomcat

ADD tomcat /usr/local/tomcat

RUN ln -s $CATALINA_HOME /opt/openkm

ENV PATH $PATH:$CATALINA_HOME/bin

COPY  OpenKM.cfg /opt/openkm/OpenKM.cfg
COPY  OpenKM.xml /opt/openkm/OpenKM.xml
COPY  server.xml /opt/openkm/conf/server.xml


EXPOSE 8080 2002

CMD /opt/openkm/bin/catalina.sh run
