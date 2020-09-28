# Multistep build pahse # multi stage
#1. build phase using AS to tag the stage name bulider phase
FROM node:alpine 
WORKDIR '/app'
# only bulid the image if there is chang in package json file */
COPY package*.json ./
# install Dependices 
RUN npm install
# takes public directory (src) and copy into WORKDIR = app folder
COPY . .
# using run command to build
RUN npm run build 
RUN npm run test
# 2. Run Phase using Ngnix
# From here meaning pervious block all complted new started 
FROM nginx
#exposing port 80 for AWS
EXPOSE 80
# copying over files needed from build Phase
COPY --from=0 /app/build /usr/share/nginx/html
