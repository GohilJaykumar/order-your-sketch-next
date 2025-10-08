FROM nginx:alpine

# Remove default Nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy static site files
COPY . /usr/share/nginx/html

# Expose internal port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
