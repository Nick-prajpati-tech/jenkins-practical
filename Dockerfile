# Use a base image (e.g., Python)
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the rest of the code
COPY . .

# Expose port (if needed)
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
