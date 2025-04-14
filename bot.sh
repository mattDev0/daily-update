#!/bin/bash

cd "$(dirname "$0")"

# --- Programming Quotes ---
PROGRAMMING_QUOTES=(
  "First, solve the problem. Then, write the code. – John Johnson"
  "Experience is the name everyone gives to their mistakes. – Oscar Wilde"
  "Java is to JavaScript what car is to Carpet. – Chris Heilmann"
  "Code never lies, comments sometimes do. – Ron Jeffries"
  "Simplicity is the soul of efficiency. – Austin Freeman"
)

# --- Mood List ---
MOODS=("Happy" "Focused" "Lazy" "Annoyed" "Inspired" "Sleepy" "Cracked")

# --- Choose a random action ---
ACTION=$((RANDOM % 4))

case $ACTION in
  0)
    # Kanye quote
    QUOTE=$(curl -s https://api.kanye.rest/ | jq -r '.quote')
    echo "Kanye: $QUOTE - $(date)" >> updates.txt
    COMMIT_MSG="Kanye says: $QUOTE"
    ;;
  1)
    # Programming quote
    QUOTE=${PROGRAMMING_QUOTES[$RANDOM % ${#PROGRAMMING_QUOTES[@]}]}
    echo "$QUOTE - $(date)" >> updates.txt
    COMMIT_MSG="$QUOTE"
    ;;
  2)
    # Mood
    MOOD=${MOODS[$RANDOM % ${#MOODS[@]}]}
    echo "Mood today: $MOOD - $(date)" >> mood.txt
    COMMIT_MSG="Feeling $MOOD today"
    ;;
  3)
    # System info
    {
      echo "------ System Update: $(date) ------"
      echo "Uptime: $(uptime)"
      echo "Memory: $(free -h | grep Mem)"
      echo "Disk: $(df -h / | tail -1)"
      echo ""
    } >> syslog.txt
    COMMIT_MSG="System update on $(date +'%Y-%m-%d %H:%M')"
    ;;
esac

# Git commit and push
git add .
git commit -m "$COMMIT_MSG"
git push
