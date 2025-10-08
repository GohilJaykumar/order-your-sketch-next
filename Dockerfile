# Step 1: Optional builder (for consistency with Next.js style)
FROM node:18 AS builder

WORKDIR /app

# Copy all static site files (index.html, CSS, JS, images, etc.)
COPY . .

# No build step required for pure HTML site

# Step 2: Serve with Nginx
FROM nginx:alpine

# Remove default Nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy static site from builder
COPY --from=builder /app /usr/share/nginx/html

# Configure Nginx to listen on port 7001
RUN echo 'server {\n\
    listen       7001;\n\
    server_name  localhost;\n\
    location / {\n\
        root   /usr/share/nginx/html;\n\
        index  index.html;\n\
        try_files $uri /index.html;\n\
    }\n\
}' > /etc/nginx/conf.d/default.conf

# Expose internal container port 7001
EXPOSE 7001

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
