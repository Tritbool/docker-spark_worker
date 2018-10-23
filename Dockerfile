FROM java:8

WORKDIR /opt

RUN apt-get update \ 
&& apt-get install -y wget \
&& wget http://mirror.ibcp.fr/pub/apache/spark/spark-2.3.2/spark-2.3.2-bin-hadoop2.7.tgz \
&& tar zxf spark-2.3.2-bin-hadoop2.7.tgz \
&& rm spark-2.3.2-bin-hadoop2.7.tgz \
&& export SPARK_HOME=/opt/spark-2.3.2-bin-hadoop2.7

ADD slaves /opt/spark-2.3.2-bin-hadoop2.7/conf
ADD spark-defaults.conf /opt/spark-2.3.2-bin-hadoop2.7/conf
ADD spark-env.sh /opt/spark-2.3.2-bin-hadoop2.7/conf
ADD log4j.properties /opt/spark-2.3.2-bin-hadoop2.7/conf

ENV PATH $PATH:/opt/spark-2.3.2-bin-hadoop2.7/sbin
ENV PATH $PATH:/opt/spark-2.3.2-bin-hadoop2.7/bin
ENV SPARK_MASTER_LOG /spark/logs

EXPOSE 8081
