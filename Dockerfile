# Step 1: Build the application
FROM node:18 AS builder

# Set the working directory
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Build the Next.js application
RUN npm run build

# Step 2: Serve the application in production mode
FROM node:18

# Set the working directory
WORKDIR /app

# Install production dependencies
COPY package.json package-lock.json ./
RUN npm install --only=production

# Copy the built application from the builder
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules

# Expose the port on which the app will run
EXPOSE 7001

# Set the environment variable for the port (Optional, can also be passed at runtime)
ENV PORT=7001

# Start the app in production mode
CMD ["npm", "run", "start", "--", "-p", "${PORT}"]
