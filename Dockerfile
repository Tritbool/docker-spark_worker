FROM java:8

WORKDIR /opt

RUN apt-get update \ 
&& apt-get install -y wget \
&& wget http://mirror.ibcp.fr/pub/apache/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz \
&& tar zxf spark-2.4.0-bin-hadoop2.7.tgz \
&& rm spark-2.4.0-bin-hadoop2.7.tgz 

ADD slaves /opt/spark-2.4.0-bin-hadoop2.7/conf
ADD spark-defaults.conf /opt/spark-2.4.0-bin-hadoop2.7/conf
ADD spark-env.sh /opt/spark-2.4.0-bin-hadoop2.7/conf
ADD log4j.properties /opt/spark-2.4.0-bin-hadoop2.7/conf

ENV PATH $PATH:/opt/spark-2.4.0-bin-hadoop2.7/sbin
ENV PATH $PATH:/opt/spark-2.4.0-bin-hadoop2.7/bin
ENV SPARK_HOME /opt/spark-2.4.0-bin-hadoop2.7
ENV SPARK_WORKER_LOG /opt/spark-2.4.0-bin-hadoop2.7/logs
ENV SPARK_MASTER_HOST spark://spark-master:7077

RUN chmod +x /opt/spark-2.4.0-bin-hadoop2.7/sbin/* && chmod +x /opt/spark-2.4.0-bin-hadoop2.7/bin/*

EXPOSE 8081

COPY worker.sh /opt

CMD ["mkdir", "-p", "$SPARK_WORKER_LOG"]
CMD ["/bin/bash", "/opt/worker.sh"]
