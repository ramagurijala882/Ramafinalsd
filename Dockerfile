# Use the official Nginx image from the Docker Hub
FROM nginx:alpine

# Set the working directory to /usr/share/nginx/html (the default Nginx web root)
WORKDIR /usr/share/nginx/html

# Copy your HTML, CSS, and any other static files into the container
COPY . .

# Expose port 80 (the port Nginx serves on)
EXPOSE 80

# Nginx will automatically start and serve your content
