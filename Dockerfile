#It will use node:19-alpine3.16 as the parent image for building the Docker image
FROM node:19-alpine3.16

#It will create a working directory for Docker. The Docker image will be created in this working directory.
WORKDIR /test

#Copy the React.js application dependencies from the package.json to the react-app working directory.
COPY package.json .

COPY package-lock.json .

#install all the React.js application dependencies
RUN npm i
RUN apk add curl \
  && curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/bin

COPY . .

#Expose the React.js application container on port 3000
EXPOSE 3000

#The command to start the React.js application container
CMD ["npm", "start"]