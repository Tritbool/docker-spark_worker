#!/bin/bash

mkdir -p $SPARK_WORKER_LOG

mkdir -p /tmp/spark-events

spark-class org.apache.spark.deploy.worker.Worker  $SPARK_MASTER_HOST >> $SPARK_WORKER_LOG/spark-worker.out
