FROM alpine:latest

RUN \
	apk -Uuv add python3 bash zip && \
	pip3 install botocore

RUN mkdir -p /root/python/lib/python3.7/site-packages && \
cp -a /usr/lib/python3.7/site-packages/botocore* /root/python/lib/python3.7/site-packages && \
cd /root; zip -r layer.zip python && \
python3 -c "import botocore; print(botocore.__version__)" > /root/VERSION

