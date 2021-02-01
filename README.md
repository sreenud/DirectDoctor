## Installation

##### Prerequisites

The setups steps expect following tools installed on the system.

- rbenv (https://gorails.com/setup/osx/10.15-catalina)
- Ruby [2.7.1](https://gorails.com/setup/osx/10.15-catalina)
- Rails [6.0.3.2](https://gorails.com/setup/osx/10.15-catalina)
- PostgreSQL (https://gorails.com/setup/osx/10.15-catalina)

###### VSCode environment gem dependencies

```ruby
gem install solargraph
gem install htmlbeautifier
```

### Set up Rails app

##### 1. Check out the repository

```bash
git clone https://varmad@bitbucket.org/varmad/doctor.git
```

##### 2. Install gem and package dependencies

Go to project root directory and run following commands

```bash
bundle install
yarn install
```

##### 3. Create database.yml file

Copy the sample database.yml file and edit the database configuration as required.

```bash
cp config/database.yml.sample config/database.yml
```

##### 4. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create or rails db:create
bundle exec rake db:setup or rails db:setup
```

##### 5. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s or rails s
```

And now you can visit the site with the URL http://localhost:3000 or http://lvh.me:3000

```

```
