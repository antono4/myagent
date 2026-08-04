# 🚀 Deployment Guide

## GitHub Pages Deployment

### Option 1: Static Demo (Current)

The web interface at `https://antono4.github.io/myagent` is a **demo interface** that shows how the agent works.

To enable GitHub Pages:
1. Go to Settings → Pages
2. Source: Deploy from a branch
3. Branch: main, folder: /web
4. Save

### Option 2: Full-Featured API (Recommended)

For actual agent execution, deploy the API to a free backend service:

#### Deploy to Render (Free Tier)

1. **Create Render Account**: https://render.com

2. **Create Web Service**:
   - Connect your GitHub repo
   - Settings:
     - Root Directory: `api`
     - Build Command: `pip install flask flask-cors`
     - Start Command: `cd api && python app.py`

3. **Get API URL**: e.g., `https://your-app.onrender.com`

4. **Update Web Interface**:
   Edit `web/index.html` and change the API base URL:
   ```javascript
   const API_BASE = 'https://your-app.onrender.com';
   ```

5. **Deploy to GitHub Pages**:
   - Settings → Pages → Source: main branch, /web folder

---

## Quick Deploy Buttons

### Render (Backend)
[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

### Vercel (Alternative)
```bash
npm i -g vercel
vercel --prod
```

---

## Local Development

```bash
# Terminal 1: API Server
cd api
pip install flask flask-cors
python app.py

# Terminal 2: GitHub Pages
cd web
python -m http.server 8000
```

Visit: http://localhost:8000

---

## Environment Variables

For production, set:
- `LLM_API_KEY`: Your LLM API key
- `PORT`: Server port (default: 5000)
