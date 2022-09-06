FROM adoptopenjdk/openjdk8:debian-slim

ENV Z_HOME="/opt/zeppelin" \
    Z_VERSION="0.9.0" \
    ZEPPELIN_ADDR="0.0.0.0"

# install wget and python
RUN apt-get update \
    && apt-get install -y wget python3 python3-pip

# install zeppelin with python interpreter
WORKDIR ${Z_HOME}
RUN wget -O zeppelin.tgz http://archive.apache.org/dist/zeppelin/zeppelin-${Z_VERSION}/zeppelin-${Z_VERSION}-bin-netinst.tgz \
    && tar -zxvf zeppelin.tgz -C ./ --strip-components=1 \
    && rm zeppelin.tgz \
	&& ./bin/install-interpreter.sh --name python,jdbc,md,shell

# remove files to reduce image size
RUN rm -r ./notebook/* \
	# remove all interpreters except python
    && find ./interpreter \
    -mindepth 1 \
    -maxdepth 1 \
    -type d \
    -not \( -name 'jdbc' -o -name 'md' -o -name 'python' -o -name 'sh' -o -name 'shell' \) \
    -exec rm -rf {} \; \
    ## remove unused jars
    && rm ./lib/icu* \
	&& rm ./lib/atomix* \
	&& rm ./lib/flexmark* \
	&& rm ./lib/bcp* \
	&& rm ./lib/netty* \
	&& rm ./lib/openhtmltopdf* \
	&& rm ./lib/quartz* \
   ## remove plugins
    && rm -r ./plugins

RUN wget https://repo1.maven.org/maven2/org/postgresql/postgresql/42.5.0/postgresql-42.5.0.jar

# copy zeppelin config
COPY conf/interpreter.json conf/interpreter-list conf/zeppelin-site.xml ./conf/

# zeppelin runs on port 8080
EXPOSE 8080

# start zeppelin
CMD ["bin/zeppelin.sh"]
