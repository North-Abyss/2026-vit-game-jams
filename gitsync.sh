#!/bin/bash

# A simple script to sync git repository

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting git sync..."

# Check if we're in a git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not a git repository. Please run 'git init' first."
    exit 1
fi

# Pull latest changes (optional, you can remove this if you only want to push)
echo "Pulling latest changes..."
git pull || echo "Pull failed, continuing anyway..."

# Check if there are any changes to commit
if [[ -z $(git status -s) ]]; then
    echo "No changes to commit."
    exit 0
fi

# Add all changes
echo "Adding changes..."
git add .

# Ask for a commit message, default to 'Automated sync update' if empty
read -p "Enter commit message (default: Automated sync update): " commit_message
commit_message=${commit_message:-Automated sync update}

# Commit changes
echo "Committing with message: '$commit_message'"
git commit -m "$commit_message"

# Push changes
echo "Pushing changes..."
git push

echo "Git sync complete!"
