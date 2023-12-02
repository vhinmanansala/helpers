#!/bin/bash

echo "Select an AWS profile:"

# Get a list of AWS profiles
profiles=($(aws configure list-profiles --output text))

# Display the list of profiles
for ((i=1; i<=${#profiles[@]}; i++)); do
    echo "$i. ${profiles[i-1]}"
done

# Prompt the user to enter a number
read -p "Enter the number corresponding to the AWS profile: " choice

# Validate user input
if [[ ! $choice =~ ^[0-9]+$ ]]; then
    echo "Invalid input. Please enter a valid number."
    exit 1
fi

# Check if the choice is within the valid range
if (( choice < 1 || choice > ${#profiles[@]} )); then
    echo "Invalid choice. Please enter a number within the valid range."
    exit 1
fi

# Get the selected AWS profile
selected_profile="${profiles[choice-1]}"

echo "Logging in with: $selected_profile"

aws sso login --profile $selected_profile
