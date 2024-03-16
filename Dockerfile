# Use the official Node.js image for building the app
FROM node:alpine as build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app files to the working directory
COPY . .

# Build the app for production
RUN npm run build

# Use a lightweight image for serving the app
FROM nginx:alpine

# Copy the production build from the build stage to the nginx web server directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 for the web server
EXPOSE 80