#!/bin/bash
CHECKLIST_FILE=~/balkunibuntu_progress.txt

FEATURES=(
  "Install Educational Tools"
  "Apply Security Features"
  "Configure Internet Restrictions"
  "Apply Branding & Visuals"
  "User Account Management"
  "Add Scripts & Automation Tools"
  "Enable Maintenance & Auto-updates"
  "Optional Extras"
  "Prepare Deployment Tools"
)

# Ensure checklist file exists
touch "$CHECKLIST_FILE"

# Check if user wants to just view completed items
if [[ "$1" == "--view" ]]; then
  echo "✅ Completed BalkUniBuntu Features:"
  echo "----------------------------------"
  cat "$CHECKLIST_FILE"
  echo ""
  exit 0
fi

# Display checklist with [✔] for done, [ ] for pending
echo "🧠 BalkUniBuntu Progress Tracker"
echo "-------------------------------"

for i in "${!FEATURES[@]}"; do
    if grep -Fxq "${FEATURES[$i]}" "$CHECKLIST_FILE"; then
        status="[✔]"
    else
        status="[ ]"
    fi
    echo "$status $((i+1)). ${FEATURES[$i]}"
done

echo ""
read -p "Enter number to mark as done (or 0 to cancel): " num

if [[ "$num" =~ ^[1-9]$ && "$num" -le "${#FEATURES[@]}" ]]; then
    selected="${FEATURES[$((num-1))]}"
    if grep -Fxq "$selected" "$CHECKLIST_FILE"; then
        echo "⚠️ Already marked as done."
    else
        echo "$selected" >> "$CHECKLIST_FILE"
        echo "✔ Marked as done!"
    fi
elif [[ "$num" == "0" ]]; then
    echo "Cancelled."
else
    echo "❌ Invalid choice."
fi
