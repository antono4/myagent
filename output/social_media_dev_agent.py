#!/usr/bin/env python3
"""
Social Media App Development Agent
===================================
An AI agent that can autonomously develop complete social media mobile applications
using Flutter and Firebase.

Usage:
    python social_media_dev_agent.py "Build me a social media app with chat and video calls"

Requirements:
    - LLM_API_KEY environment variable
    - Flutter SDK installed
    - Python 3.8+
"""

import os
import sys
import logging
from pathlib import Path
from datetime import datetime

from openhands.sdk import LLM, Agent, Conversation, Tool
from openhands.sdk.subagent import AgentDefinition
from openhands.sdk.agent import agent_definition_to_factory, register_agent
from openhands.tools.terminal import TerminalTool
from openhands.tools.file_editor import FileEditorTool
from openhands.tools.task_tracker import TaskTrackerTool
from openhands.tools.task import TaskToolSet
from openhands.tools.grep import GrepTool
from openhands.tools.planning_file_editor import PlanningFileEditorTool
from openhands.tools.delegate import DelegationVisualizer

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)


class SocialMediaDevAgent:
    """
    Main orchestrator agent for social media app development.
    
    This agent can autonomously:
    - Plan application architecture
    - Generate Flutter/Dart code
    - Configure Firebase backend
    - Implement all social media features
    - Run tests and validate the application
    """
    
    def __init__(self, api_key: str = None, model: str = "openhands/claude-sonnet-4-5-20250929"):
        """
        Initialize the social media development agent.
        
        Args:
            api_key: LLM API key (optional, will use env var if not provided)
            model: LLM model to use
        """
        self.api_key = api_key or os.getenv("LLM_API_KEY")
        if not self.api_key:
            raise ValueError("API key required: set LLM_API_KEY environment variable")
        
        self.model = model
        self.workspace = Path("/workspace/project/output")
        self.workspace.mkdir(parents=True, exist_ok=True)
        
        # Initialize LLM
        self.llm = LLM(
            model=self.model,
            api_key=self.api_key,
        )
        
        # Register sub-agents
        self._register_sub_agents()
        
        # Initialize main orchestrator agent
        self.agent = Agent(
            llm=self.llm,
            tools=[
                Tool(name=TerminalTool.name),
                Tool(name=FileEditorTool.name),
                Tool(name=TaskTrackerTool.name),
                Tool(name=TaskToolSet.name),
                Tool(name=PlanningFileEditorTool.name),
            ],
        )
        
        self.conversation = None
        logger.info("Social Media Development Agent initialized")
    
    def _register_sub_agents(self):
        """Register specialized sub-agents for different tasks."""
        
        # Planning Agent
        planning_agent = AgentDefinition(
            name="planner",
            description="Creates detailed technical specifications and architecture plans for social media apps",
            tools=["file_editor", "terminal", "planning_file_editor"],
            system_prompt="""You are an expert software architect specializing in Flutter mobile development.
            
Your role is to create comprehensive technical specifications for social media applications.

Create a detailed SPEC.md file containing:

## Application Overview
- App name and description
- Target platform (Android/iOS)
- Target audience
- Monetization strategy

## Technical Architecture
- Clean Architecture structure
- State management (BLoC pattern)
- Navigation strategy
- Folder structure

## Firebase Configuration
- Authentication methods
- Firestore database schema (collections and documents)
- Cloud Functions requirements
- Storage buckets
- Security rules

## Feature Specifications
For each feature:
1. Screens required
2. Data models
3. API endpoints
4. State management
5. UI components

## Development Timeline
- Phase breakdown
- Milestones
- Priority order

Use modern Flutter best practices. Be specific and detailed."""
        )
        
        # Code Generation Agent
        code_agent = AgentDefinition(
            name="coder",
            description="Generates complete Flutter/Dart code for social media applications",
            tools=["file_editor", "terminal", "grep"],
            system_prompt="""You are an expert Flutter developer specializing in social media applications.

Your role is to implement complete, production-ready Flutter code.

For every feature requested:

1. **Data Layer**
   - Create model classes
   - Implement Firebase services
   - Create repository interfaces and implementations

2. **Domain Layer**
   - Define entities
   - Create use cases (if needed)
   - Business logic implementation

3. **Presentation Layer**
   - BLoC/Cubit for state management
   - UI screens using Material Design 3
   - Reusable widgets
   - Navigation setup

4. **Configuration**
   - Firebase initialization
   - Dependency injection
   - App routing
   - Theme configuration

Code must be:
- Clean and well-organized
- Properly typed (no dynamic)
- Documented where needed
- Following Flutter/Dart best practices
- Ready for production

Create files in the current workspace directory. Structure:
/workspace/project/output/social_app/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── core/
│   ├── data/
│   ├── domain/
│   └── presentation/
├── pubspec.yaml
└── firebase.json"""
        )
        
        # QA Agent
        qa_agent = AgentDefinition(
            name="qa",
            description="Tests, validates, and ensures quality of the generated application",
            tools=["terminal", "file_editor"],
            system_prompt="""You are an expert in mobile app quality assurance.

Your role is to ensure the generated application meets all quality standards.

Perform these validations:

1. **Code Quality**
   - Run flutter analyze
   - Check for common issues
   - Verify code style

2. **Build Verification**
   - Run flutter pub get
   - Attempt flutter build apk --debug
   - Verify project structure

3. **Test Coverage**
   - Check if unit tests exist
   - Verify widget tests
   - Check integration tests

4. **Feature Validation**
   - Verify all specified features are implemented
   - Check Firebase configuration
   - Validate security rules

5. **Documentation**
   - Verify README exists
   - Check API documentation
   - Review comments

Report any issues found and suggest fixes.

Final output should be a quality report with pass/fail for each category."""
        )
        
        # Register all agents
        register_agent(
            name="planner",
            factory_func=agent_definition_to_factory(planning_agent),
            description=planning_agent,
        )
        
        register_agent(
            name="coder",
            factory_func=agent_definition_to_factory(code_agent),
            description=code_agent,
        )
        
        register_agent(
            name="qa",
            factory_func=agent_definition_to_factory(qa_agent),
            description=qa_agent,
        )
        
        logger.info("Sub-agents registered: planner, coder, qa")
    
    def develop_app(self, requirements: str) -> dict:
        """
        Main method to develop a social media application.
        
        Args:
            requirements: Natural language description of the app requirements
            
        Returns:
            Dictionary with development results and status
        """
        logger.info("Starting social media app development")
        logger.info(f"Requirements: {requirements}")
        
        # Initialize conversation
        self.conversation = Conversation(
            agent=self.agent,
            workspace=str(self.workspace),
            visualizer=DelegationVisualizer(name="Social Media Dev Agent"),
        )
        
        # Create detailed development prompt
        prompt = self._create_development_prompt(requirements)
        
        # Send initial message
        self.conversation.send_message(prompt)
        
        # Run the conversation
        logger.info("Running agent conversation...")
        try:
            self.conversation.run()
        except Exception as e:
            logger.error(f"Error during development: {e}")
            return {
                "status": "error",
                "message": str(e),
                "files_created": [],
            }
        
        # Get results
        result = {
            "status": "success",
            "message": "Development completed",
            "requirements": requirements,
            "workspace": str(self.workspace),
            "app_path": str(self.workspace / "social_app"),
            "timestamp": datetime.now().isoformat(),
        }
        
        logger.info("Development completed successfully")
        return result
    
    def _create_development_prompt(self, requirements: str) -> str:
        """Create a comprehensive development prompt."""
        return f"""
# Social Media App Development Task

You are the main orchestrator for developing a complete social media mobile application.

## Requirements
{requirements}

## Your Task
Develop a complete, production-ready social media application with ALL of the following features:

### Core Features (Required)
1. **Authentication**
   - Email/password signup and login
   - Google Sign-In
   - Password reset functionality
   - Session management

2. **User Profiles**
   - Profile creation and editing
   - Avatar upload to Firebase Storage
   - Bio, name, and personal information
   - Profile privacy settings

3. **Social Graph**
   - Follow/unfollow functionality
   - Followers and following lists
   - User search by name/username
   - Suggested users to follow

4. **Posts & Feed**
   - Create posts with text, images, or videos
   - Timeline/feed showing posts from followed users
   - Like and unlike posts
   - Comment on posts
   - Share/repost functionality
   - Post timestamps and engagement stats

5. **Stories**
   - Create photo/video stories (24hr expiry)
   - View stories from followed users
   - Story viewer tracking
   - Story reactions

6. **Messaging**
   - Direct messages between users
   - Group conversations
   - Media sharing in chats
   - Message timestamps
   - Online/offline status

7. **Video/Audio Calls**
   - Initiate video calls
   - Initiate audio calls
   - Call notifications
   - Call history

8. **Live Streaming**
   - Start live broadcasts
   - Watch live streams
   - Live reactions
   - Stream comments
   - Viewer count

9. **Groups & Communities**
   - Create groups/communities
   - Join and leave groups
   - Group posts and discussions
   - Group admin controls
   - Member management

10. **Notifications**
    - Real-time push notifications
    - Notification types (likes, comments, follows, messages)
    - Notification settings
    - Mark as read functionality

11. **Monetization (Freemium Model)**
    - Premium feature flags
    - In-app purchase integration points
    - Subscription management
    - Ad placement locations

### Technical Requirements
- **Framework**: Flutter (Dart)
- **Backend**: Firebase (Auth, Firestore, Storage, Cloud Functions)
- **Architecture**: Clean Architecture with BLoC pattern
- **State Management**: flutter_bloc
- **Navigation**: go_router
- **Localization**: Indonesian and English

### Development Workflow
Follow this sequence:

1. **Planning Phase** (Delegate to 'planner' agent)
   - Create SPEC.md with complete technical specification
   - Design Firebase database schema
   - Define all data models
   - Plan feature implementation order

2. **Project Setup** (Delegate to 'coder' agent)
   - Create Flutter project with: `flutter create social_app`
   - Add all dependencies to pubspec.yaml
   - Configure Firebase (firebase.json, google-services.json, GoogleService-Info.plist)
   - Set up Clean Architecture folder structure
   - Configure app theming and routing

3. **Implementation Phase** (Delegate to 'coder' agent)
   Implement features in this order:
   - Core infrastructure (DI, routing, theme)
   - Authentication system
   - User profile system
   - Social graph (follow system)
   - Posts and feed
   - Stories
   - Messaging
   - Video/Audio calls
   - Live streaming
   - Groups/Communities
   - Notifications
   - Monetization infrastructure

4. **Quality Assurance** (Delegate to 'qa' agent)
   - Run flutter analyze
   - Verify project builds: `flutter build apk --debug`
   - Check all features are implemented
   - Validate Firebase configuration
   - Create basic test coverage

5. **Documentation**
   - Create README.md with setup instructions
   - Document API structure
   - Add contribution guidelines

## Output Location
All files should be created in: /workspace/project/output/social_app/

## Success Criteria
✅ Complete Flutter project structure
✅ All features implemented with Firebase backend
✅ Code compiles and builds successfully
✅ Follows Clean Architecture principles
✅ Includes basic test coverage
✅ Bilingual support (Indonesian/English)
✅ Production-ready code quality

Please begin development and delegate tasks to specialized agents as needed.
Report progress as you complete each phase.
"""

    def run_interactive(self):
        """Run the agent in interactive mode."""
        print("=" * 80)
        print("Social Media App Development Agent")
        print("=" * 80)
        print()
        print("This agent can develop complete social media applications")
        print("including posts, stories, chat, video calls, live streaming,")
        print("groups, and monetization features.")
        print()
        print("Type 'exit' or 'quit' to end the session")
        print("=" * 80)
        print()
        
        self.conversation = Conversation(
            agent=self.agent,
            workspace=str(self.workspace),
        )
        
        while True:
            try:
                user_input = input("You: ")
                if user_input.lower() in ['exit', 'quit', 'q']:
                    print("Goodbye!")
                    break
                
                if not user_input.strip():
                    continue
                
                self.conversation.send_message(user_input)
                self.conversation.run()
                
            except KeyboardInterrupt:
                print("\nInterrupted. Goodbye!")
                break
            except Exception as e:
                print(f"Error: {e}")


def main():
    """Main entry point."""
    import argparse
    
    parser = argparse.ArgumentParser(
        description="Social Media App Development Agent - AI for building mobile apps"
    )
    parser.add_argument(
        "requirements",
        nargs="*",
        help="App requirements description"
    )
    parser.add_argument(
        "--interactive", "-i",
        action="store_true",
        help="Run in interactive mode"
    )
    parser.add_argument(
        "--model",
        default="openhands/claude-sonnet-4-5-20250929",
        help="LLM model to use"
    )
    parser.add_argument(
        "--output",
        default="/workspace/project/output",
        help="Output directory for generated app"
    )
    
    args = parser.parse_args()
    
    try:
        # Initialize agent
        agent = SocialMediaDevAgent(model=args.model)
        
        if args.interactive:
            # Interactive mode
            agent.run_interactive()
        elif args.requirements:
            # Single task mode
            requirements = " ".join(args.requirements)
            print(f"Developing social media app with requirements: {requirements}")
            print()
            
            result = agent.develop_app(requirements)
            
            print()
            print("=" * 80)
            print("DEVELOPMENT RESULT")
            print("=" * 80)
            print(f"Status: {result['status']}")
            print(f"Message: {result['message']}")
            print(f"App Location: {result['app_path']}")
            print(f"Timestamp: {result['timestamp']}")
            print()
            print("Next steps:")
            print(f"  cd {result['app_path']}")
            print("  flutter pub get")
            print("  flutter run")
        else:
            parser.print_help()
            
    except ValueError as e:
        print(f"Error: {e}")
        print()
        print("Please set your API key:")
        print("  export LLM_API_KEY='your-api-key'")
        sys.exit(1)
    except Exception as e:
        logger.error(f"Failed: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
