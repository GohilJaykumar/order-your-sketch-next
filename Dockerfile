# Step 1: Optional builder (for consistency with Next.js style)
FROM node:18 AS builder

WORKDIR /app

# Copy all files (index.html, CSS, JS, images, etc.)
COPY . .

# No build step needed for plain HTML, but keeping the stage for parity with Next.js Dockerfile

# Step 2: Serve with Nginx
FROM nginx:alpine

# Remove default Nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy static site from builder
COPY --from=builder /app /usr/share/nginx/html

# Expose internal Nginx port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
