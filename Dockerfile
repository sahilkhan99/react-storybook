# The Node version that we'll be running for our version of React.
# You may have to search the Node directory for a version that fits
# the version of React you're using.
# FROM node:12.2.0-alpine
FROM node:8.10.0

# Create a work directory and copy over our dependency manifest files.
RUN mkdir /app

# RUN chown node /app
# Use node user from carbon image
# USER node

WORKDIR /app


# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json package-lock.json /app/
RUN npm install

# copy all the source
COPY . /app

# RUN npm install react-scripts@1.1.1 -g --silent
# Run BUILD 
RUN npm run build

# build story book
RUN npm run storybook:build

# Expose PORT 3000 on our virtual machine so we can run our server
EXPOSE 6006

# start app
CMD ["npm", "start"]