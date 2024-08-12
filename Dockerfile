# Use a Node.js image as the base
# FROM node:18
# FROM node:18

# # Set the working directory
# WORKDIR /jp-lang-server
# FROM node:20-alpine
# WORKDIR /jp-lang-server
# RUN apk add --no-cache \
#     cairo-dev \
#  `   pango-dev \
#     jpeg-dev \
#     giflib-dev


FROM node:18-buster
WORKDIR /jp-lang-server
    RUN apt-get update && apt-get install -y \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .



# Build the TypeScript code
RUN npm run build

# Expose the port your application will listen on
EXPOSE 3005

# Start the app
CMD [ "npm" , "start" ]
# CMD [ "npm", "run" , "start" ]



# # Build stage
# FROM node:20-alpine AS builder
# WORKDIR /jp-lang-server
# COPY package*.json ./
# RUN npm install
# COPY . .
# RUN npm run build

# # Production stage
# FROM node:20-alpine as runner
# WORKDIR /app
# COPY --from=builder /jp-lang-server/build /build
# COPY --from=builder /jp-lang-server/package*.json ./

# RUN npm install --production
# EXPOSE 3005

# CMD ["npm", "start"]




# # Build stage
# FROM node:20-alpine AS builder
# WORKDIR /jp-lang-server
# COPY package*.json ./
# RUN npm install
# COPY . .
# RUN npm run build

# RUN ls -la /jp-lang-server/build
# RUN ls -la /jp-lang-server

# # Production stage
# FROM node:20-alpine as runner
# WORKDIR /app
# COPY --from=builder /jp-lang-server/build /app/build
# COPY --from=builder /jp-lang-server/package*.json ./
# COPY --from=builder /jp-lang-server/node_modules ./node_modules

# # Log to ensure files are in place
# RUN ls -la /app/build
# RUN ls -la /app

# EXPOSE 3005
# CMD ["npm", "start"]
