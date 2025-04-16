# Use the official Nginx image from the Docker Hub
FROM nginx:alpine

# Set the working directory to /usr/share/nginx/html (the default Nginx web root)
WORKDIR /usr/share/nginx/html

# Copy your HTML, CSS, and any other static files into the container
COPY . .

# Expose port 80 to allow external access to the server
EXPOSE 80

# The default command for Nginx is already set to start the server
# So no need to define a CMD unless you want to customize it
