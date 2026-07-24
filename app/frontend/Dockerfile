# Base Image
FROM node:22-alpine

# Working Directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application source
COPY . .

# Expose React port
EXPOSE 5173

# Start the application
CMD ["npm", "run", "dev", "--", "--host"]
