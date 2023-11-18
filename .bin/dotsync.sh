#!/bin/bash

# Color variables
GREEN='\033[1;32m'
BLUE='\033[1;34m'
RED='\033[1;30m'
NC='\033[0m'

# Set the path to your dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"

# Set the path to the script directory
SCRIPT_DIR="$DOTFILES_DIR/.bin"

# Navigate to the dotfiles directory
cd "$DOTFILES_DIR" || exit

# Stow all directories
echo -e "${BLUE}Stowing dotfiles...${NC}"
stow -d "$DOTFILES_DIR" .
# stow --verbose --target="$DOTFILES_DIR" *

# Check if there are changes to commit
git diff --quiet --exit-code
if [ $? -ne 0 ]; then
    # Add and commit changes to Git
    echo -e "${BLUE}Committing changes...${NC}"
    git add -A
    git commit -m "Daily update: $(date +'%Y-%m-%d')"
else
    echo -e "${GREEN}No changes to commit.${NC}"
fi

# Pull changes from Git
echo -e "${BLUE}Pulling changes from Git...${NC}"
git pull origin main

# Push changes to Git
echo -e "${BLUE}Pushing changes to Git...${NC}"
git push origin main

echo -e "${GREEN}Daily update completed.${NC}"
