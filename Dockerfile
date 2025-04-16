# Use a base image with Node.js for the healthcare app
FROM node:16

# Set the working directory
WORKDIR /usr/src/app

# Copy the application code
COPY . .

# Install dependencies
RUN npm install

# Expose port 3000
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
