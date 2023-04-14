# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:


- Ruby version

```
asdf plugin-update ruby
asdf install ruby 3.2.1
```

- System dependencies

# Redis
```
docker run -d --name local_redis -p 6379:6379 redis:latest
```

# Postgres
```
brew install postgresql@14
# Run in background as a service
brew services restart postgresql@14
OR
# Start manually when required
/usr/local/opt/postgresql@14/bin/postgres -D /usr/local/var/postgresql@14
```

- Configuration

- Database initialization/creation
```
createdb
psql
=#
create database actioncable_poc_development;
grant all privileges on database "actioncable_poc_development" to poc;
create database actioncable_poc_test;
grant all privileges on database "actioncable_poc_test to poc;

After the creation:
rails db:migrate
rails db:seed 
(or from rails console: 
a1 = Author.create(name: 'Cervantes')
a2 = Author.create(name: 'Unamuno')
)
```

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions
```
bundle install
bundle exec rails server
bundle exec karafka server
```
