# Multi phase dockerfile
# Build phase
FROM node:alpine as builder

WORKDIR '/usr/app'

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# start the run phase
FROM nginx
# EXPOSE Needed because AWS will not do this automatically
EXPOSE 80 
COPY --from=builder /usr/app/build /usr/share/nginx/html
