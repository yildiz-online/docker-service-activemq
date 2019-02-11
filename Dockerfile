FROM moussavdb/runtime-java

LABEL maintainer="Grégory Van den Borre vandenborre.gregory@hotmail.fr"

ENV ACTIVEMQ_VERSION 5.15.8
ENV LOGBACK_VERSION 1.2.3

ENV ACTIVEMQ apache-activemq-$ACTIVEMQ_VERSION

RUN curl -o logback-core-$LOGBACK_VERSION.jar \
                "http://central.maven.org/maven2/ch/qos/logback/logback-core/$LOGBACK_VERSION/logback-core-$LOGBACK_VERSION.jar"

RUN curl -fsSL -o activemq.tar.gz \
		"https://archive.apache.org/dist/activemq/$ACTIVEMQ_VERSION/$ACTIVEMQ-bin.tar.gz" \
    && tar xf activemq.tar.gz -C /usr/src/ \
    && mv /usr/src/$ACTIVEMQ /opt/activemq \
    && cp -r /opt/activemq/conf /opt/activemq/conf_bak \
    && mv logback-core-$LOGBACK_VERSION.jar /opt/activemq/lib/logback-core-$LOGBACK_VERSION.jar \
    && rm activemq.tar.gz \
    && rm /opt/activemq/lib/jcl-over-slf4j-1.7.25.jar \
    && rm /opt/activemq/lib/optional/slf4j-log4j12-1.7.25.jar
    

EXPOSE 8161 61616 5672 61613 1883 61614

VOLUME ["/opt/activemq/data", "/opt/activemq/conf"]

WORKDIR /opt/activemq/

CMD ["/opt/activemq/bin/activemq", "console"]
