FROM node:lts-alpine

ARG TIDDLYWIKI_VERSION=latest
ARG UID=1000
ARG GID=1000

RUN npm install -g tiddlywiki@${TIDDLYWIKI_VERSION}

RUN deluser --remove-home node 2>/dev/null || true \
 && delgroup node 2>/dev/null || true \
 && addgroup -S -g ${GID} tiddlywiki \
 && adduser  -S -D -G tiddlywiki -u ${UID} -h /data tiddlywiki \
 && mkdir -p /data \
 && chown -R tiddlywiki:tiddlywiki /data

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENV WIKI_NAME=wiki \
    PORT=8080 \
    HOST=0.0.0.0 \
    NODE_OPTIONS=--max-old-space-size=128

WORKDIR /data
USER tiddlywiki

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
