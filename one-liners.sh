# This is a collection of individual and piped commands meant to be run piecemeal for specific tasks

# Prevent users from accidentally running this entire file as a script
exit 0

# List your top 20 most-used commands
history | awk '{ count[$2]++ } END { for (cmd in count) { print count[cmd] " " cmd } }' | sort -rn | head -20