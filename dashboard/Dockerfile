FROM quay.io/redhatgov/workshop-terminal:latest

USER root

RUN curl -sL -o /tmp/tkn.tar.gz https://github.com/tektoncd/cli/releases/download/v0.11.0/tkn_0.11.0_Linux_x86_64.tar.gz && \
    tar -C /usr/local/bin -zxf /tmp/tkn.tar.gz tkn && \
    rm /tmp/tkn.tar.gz

RUN HOME=/opt/workshop/reveal.js && \
    mkdir /opt/workshop/reveal.js && \
    cd /opt/workshop/reveal.js && \
    curl -sL -o src.tar.gz https://github.com/hakimel/reveal.js/archive/3.8.0.tar.gz && \
    tar --strip-components 1 -xf src.tar.gz && \
    rm src.tar.gz

COPY renderer /opt/workshop/renderer

RUN HOME=/opt/workshop/renderer && \
    cd /opt/workshop/renderer && \
    npm install --production

COPY gateway/. /opt/workshop/gateway/.
COPY renderer/static/css/image-overlay.css /opt/workshop/gateway/static/css/image-overlay.css

COPY bin/. /opt/workshop/bin/.
COPY etc/. /opt/workshop/etc/.

USER 1001
