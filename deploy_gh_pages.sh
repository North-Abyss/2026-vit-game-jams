#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🚀 Deploying Releases/HTML to the gh-pages branch..."

# Check if the HTML directory exists
if [ ! -d "Releases/HTML" ]; then
    echo "❌ Error: Releases/HTML directory does not exist. Please export your game from Godot first!"
    exit 1
fi

cd "Releases/HTML"

# --- Godot 4 Web Export Fix ---
# Godot 4 requires Cross-Origin-Isolation (SharedArrayBuffer) which GitHub Pages does not support by default.
# We download and inject a Service Worker hack to force these headers so your game actually loads!
if [ ! -f "coi-serviceworker.js" ]; then
    echo "📦 Downloading coi-serviceworker.js (Required for Godot 4 HTML5)..."
    wget -q https://raw.githubusercontent.com/gzuidhof/coi-serviceworker/master/coi-serviceworker.js
fi

if ! grep -q "coi-serviceworker.js" REVORA.html; then
    echo "🔧 Injecting coi-serviceworker into REVORA.html..."
    sed -i 's|</head>|<script src="coi-serviceworker.js"></script></head>|g' REVORA.html
fi
# ------------------------------

# Create a brand new isolated Git repository just for the HTML files
echo "⚙️ Setting up temporary git repository..."
rm -rf .git || true
git init
git checkout -b gh-pages
git add .
git commit -m "🚀 Automated Web Deployment"

# Get the GitHub URL from the main project folder
REMOTE_URL=$(cd ../.. && git config --get remote.origin.url)
if [ -z "$REMOTE_URL" ]; then
    echo "❌ Error: Could not find a GitHub remote named 'origin' in your main repository!"
    exit 1
fi

echo "📤 Force-pushing HTML build to GitHub ($REMOTE_URL) on branch: gh-pages..."
git push -f "$REMOTE_URL" gh-pages

# Clean up the temporary git repo
rm -rf .git

echo "✅ Deployment complete!"
echo "⚠️  CRITICAL: Make sure you go to your GitHub Repository -> Settings -> Pages -> Source -> select 'gh-pages' branch!"
