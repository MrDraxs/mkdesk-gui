#!/bin/bash

# Set the GTK_THEME environment variable to the desired dark mode theme
export GTK_THEME="Adwaita-dark"

# Prompt the user for the name of the application
name=$(zenity --entry --title="Application name" --text="What would you like to name your application.desktop?")

# If the user canceled the prompt, exit the script
if [[ $? -ne 0 ]]; then
  exit 1
fi

# Prompt the user for the application to launch
app=$(zenity --entry --title="Application to launch" --text="What would you like to launch?")

# If the user canceled the prompt, exit the script
if [[ $? -ne 0 ]]; then
  exit 1
fi

# Display the desktop entry information to the user
zenity --info --title="Desktop entry" --text="[Desktop Entry]\nType=Application\nName=$name\nExec=$app"

# Prompt the user to save the desktop entry
if zenity --question --title="Save Desktop Entry" --text="Do you like to save $name.desktop?"; then
  # If the user canceled the prompt, exit the script
  if [[ $? -ne 0 ]]; then
    exit 1
  fi

	if [[ ! -d $HOME/.local/share/applications ]]; then
		mkdir $HOME/.local/share/applications
		zenity --info --title="Desktop Entry Saved" --text="$HOME/.local/share/applications folder was created"
	fi
	echo "[Desktop Entry]
	Type=Application
	Name=$name
	Exec=$app" > "$HOME/.local/share/applications/$name.desktop"
	zenity --info --title="Desktop Entry Saved" --text="$name.desktop saved in $HOME/.local/share/applications"
else
  # If the user canceled the prompt, exit the script
  if [[ $? -ne 0 ]]; then
    exit 1
  fi

	zenity --error --title="Operation Canceled" --text="[Operation Canceled]"
fi
