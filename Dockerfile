# Multistep build pahse # multi stage
#1. build phase using AS to tag the stage name bulider phase
FROM node:alpine as builder 
WORKDIR '/app'
# only bulid the image if there is chang in package json file */
COPY package.json .
# install Dependices 
RUN npm install
# takes public directory (src) and copy into WORKDIR = app folder
COPY . .
# using run command to build
RUN npm run build 

# 2. Run Phase using Ngnix
# From here meaning pervious block all complted new started 
FROM nginx
# copying over files needed from build Phase
COPY --from=builder /app/build /usr/share/nginx/html
