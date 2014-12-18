Redback base image
==================

This docker file is used to provide a base image for the [redback](https://bitbucket.org/knservis/redback) service. 

Building the image
------------------

Make sure you have [docker](https://www.docker.com/) installed, then in the directory you have the Dockerfile do: 

    docker build -t knservis/redback-base:1.0.0 .

Publish the image
-----------------

In order to publish the [docker registry](https://hub.docker.com/) you simply have to do something like:

    docker push knservis/redback-base:1.0.0

Using the image
---------------

To run redback you somehow have to provide a configuration file similar to the one found in: 

    /app/redback/ABCRedback/target/classes/redback.properties.sample

One easy way to do it is to create a new Docker file which will contain:

    FROM knservis/redback-base:1.0.0
    WORKDIR /app/redback
    ADD redback.properties /app/redback/redback.properties
    CMD java -Daws.accessKeyId=<access-key> -Daws.secretKey=<secret-key> -jar release/red-back-1.0.0-jar-with-dependencies.jar -config redback.properties

