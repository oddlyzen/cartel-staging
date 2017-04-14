# PAN

[![Circle CI](https://circleci.com/gh/tinkerbox/pan.svg?style=svg&circle-token=6e54f3ceb9c3a2d4707fe06ba43362527370fe6f)](https://circleci.com/gh/tinkerbox/pan)
[![Code Climate](https://codeclimate.com/repos/5636f5666956801ac0004e0d/badges/b82a5b2d4f73799bd70d/gpa.svg)](https://codeclimate.com/repos/5636f5666956801ac0004e0d/feed)
[![Test Coverage](https://codeclimate.com/repos/5636f5666956801ac0004e0d/badges/b82a5b2d4f73799bd70d/coverage.svg)](https://codeclimate.com/repos/5636f5666956801ac0004e0d/coverage)

TESTING
## Setup
```
git clone https://github.com/tinkerbox/pan.git
cd pan
bundle install
```

## Setup Environment Variable
```
cp .env.sample .env
# Update the .env accordingly
```

## Setup Database
```
rake db:setup
```

## Start Server
```
rails s -b 0.0.0.0
# Facebook oauth callback is set to http://0.0.0.0:3000/
```

## Testing

Run these regularly
```
rake rspec
rubocop --auto-correct
rake slim_lint
```

## development
1 - Every new feature or fix should be in a branch
2 - After creating a branch on SourceTree, and commiting fixes, you should push it to bitbucket.
3 - Open that branch on bitbucket, and if you are happy press Merge
4 - go back to master branch on your local machine, git pull the latest changes (the merged branch)
5 - git push heroku master, to deploy the master branch to heroku.
6 - You are done



## Deploy to Heroku
Run on master branch `rake production deploy`
If it gives permission denied error try  `git push heroku master`

## Branch Policy

- `master` is the active development branch

Local development branch naming:

- `feature/<branch_name>` for subtantial new feature or function
- `enhance/<branch_name>` for minor feature or function enhancement
- `bugfix/<branch_name>` for bug fixes

After done with local development, push it:
```git push -u origin <local_branch>```

## Tasks for April
  1 - Create a new migration that Adds Location to Institution model.
  2 - create a list in csv, with uni name and location.
  3 - Improve the seeds file with locations and institution names, so that uses.




## Tasks
- basecamp - PAN
- get permission to https://docs.google.com/spreadsheets/d/1mSu-ORsC1HjXqFxE39a4jmxdrFbAF6a4n09KhK0iD5E/edit#gid=0
