FROM centos as BUILDPHASE
SHELL ["/bin/bash", "-c"]
WORKDIR '/application'
COPY ./package.json .
RUN yum update -y
RUN yum install -y gcc-c++ make
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash -
RUN yum install nodejs -y
RUN npm install
COPY . .
RUN npm run build

FROM nginx as RUNPHASE
COPY --from=BUILDPHASE /application/build /usr/share/nginx/html
