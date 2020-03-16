# Multi phase dockerfile
# Build phase
FROM node:alpine as builder

# If we want to deploy to AWS, you want to make sure WORKDIR
# is something that AWS doesn't barf on. When I add it as /app
# it would not deploy.
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
