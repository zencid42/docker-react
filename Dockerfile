
#setup project to build node application
FROM node:alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . . 
RUN npm run build

#second phase that copyies files built in the first phase to run with nginx
FROM nginx
#elasticbeanstalk needs this expose as an instruction. for local instances it does nothing
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html


