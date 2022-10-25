FROM moussavdb/runtime-java:17

LABEL maintainer="Grégory Van den Borre vandenborre.gregory@hotmail.fr"

ENV ACTIVEMQ_VERSION 5.17.2

ENV ACTIVEMQ apache-activemq-5.17.2

RUN mkdir /usr/src

RUN curl -fsSL -o activemq.tar.gz \
		"https://archive.apache.org/dist/activemq/5.17.02apache-activemq-5.17.2-bin.tar.gz" \
    && tar xf activemq.tar.gz -C /usr/src/ \
    && mv /usr/src/apache-activemq-5.17.2 /opt/activemq \
    && cp -r /opt/activemq/conf /opt/activemq/conf_bak \
    && rm activemq.tar.gz

EXPOSE 8161 61616 5672 61613 1883 61614

VOLUME ["/opt/activemq/data", "/opt/activemq/conf"]

WORKDIR /opt/activemq/

CMD ["/opt/activemq/bin/activemq", "console"]

HEALTHCHECK --interval=1m CMD curl -f http://localhost:8161/ || exit 1
