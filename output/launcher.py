#!/usr/bin/env python3
"""
Simple Launcher for Social Media Development Agent

Usage:
    python launcher.py                    # Interactive mode
    python launcher.py <requirement>      # Single task
"""

import sys
import os
from pathlib import Path

# Add current directory to path
script_dir = Path(__file__).parent
sys.path.insert(0, str(script_dir))

try:
    from social_media_dev_agent import SocialMediaDevAgent
except ImportError as e:
    print(f"Error: {e}")
    print("\n" + "="*50)
    print("❌ Missing Dependencies!")
    print("="*50)
    print("\nPlease install the required packages first:")
    print(f"  cd {script_dir}")
    print("  pip install -r requirements.txt")
    print("\nOr set your API key and install openhands:")
    print("  pip install openhands-sdk pydantic")
    print("\n" + "="*50)
    sys.exit(1)


def print_banner():
    """Print the agent banner."""
    banner = """
╔════════════════════════════════════════════════════════════╗
║                                                            ║
║   🤖  Social Media Development Agent                       ║
║                                                            ║
║   AI-powered mobile app development with Flutter         ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
"""
    print(banner)


def print_menu():
    """Print the main menu."""
    menu = """
📋 Main Menu:

1. 🚀 Build Social Media App (Basic)
   - Posts, feed, likes, comments

2. 💬 Build App with Chat
   - + Real-time messaging, group chats

3. 📹 Build App with Video Calls
   - + Video/audio calling

4. 🎥 Build App with Live Streaming
   - + Live broadcasts, reactions

5. 👥 Build App with Groups
   - + Communities, group chats

6. 🌟 Build Complete Social Platform
   - All features combined

7. 💭 Interactive Mode
   - Describe your custom requirements

8. 📖 Documentation
   - View usage guide

9. ❌ Exit
"""
    print(menu)


def get_user_choice():
    """Get user menu choice."""
    try:
        choice = input("Select option (1-9): ").strip()
        return choice
    except (KeyboardInterrupt, EOFError):
        return '9'


def get_requirement(choice):
    """Map menu choice to requirements."""
    requirements = {
        '1': "Build a social media app with user profiles, posts with text and images, likes, comments, and a feed showing posts from all users",
        
        '2': "Build a complete social media application with user profiles, posts, likes, comments, and real-time chat messaging with individual users and group conversations",
        
        '3': "Build a full social media platform with profiles, posts, chat, and video/audio calling features where users can make video calls and voice calls",
        
        '4': "Build a social media app with all core features including posts, chat, and add live streaming capability where users can go live and viewers can watch and interact",
        
        '5': "Build a social media application with profiles, posts, messaging, and group/community features where users can create and join groups with admin controls",
        
        '6': "Build a complete social media platform with ALL features: user profiles, posts with media, stories, real-time chat messaging, video/audio calls, live streaming, groups and communities, notifications, and freemium monetization with premium subscriptions",
        
        '7': None,  # Interactive mode
        
        '8': None,  # Show documentation
    }
    return requirements.get(choice)


def show_documentation():
    """Display documentation."""
    doc = """
╔════════════════════════════════════════════════════════════╗
║                    📖 Documentation                        ║
╚════════════════════════════════════════════════════════════╝

Available Resources:

📄 README.md
   - Complete project overview
   - Installation guide
   - Feature list

📋 SPEC.md
   - Technical specification
   - Architecture details
   - Firebase schema
   - Feature specifications

📖 USAGE.md
   - Detailed usage guide
   - Examples
   - Troubleshooting
   - Advanced usage

📁 Generated App Structure:
   social_app/
   ├── lib/
   │   ├── main.dart
   │   ├── app.dart
   │   ├── core/
   │   ├── data/
   │   ├── domain/
   │   └── presentation/
   ├── pubspec.yaml
   └── firebase.json

Quick Start:
   1. cd /workspace/project/output
   2. export LLM_API_KEY='your-key'
   3. python social_media_dev_agent.py --interactive

For more info, check the README.md file.
"""
    print(doc)


def main():
    """Main launcher function."""
    print_banner()
    
    # Check for API key
    if not os.getenv('LLM_API_KEY'):
        print("⚠️  Warning: LLM_API_KEY not set!")
        print("   Please set it with: export LLM_API_KEY='your-api-key'\n")
    
    # Check for arguments
    if len(sys.argv) > 1:
        # Single task mode
        requirement = ' '.join(sys.argv[1:])
        print(f"🎯 Building app with requirements: {requirement}\n")
        
        try:
            agent = SocialMediaDevAgent()
            result = agent.develop_app(requirement)
            
            print("\n" + "="*60)
            print("✅ Development Complete!")
            print("="*60)
            print(f"\n📁 App location: {result['app_path']}")
            print(f"\n📝 Next steps:")
            print(f"   cd {result['app_path']}")
            print(f"   flutter pub get")
            print(f"   flutter run")
            print()
            
        except Exception as e:
            print(f"\n❌ Error: {e}")
            sys.exit(1)
    else:
        # Interactive menu mode
        while True:
            print_menu()
            choice = get_user_choice()
            
            if choice == '9':
                print("\n👋 Goodbye!")
                break
            
            elif choice == '7':
                # Interactive mode
                print("\n🚀 Starting interactive mode...\n")
                try:
                    agent = SocialMediaDevAgent()
                    agent.run_interactive()
                except KeyboardInterrupt:
                    print("\n\n👋 Session ended.")
                except Exception as e:
                    print(f"\n❌ Error: {e}")
            
            elif choice == '8':
                # Show documentation
                show_documentation()
                input("\nPress Enter to continue...")
            
            elif choice in ['1', '2', '3', '4', '5', '6']:
                # Build app
                requirement = get_requirement(choice)
                if requirement:
                    print(f"\n🎯 Building app...")
                    print(f"   Requirements: {requirement}\n")
                    
                    try:
                        agent = SocialMediaDevAgent()
                        result = agent.develop_app(requirement)
                        
                        print("\n" + "="*60)
                        print("✅ Development Complete!")
                        print("="*60)
                        print(f"\n📁 App location: {result['app_path']}")
                        print(f"\n📝 Next steps:")
                        print(f"   cd {result['app_path']}")
                        print(f"   flutter pub get")
                        print(f"   flutter run")
                        print()
                        
                    except Exception as e:
                        print(f"\n❌ Error: {e}")
                        print("   Make sure LLM_API_KEY is set correctly.")
                        print("   export LLM_API_KEY='your-api-key'")
                        print()
            
            else:
                print("\n⚠️  Invalid option. Please select 1-9.")
            
            input("\nPress Enter to continue...")


if __name__ == "__main__":
    main()
