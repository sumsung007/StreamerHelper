FROM node:alpine
WORKDIR /app
# copy project file
COPY package.json .
# install ffmpeg
RUN apk update && \
    apk add yasm && \
    apk add ffmpeg python3 make gcc g++ musl-dev tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata
# install node packages
RUN npm set progress=false && npm config set depth 0
RUN npm i
# compile
COPY . /app
RUN npm run build

CMD node /app/dist/app.js
