#!/bin/bash

# 1 - Open terminal
# 2 - Create a fresh, bare clone of your repository
#   -- git clone --bare https://github.com/user/repo.git
#   -- cd repo
# 3 - Update OLD_EMAIL, CORRECT_NAME, and CORRECT_EMAIL with desired values
# 4 - Run script

git filter-branch --env-filter '
OLD_EMAIL="travis.gall@gmail.com"
CORRECT_NAME="Travis Gall"
CORRECT_EMAIL="travis.gall@gmail.com"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags

# 5 - Push the corrected history to GitHub
git push --force --tags origin 'refs/heads/*'

# 6 - Clean-up the temporary clone
# cd ..
# rm -rf repo
