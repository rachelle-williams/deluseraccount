#!/bin/bash

# Script run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Is a username is provided
if [ -z "$1" ]; then
    echo "Error: $0 No username was provided"

    exit 1
fi

USERNAME=$1

# Delete a user including their home directory
delete_user() {
  local USERNAME=$1

  if id "$USERNAME" &>/dev/null; then
    echo "Deleting user: $USERNAME"
    if sudo userdel -r "$USERNAME"; then
      echo "The user $USERNAME and their home directory were successfully deleted."
    else
      echo "Failed to delete the user $USERNAME. Please check for errors."
    fi
  else
    echo "Error: The user $USERNAME does not exist."
  fi
}

# Main script
if [ "$#" -eq 0 ]; then
  echo "Usage: $0 username1 [username2 ...]"
  exit 1
fi

for USERNAME in "$@"; do
  delete_user "$USERNAME"
done
