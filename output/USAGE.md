# 📚 Social Media Development Agent - Usage Guide

## Table of Contents
- [Quick Start](#quick-start)
- [Usage Modes](#usage-modes)
- [Configuration](#configuration)
- [Examples](#examples)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)

---

## Quick Start

### 1. Setup

```bash
cd /workspace/project/output

# Set your API key
export LLM_API_KEY='your-api-key-here'

# Install dependencies
pip install -r requirements.txt

# Or use the setup script
chmod +x setup_and_run.sh
./setup_and_run.sh
```

### 2. Run the Agent

```bash
# Interactive mode
python social_media_dev_agent.py --interactive

# Single task
python social_media_dev_agent.py "Build a social media app with chat"
```

---

## Usage Modes

### Mode 1: Interactive Mode ⭐ Recommended

Best for exploring and iterating on requirements.

```bash
python social_media_dev_agent.py --interactive
```

**Example Session:**
```
You: Build me a social media app with posts and chat
Agent: I'll develop a complete social media application with posts and chat features.

[Agent processes and creates the app...]

You: Add video calling feature
Agent: Adding video calling to the existing app.

[Agent updates the app...]

You: exit
```

### Mode 2: Single Task Mode

Best for automated workflows or CI/CD.

```bash
python social_media_dev_agent.py "Build a social media app with posts and chat"
```

---

## Configuration

### Environment Variables

Create a `.env` file or export:

```bash
# Required
export LLM_API_KEY='your-api-key'

# Optional - customize model
export LLM_BASE_MODEL='openhands/claude-sonnet-4-5-20250929'

# Optional - API base URL
export LLM_BASE_URL='https://api.example.com/v1'
```

### Command Line Options

```bash
python social_media_dev_agent.py [OPTIONS] [requirements...]

Options:
  -i, --interactive    Run in interactive mode
  --model MODEL         LLM model to use (default: openhands/claude-sonnet-4-5-20250929)
  --output DIR          Output directory (default: /workspace/project/output)
  -h, --help            Show help
```

---

## Examples

### Example 1: Basic Social Media App

```bash
python social_media_dev_agent.py "Create a social media app with user profiles, posts, likes, and comments"
```

**Output:**
- Complete Flutter project
- User authentication
- Profile management
- Post creation and feed
- Like and comment system
- Firebase backend

---

### Example 2: App with Chat

```bash
python social_media_dev_agent.py "Build a social media app with messaging feature for real-time chat"
```

**Output:**
- All basic features
- Real-time messaging
- Direct messages
- Group chats
- Message notifications

---

### Example 3: Full-Featured App

```bash
python social_media_dev_agent.py "Develop a complete social media platform with posts, stories, chat, video calls, live streaming, and groups"
```

**Output:**
- All basic features
- Stories (24hr ephemeral content)
- Real-time messaging
- Video/audio calls
- Live streaming
- Groups and communities
- Push notifications
- Freemium monetization

---

### Example 4: Specific Requirements

```bash
# Specify monetization
python social_media_dev_agent.py "Create a social media app with subscription-based premium features"

# Specify target audience
python social_media_dev_agent.py "Build a social media app for Gen Z with video-first features and trending content"

# Specify region
python social_media_dev_agent.py "Develop a social media app for Indonesian market with local language support"
```

---

### Example 5: Adding Features to Existing App

In interactive mode:

```
You: Build a basic social media app first
Agent: [Creates basic app]

You: Now add video calling feature
Agent: [Adds video calling]

You: Add live streaming
Agent: [Adds live streaming]

You: Implement premium subscription
Agent: [Adds monetization]
```

---

## Customization

### 1. Modify Technical Stack

Edit the agent prompt or create a custom version:

```python
# In social_media_dev_agent.py
prompt = f"""
... existing prompt ...

# Add your customizations:
- Use Riverpod instead of BLoC
- Add GraphQL backend
- Use GetX navigation
"""
```

### 2. Add New Features

The agent supports adding features dynamically:

```
You: Add a marketplace feature to buy and sell items
Agent: [Adds e-commerce functionality]
```

### 3. Customize UI/UX

After generation, customize in the Flutter project:

```dart
// lib/core/theme/app_theme.dart
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.yourColor,  // Change this
        brightness: Brightness.light,
      ),
    );
  }
}
```

### 4. Change Backend

Modify Firebase configuration:

```bash
# Replace configuration files
cp /path/to/your/google-services.json social_app/android/app/
cp /path/to/your/GoogleService-Info.plist social_app/ios/Runner/
```

---

## Workflow

### Development Cycle

```
1. Requirements → 2. Planning → 3. Implementation → 4. Testing → 5. Deployment
     ↑                                                              ↓
     └──────────────────────────────────────────────────────────────┘
                           Iteration & Refinement
```

### Phase Details

#### Phase 1: Requirements
- User provides natural language requirements
- Agent analyzes and clarifies if needed
- Create detailed specification

#### Phase 2: Planning
- Design architecture
- Plan data models
- Define Firebase schema
- Create implementation roadmap

#### Phase 3: Implementation
- Generate Flutter code
- Configure Firebase
- Implement features
- Write tests

#### Phase 4: Testing
- Run flutter analyze
- Build verification
- Feature validation
- Code review

#### Phase 5: Deployment
- Build APK/IPA
- Deploy to Firebase App Distribution
- Submit to stores (manual step)

---

## Troubleshooting

### Issue: API Key Not Found

```bash
# Check if API key is set
echo $LLM_API_KEY

# If not, set it
export LLM_API_KEY='your-key'
```

### Issue: Build Fails

```bash
cd /workspace/project/output/social_app

# Clean and reinstall
flutter clean
flutter pub get
flutter pub upgrade

# Check for errors
flutter analyze

# Try building again
flutter build apk --debug
```

### Issue: Agent Not Responding

1. Check API key validity
2. Check internet connection
3. Check API rate limits
4. Try with shorter requirements

### Issue: Firebase Connection Error

1. Verify google-services.json is in correct location:
   ```bash
   ls social_app/android/app/google-services.json
   ```

2. Check Firebase Console configuration
3. Verify package name matches

### Issue: Missing Dependencies

```bash
cd /workspace/project/output/social_app
flutter pub get
```

---

## Advanced Usage

### 1. Programmatic Usage

```python
from social_media_dev_agent import SocialMediaDevAgent

# Initialize agent
agent = SocialMediaDevAgent(
    api_key='your-key',
    model='openhands/claude-sonnet-4-5-20250929'
)

# Develop app
result = agent.develop_app(
    requirements="Build a social media app"
)

# Access results
print(result['status'])
print(result['app_path'])
```

### 2. Custom Sub-Agents

```python
# Add custom sub-agents
custom_agent = AgentDefinition(
    name="custom",
    description="Custom functionality",
    tools=["file_editor", "terminal"],
    system_prompt="Your custom prompt"
)

register_agent(...)
```

### 3. Batch Processing

```bash
# Create requirements file
cat > requirements.txt << EOF
Build a social media app
Build a chat application
Build an e-commerce app
EOF

# Process batch
while read requirement; do
    python social_media_dev_agent.py "$requirement"
done < requirements.txt
```

---

## Best Practices

### 1. Start Small
- Begin with MVP features
- Add complexity gradually
- Test each addition

### 2. Be Specific
- ✗ "Build a social app"
- ✓ "Build a social app with posts, comments, and direct messaging"

### 3. Iterate
- Generate initial version
- Review and test
- Request specific improvements

### 4. Document
- Add comments to custom code
- Update SPEC.md with changes
- Maintain changelog

### 5. Version Control
```bash
cd /workspace/project/output
git init
git add .
git commit -m "Initial social media app"
```

---

## Integration Examples

### CI/CD Pipeline

```yaml
# .github/workflows/build.yml
name: Build Social App

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-python@v2
      - run: pip install openhands-sdk
      - run: |
          export LLM_API_KEY=${{ secrets.LLM_API_KEY }}
          python social_media_dev_agent.py "Build social app"
      - run: |
          cd social_app
          flutter build apk --release
      - uses: actions/upload-artifact@v2
        with:
          name: app
          path: social_app/build/app/outputs/flutter-apk/app-release.apk
```

### Docker Integration

```dockerfile
# Dockerfile
FROM python:3.9

RUN pip install openhands-sdk

WORKDIR /app
COPY . /app

CMD ["python", "social_media_dev_agent.py", "--interactive"]
```

---

## Support

### Resources
- OpenHands SDK: https://github.com/OpenHands/software-agent-sdk
- Flutter Documentation: https://docs.flutter.dev
- Firebase Documentation: https://firebase.google.com/docs

### Getting Help
1. Check this documentation
2. Review SPEC.md for technical details
3. Check troubleshooting section
4. Open an issue with:
   - Error message
   - Steps to reproduce
   - Expected vs actual behavior

---

## Roadmap

### Planned Features
- [ ] Automated deployment to Firebase
- [ ] App Store/Play Store submission
- [ ] Enhanced AI capabilities
- [ ] Real-time collaboration
- [ ] Advanced analytics
- [ ] Multi-tenant architecture
- [ ] GraphQL API option
- [ ] Offline-first support

### Contributing
Contributions welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request
4. Follow coding standards

---

**Last Updated**: 2024
**Version**: 1.0.0
