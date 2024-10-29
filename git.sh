# This is a collection of git-related commands and snippets

# Prevent users from accidentally running this entire file as a script
exit 0

########## GIT TERMINAL COMMANDS ##########

# Undo the act of committing
# See also: https://stackoverflow.com/questions/2845731/how-to-uncommit-my-last-commit-in-git
git reset --soft HEAD^

# Fast-forward an existing branch
TARGET_SHA='<The SHA to which you are moving the branch>'
CURRENT_SHA='<The SHA that the branch is currently on>'
BRANCH_NAME='<The name of the branch to be moved>'
git rebase --onto "${TARGET_SHA} ${CURRENT_SHA} ${BRANCH_NAME}"

########## BITBUCKET CLOUD COMMANDS ##########

# Hack the build status of a commit in Bitbucket Cloud.
# This is useful when a failed or in progress build is holding up a PR.
# You need a Bitbucket Access Token with permissions to the repo, project, or workspace.
# Go to Bitbucket > Workspace Settings > Access Tokens. Create a new one if necessary.
ACCESS_TOKEN='<An access token with appropriate permissions; usually around 200 chars long>'
BB_WORKSPACE='<The Bitbucket Cloud workspace>'
BB_REPO_SLUG='<The repository slug - usually the name of the repo>'
COMMIT_SHA='<The full git commit SHA>'
BB_API_STATUSES_URL="https://api.bitbucket.org/2.0/repositories/${BB_WORKSPACE}/${BB_REPO_SLUG}/commit/${COMMIT_SHA}/statuses"
curl \
  -X GET \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H 'Accept: application/json' \
  --url $BB_API_STATUSES_URL \
  | jq '.values[] | select((.state=="INPROGRESS") or (.state=="FAILED"))' \
  > bb_api_response.json
BUILD_KEY=$(cat bb_api_response.json | jq '.key' | tr -d \")
BUILD_NAME=$(cat bb_api_response.json | jq '.name' | tr -d \")
BUILD_URL=$(cat bb_api_response.json | jq '.url' | tr -d \")
curl \
  -X POST \
  -H "Authorization: Bearer ${ACCESS_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "{
    \"state\": \"SUCCESSFUL\",
    \"key\": \"${BUILD_KEY}\",
    \"name\": \"${BUILD_NAME}\",
    \"url\": \"${BUILD_URL}\",
    \"type\": \"build\",
    \"description\": \"Build hacked successfully\"
  }" \
  "https://api.bitbucket.org/2.0/repositories/${BB_WORKSPACE}/${BB_REPO_SLUG}/commit/${COMMIT_SHA}/statuses/build"
