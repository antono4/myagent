"""
Social Media Development Agent - API Server
Flask backend for the web interface
"""

import os
import uuid
import json
from datetime import datetime
from pathlib import Path
from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS

app = Flask(__name__, static_folder='../web', static_url_path='')
CORS(app)

# Store job status
jobs = {}

@app.route('/')
def index():
    """Serve the web interface"""
    return send_from_directory('../web', 'index.html')

@app.route('/api/status')
def status():
    """Check API status"""
    return jsonify({
        'status': 'online',
        'message': 'Social Media Development Agent API',
        'version': '1.0.0',
        'timestamp': datetime.now().isoformat()
    })

@app.route('/api/create-job', methods=['POST'])
def create_job():
    """Create a new development job"""
    data = request.get_json()
    requirements = data.get('requirements', '')
    
    if not requirements:
        return jsonify({'error': 'Requirements are required'}), 400
    
    job_id = str(uuid.uuid4())[:8]
    job_dir = Path('/workspace/project/output/jobs') / job_id
    job_dir.mkdir(parents=True, exist_ok=True)
    
    # Initialize job
    jobs[job_id] = {
        'id': job_id,
        'requirements': requirements,
        'status': 'queued',
        'progress': 0,
        'logs': ['Job created. Waiting for processing...'],
        'created_at': datetime.now().isoformat(),
        'output_dir': str(job_dir)
    }
    
    return jsonify({
        'job_id': job_id,
        'status': 'queued',
        'message': 'Job created successfully'
    })

@app.route('/api/job/<job_id>')
def get_job(job_id):
    """Get job status"""
    if job_id not in jobs:
        return jsonify({'error': 'Job not found'}), 404
    
    return jsonify(jobs[job_id])

@app.route('/api/job/<job_id>/logs')
def get_job_logs(job_id):
    """Get job logs"""
    if job_id not in jobs:
        return jsonify({'error': 'Job not found'}), 404
    
    return jsonify({'logs': jobs[job_id]['logs']})

@app.route('/api/features')
def get_features():
    """Get available features"""
    return jsonify({
        'features': [
            {
                'id': 'auth',
                'name': 'Authentication',
                'description': 'Email/password, Google Sign-In, password reset',
                'icon': '🔐'
            },
            {
                'id': 'profiles',
                'name': 'User Profiles',
                'description': 'Avatar, bio, stats, privacy settings',
                'icon': '👤'
            },
            {
                'id': 'posts',
                'name': 'Posts & Feed',
                'description': 'Text, images, videos, likes, comments, shares',
                'icon': '📝'
            },
            {
                'id': 'stories',
                'name': 'Stories',
                'description': '24hr ephemeral content with photos/videos',
                'icon': '📸'
            },
            {
                'id': 'chat',
                'name': 'Messaging',
                'description': 'Direct messages and group chats',
                'icon': '💬'
            },
            {
                'id': 'calls',
                'name': 'Video/Audio Calls',
                'description': 'Real-time video and audio calling',
                'icon': '📹'
            },
            {
                'id': 'live',
                'name': 'Live Streaming',
                'description': 'Broadcast and watch live streams',
                'icon': '🎥'
            },
            {
                'id': 'groups',
                'name': 'Groups',
                'description': 'Communities with admin controls',
                'icon': '👥'
            },
            {
                'id': 'notifications',
                'name': 'Notifications',
                'description': 'Real-time push notifications',
                'icon': '🔔'
            },
            {
                'id': 'monetization',
                'name': 'Monetization',
                'description': 'Freemium model, subscriptions, ads',
                'icon': '💰'
            }
        ]
    })

@app.route('/api/templates')
def get_templates():
    """Get app templates"""
    return jsonify({
        'templates': [
            {
                'id': 'basic',
                'name': 'Basic Social App',
                'description': 'Profiles, posts, likes, comments, feed',
                'features': ['auth', 'profiles', 'posts', 'notifications']
            },
            {
                'id': 'community',
                'name': 'Community Platform',
                'description': 'Social + Groups + Messaging',
                'features': ['auth', 'profiles', 'posts', 'groups', 'chat', 'notifications']
            },
            {
                'id': 'influencer',
                'name': 'Influencer Platform',
                'description': 'Social + Stories + Live Streaming',
                'features': ['auth', 'profiles', 'posts', 'stories', 'live', 'notifications']
            },
            {
                'id': 'full',
                'name': 'Complete Social Platform',
                'description': 'All features combined',
                'features': ['auth', 'profiles', 'posts', 'stories', 'chat', 'calls', 'live', 'groups', 'notifications', 'monetization']
            }
        ]
    })

@app.route('/api/download/<job_id>')
def download_project(job_id):
    """Download generated project"""
    if job_id not in jobs:
        return jsonify({'error': 'Job not found'}), 404
    
    job = jobs[job_id]
    if job['status'] != 'completed':
        return jsonify({'error': 'Job not completed'}), 400
    
    # Create zip of the project
    import zipfile
    from io import BytesIO
    
    output_dir = Path(job['output_dir']) / 'social_app'
    if not output_dir.exists():
        return jsonify({'error': 'Project not found'}), 404
    
    memory_file = BytesIO()
    with zipfile.ZipFile(memory_file, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(output_dir):
            for file in files:
                file_path = Path(root) / file
                arcname = file_path.relative_to(output_dir)
                zipf.write(file_path, arcname)
    
    memory_file.seek(0)
    
    return send_file(
        memory_file,
        mimetype='application/zip',
        as_attachment=True,
        download_name=f'social_app_{job_id}.zip'
    )

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port, debug=True)
