# Use an official Node.js runtime as the base image
FROM node:lts-alpine3.19

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

EXPOSE 3000

# Start the app
CMD ["node", "app.js"]
