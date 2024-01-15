FROM 286358998086.dkr.ecr.us-east-1.amazonaws.com/node:14-alpine
WORKDIR /app
COPY . /app/
RUN npm install -g docsify-cli@latest
EXPOSE 80
ENTRYPOINT docsify serve ./docs --port 80
