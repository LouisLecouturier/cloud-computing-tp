FROM python:3.12-slim

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Install poetry
RUN pip install poetry

# Install dependencies
RUN poetry install

# Make port 8000 available to the world outside this container
EXPOSE 8000

# Run fastapi when the container launches
CMD ["poetry", "run", "uvicorn", "main:app"]