# Config for the Puma web server used in production on Heroku
# https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server

# Puma forks multiple OS processes within each dyno to allow a Rails app to support multiple concurrent requests.
# With a typical Rails memory footprint, you can expect to run 2-4 Puma worker processes on a free dyno
workers Integer(ENV['WEB_CONCURRENCY'] || 2)
# Each Puma worker will be able to spawn up to the maximum number of threads you specify.
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
# Puma allows you to configure your thread pool with a min and max setting, controlling the number of threads each Puma instance uses.
# We recommend setting min to equal max.
threads threads_count, threads_count

# Manage the external connections of each individual worker using the on_worker_boot calls
preload_app!

# This should point at your applications config.ru, which is automatically generated by Rails when you create a new project.
rackup      DefaultRackup
#  Heroku will set ENV['PORT'] when the web process boots up. Locally, default this to 3000 to match the normal Rails default.
port        ENV['PORT']     || 3000
# On Heroku ENV['RACK_ENV'] will be set to 'production' by default.
environment ENV['RACK_ENV'] || 'development'

# This block is run after a worker is spawned, but before it begins to accept requests.
on_worker_boot do
  # If you are using Rails 4.1+ you can use the database.yml to set your connection pool size
  ActiveRecord::Base.establish_connection
end
