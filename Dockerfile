#FROM lambci/lambda:build-python3.8
ARG DOCKER_MIRROR=''
FROM ${DOCKER_MIRROR}lambci/lambda:build-python3.8

WORKDIR /root

RUN pip3 install -t /root/to_zip/python botocore && \
cd /root/to_zip; zip -9yr /root/layer.zip . && \
cd python; python3 -c "import botocore; print(botocore.__version__)" > /root/VERSION
