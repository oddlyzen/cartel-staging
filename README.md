# PAN
add newer code

[![Circle CI](https://circleci.com/gh/tinkerbox/pan.svg?style=svg&circle-token=6e54f3ceb9c3a2d4707fe06ba43362527370fe6f)](https://circleci.com/gh/tinkerbox/pan)
[![Code Climate](https://codeclimate.com/repos/5636f5666956801ac0004e0d/badges/b82a5b2d4f73799bd70d/gpa.svg)](https://codeclimate.com/repos/5636f5666956801ac0004e0d/feed)
[![Test Coverage](https://codeclimate.com/repos/5636f5666956801ac0004e0d/badges/b82a5b2d4f73799bd70d/coverage.svg)](https://codeclimate.com/repos/5636f5666956801ac0004e0d/coverage)


## Setup
```
git clone https://github.com/tinkerbox/pan.git
cd pan
bundle install
```

asdasdasd

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

## Branch Policy

- `master` is the active development branch

Local development branch naming:

- `feature/<branch_name>` for subtantial new feature or function
- `enhance/<branch_name>` for minor feature or function enhancement
- `bugfix/<branch_name>` for bug fixes

After done with local development, push it:
```git push -u origin <local_branch>```

# Tasks
- basecamp - PAN
- get permission to https://docs.google.com/spreadsheets/d/1mSu-ORsC1HjXqFxE39a4jmxdrFbAF6a4n09KhK0iD5E/edit#gid=0
