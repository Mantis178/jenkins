#!/bin/bash

# Function to check if Docker is installed
check_docker_installed() {
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed. Installing Docker..."
        install_docker
    else
        echo "Docker is already installed."
    fi
}

install_docker() {
    sudo yum update -y
    sudo yum install -y docker
    sudo service docker start
    sudo usermod -aG docker ec2-user

    if command -v docker &> /dev/null; then
        echo "Docker installed successfully."
    else
        echo "Docker installation failed."
        exit 1
    fi
}

build_and_run_docker() {
    IMAGE_NAME="my-docker-image"

    docker build -t $IMAGE_NAME . 

    echo "Running the Docker container..."
    docker run --rm $IMAGE_NAME
}

# Main script execution
echo "Checking if Docker is installed..."
check_docker_installed

echo "Building and running Docker container..."
build_and_run_docker
