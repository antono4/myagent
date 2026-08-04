#!/bin/bash
# Social Media Development Agent - Setup and Run Script

set -e

echo "=================================="
echo "Social Media Dev Agent Setup"
echo "=================================="

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print colored text
print_color() {
    echo -e "${2}${1}${NC}"
}

# Check Python version
print_color "Checking Python version..." "$BLUE"
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version 2>&1 | cut -d' ' -f2 | cut -d'.' -f1,2)
    print_color "Python $PYTHON_VERSION found" "$GREEN"
else
    print_color "Python 3 is required but not found. Please install Python 3.8+" "$RED"
    exit 1
fi

# Check Flutter
print_color "Checking Flutter..." "$BLUE"
if command -v flutter &> /dev/null; then
    FLUTTER_VERSION=$(flutter --version 2>&1 | head -1)
    print_color "$FLUTTER_VERSION" "$GREEN"
else
    print_color "Flutter not found. Please install Flutter SDK." "$YELLOW"
    print_color "Install from: https://docs.flutter.dev/get-started/install" "$YELLOW"
fi

# Check API Key
print_color "Checking API Key..." "$BLUE"
if [ -z "$LLM_API_KEY" ]; then
    print_color "LLM_API_KEY not set!" "$RED"
    print_color "Please set your API key:" "$YELLOW"
    echo "  export LLM_API_KEY='your-api-key-here'"
    echo ""
    echo "Or create a .env file:"
    echo "  echo 'LLM_API_KEY=your-key' > .env"
else
    print_color "API Key found ✓" "$GREEN"
fi

# Install dependencies
print_color "Installing Python dependencies..." "$BLUE"
pip install -r requirements.txt
print_color "Dependencies installed ✓" "$GREEN"

# Create output directory
mkdir -p /workspace/project/output/social_app

print_color "" "$BLUE"
print_color "==================================" "$BLUE"
print_color "Setup Complete!" "$GREEN"
print_color "==================================" "$BLUE"
echo ""
echo "Next steps:"
echo ""
echo "1. Set your API key (if not already set):"
echo "   export LLM_API_KEY='your-api-key'"
echo ""
echo "2. Run the agent:"
echo "   # Interactive mode:"
echo "   python social_media_dev_agent.py --interactive"
echo ""
echo "   # With requirements:"
echo "   python social_media_dev_agent.py \"Build a social media app\""
echo ""
echo "3. Generated app will be in:"
echo "   /workspace/project/output/social_app/"
echo ""
echo "4. To run the Flutter app:"
echo "   cd /workspace/project/output/social_app"
echo "   flutter pub get"
echo "   flutter run"
echo ""
