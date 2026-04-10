#!/bin/bash

# Configuration
PROJECT_DIR="/Users/garv/Documents/Projects/Renkai"
BACKEND_DIR="$PROJECT_DIR/backend"
FRONTEND_DIR="$PROJECT_DIR/frontend"

echo "======================================"
echo "    Renkai Project Setup Script"
echo "======================================"

echo "Creating project directories..."
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR" || exit

# 1. Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# 2. Install Dependencies (Java, Flutter, Docker, CocoaPods)
echo "Installing/Updating required dependencies..."
brew install java17 || brew install openjdk@17
brew install --cask flutter
brew install --cask docker
brew install cocoapods
brew install jq
brew install spring-boot

# Set up Java symlink if needed
sudo ln -sfn $(brew --prefix)/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk

echo "======================================"
echo "    Scaffolding Spring Boot Backend"
echo "======================================"
if [ ! -d "$BACKEND_DIR" ]; then
    mkdir -p "$BACKEND_DIR"
    cd "$BACKEND_DIR" || exit
    
    # We will fetch a pre-configured zip from Spring Initializr
    echo "Downloading Spring Boot Base..."
    curl https://start.spring.io/starter.zip \
        -d dependencies=web,data-jpa,postgresql,validation,security,actuator \
        -d type=maven-project \
        -d language=java \
        -d bootVersion=3.2.4 \
        -d baseDir=renkai-backend \
        -d groupId=com.renkai \
        -d artifactId=api \
        -d name=RenkaiBackend \
        -d description="Backend for Renkai App" \
        -d packageName=com.renkai.api \
        -d packaging=jar \
        -d javaVersion=17 -o backend.zip
    
    unzip backend.zip -d .
    mv renkai-backend/* .
    mv renkai-backend/.* . 2>/dev/null
    rm -rf renkai-backend backend.zip
    
    echo "Backend Scaffolded successfully."
else
    echo "Backend directory already exists. Skipping scaffolding."
fi

# Switch back to root
cd "$PROJECT_DIR" || exit

echo "======================================"
echo "    Scaffolding Flutter Frontend"
echo "======================================"
if [ ! -d "$FRONTEND_DIR" ]; then
    echo "Accepting Android/Flutter licenses if any (requires user interaction often, doing auto)..."
    yes | flutter doctor --android-licenses 2>/dev/null
    
    echo "Creating Flutter app..."
    flutter create --org com.renkai --project-name renkai_app frontend
    cd frontend || exit
    
    echo "Adding required Flutter packages..."
    flutter pub add flutter_riverpod hooks_riverpod
    flutter pub add go_router
    flutter pub add dio
    flutter pub add google_fonts
    flutter pub add lottie
    flutter pub add shared_preferences
    flutter pub add flutter_spinkit
    
    echo "Frontend Scaffolded successfully."
else
    echo "Frontend directory already exists. Skipping scaffolding."
fi

echo "======================================"
echo "Setup is complete!"
echo "Please verify Flutter doctor by running: flutter doctor"
echo "======================================"
