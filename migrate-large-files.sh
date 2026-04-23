#!/bin/bash
# migrate-large-files.sh
# Automatically detect files >50MB and move them into Git LFS

# Step 1: Install Git LFS if not already
git lfs install

# Step 2: Find large files (>50MB)
echo "Scanning repo for files larger than 50MB..."
find . -type f -size +50M | while read file; do
  echo "Tracking $file with Git LFS..."
  git lfs track "$file"
done

# Step 3: Add .gitattributes update
git add .gitattributes
git commit -m "Track large files with Git LFS"

# Step 4: Rewrite history to migrate existing large files
echo "Migrating existing large files into LFS..."
git lfs migrate import --include="*"

# Step 5: Push changes (force to overwrite remote history)
echo "Pushing migrated repo to remote..."
git push origin Resources --force
