# PostgreSQL Setup in Development Container

PostgreSQL 16 is installed in the development container via `apt-get` and
started with the default cluster tooling that ships with the package. The full
sequence of commands that were executed is recorded below:

```bash
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib
sudo -u postgres pg_ctlcluster 16 main start
sudo -u postgres createuser -s root
sudo -u postgres psql -c "SELECT version();"
bundle exec rails db:setup
```

Running `bundle exec rails db:setup` now succeeds and provisions the
`todos_development`, `todos_development_cache`, and `todos_test` databases using
the newly created `root` role.
