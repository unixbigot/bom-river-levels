FROM node:18
RUN mkdir -p /usr/src/node-red
RUN mkdir /data
RUN useradd --home-dir /usr/src/node-red --no-create-home node-red \
    && chown -R node-red:node-red /usr/src/node-red \
    && chown -R node-red:node-red /data \
    && usermod -a -G dialout node-red
USER node-red
WORKDIR /usr/src/node-red
ADD node-red/package.json /usr/src/node-red/
ADD node-red/ /data
RUN npm install
EXPOSE 1880
ENV FLOWS=flows.json
CMD ["npm", "start", "--", "--userDir", "/data"]
