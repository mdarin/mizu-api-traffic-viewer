### Front-end common
FROM node:16 AS front-end-common

WORKDIR /app/ui-build
COPY ui-common/package.json .
COPY ui-common/package-lock.json .
RUN npm i
COPY ui-common .
RUN npm pack

### Front-end
FROM node:16 AS front-end

WORKDIR /app/ui-build

COPY ui/package.json ui/package-lock.json ./
COPY --from=front-end-common ["/app/ui-build/up9-mizu-common-0.0.0.tgz", "."]
RUN npm i
COPY ui .
RUN npm run build

### Final copy builded app into host site/ directory
FROM alpine AS output

RUN apk add --no-cache bash rsync

VOLUME [ "/output" ]

COPY --from=front-end /app/ui-build/build /output

COPY scripts/build-ui/sync-output.sh /usr/local/bin 
RUN chmod +x /usr/local/bin/sync-output.sh

CMD [ "sync-output.sh" ]

# *INFO:
# COPYing a file in a Dockerfile, no such file or directory?
# https://stackoverflow.com/questions/32997269/copying-a-file-in-a-dockerfile-no-such-file-or-directory
