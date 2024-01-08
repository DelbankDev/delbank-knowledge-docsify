FROM node:latest
#LABEL description="A demo Dockerfile for build Docsify."
WORKDIR /app
COPY . /app/
RUN npm install -g docsify-cli@latest
EXPOSE 3000/tcp
ENTRYPOINT docsify serve ./docs