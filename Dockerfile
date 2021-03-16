# MULTI-STEP DOCKERFILE

# BUILDER phase
FROM node:alpine
# We could also tag this phase like this:
# FROM node:alpine as builder

WORKDIR '/home/node/app'

# Fix permissions for 'node' user before copying
COPY --chown=node:node package.json .
RUN npm install

COPY --chown=node:node . .

RUN npm run build


# RUN phase
FROM nginx

# Copy over the result of 'npm run build' in the BUILD phase
COPY --from=0 /home/node/app/build /usr/share/nginx/html
# We could also used the tag, like:
# COPY --from=builder /home/node/app/build /usr/share/nginx/html

# PS: the nginx image already has the CMD to run nginx
