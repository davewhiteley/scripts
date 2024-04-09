# This is a collection of git-related commands and snippets

# Prevent users from accidentally running this entire file as a script
exit 0

# Undo the act of committing
# See also: https://stackoverflow.com/questions/2845731/how-to-uncommit-my-last-commit-in-git
git reset --soft HEAD^

# Fast-forward an existing branch
TARGET_SHA='<The SHA to which you are moving the branch>'
CURRENT_SHA='<The SHA that the branch is currently on>'
BRANCH_NAME='<The name of the branch to be moved>'
git rebase --onto "${TARGET_SHA} ${CURRENT_SHA} ${BRANCH_NAME}"
