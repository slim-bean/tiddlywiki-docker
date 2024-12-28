ARG TARGET_PLATFORM=linux/amd64
FROM --platform=${TARGET_PLATFORM} node:alpine

RUN npm install -g tiddlywiki@5.3.6

RUN addgroup -g 10001 -S tiddlywiki && \
    adduser -u 10001 -S tiddlywiki -G tiddlywiki
RUN mkdir -p /var/lib/tiddlywiki && \
    chown -R tiddlywiki:tiddlywiki /var/lib/tiddlywiki

USER tiddlywiki

WORKDIR /var/lib/tiddlywiki

# Add init-and-run script
ADD init-and-run-wiki /usr/local/bin/init-and-run-wiki

# Meta
ENTRYPOINT ["/bin/sh"]
CMD ["/usr/local/bin/init-and-run-wiki"]
