# Valkyrie::Benchmark

A framework to measure the performance of various back end adapters of [Valkyrie](https://github.com/samvera-labs/valkyrie).

# Benchmarking results

See [RESULTS.md](https://github.com/durham-university/valkyrie-benchmark/wiki/Benchmark-results)

# Installation

You will need to install and configure the databases and other back ends. See the config files in ```config/metadata_adapters``` and adjust as needed. You can also disable individual adapters using these files.

Depending on the adapter, you might also need to run database migrations See examples below for how to setup some of the adapters. Exact details will wary depending on your system configuration. **Warning, the repository will get wiped when you run the benchmarks**.

## ActiveRecord Sqlite

Only need to run migrations

```bundle exec bin/benchmark migrate active_record_sqlite```

## ActiveRecord Mysql

Create database and login. In mysql client (```mysql -u root```) run

```sql
create database valkyrie_benchmark_ar_mysql;
grant all privileges on valkyrie_benchmark_ar_mysql.* to 'valkyrie_benchmark'@'localhost' identified by 'valkyrie_benchmark';
```

Then run migrations

```bundle exec bin/benchmark migrate active_record_mysql```

## ActiveRecord Postgres

Create database and login. In psql client (```sudo -u postgres psql```) run

```sql
create user valkyrie_benchmark password 'valkyrie_benchmark';
create database valkyrie_benchmark_ar_postgres owner = valkyrie_benchmark;
```

Then run migrations

```bundle exec bin/benchmark migrate active_record_postgres```

If Ruby complains about authentication failing, you will probably need to enable MD5 authentication in ```/etc/postgresql/x.x/main/pg_hba.conf```. Add this line

```local   all             valkyrie_benchmark                      md5```

Then restart postgres and try migrations again.

## Postgres

This is very similar to the previous adapter. You will just use a different database name and different migrations. It's assumed you have already created the user, otherwise you'll need to run the ```create user``` line above before creating the database. 

Create the database. In psql client (```sudo -u postgres psql```)

```sql
create database valkyrie_benchmark_postgres owner = valkyrie_benchmark;
```

Then run migrations

```bundle exec bin/benchmark migrate postgres```

The first part of migrations creates the 'uuid-ossp' extension which may require root privileges. In this case, do this part manually. Start psql with ```sudo -u postgres psql valkyrie_benchmark_postgres``` and run

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

Then try migrations again the normal way.

## Fedora

Easiest method is to use the ``fcrepo_wrapper``. You only need to run ```bundle exec fcrepo_wrapper``` in a separate console window and leave it running. No migrations need to be run.

## Solr

Similar to Fedora, the easiest method is to use the ``solr_wrapper``. You only need to run ```bundle exec solr_wrapper``` in a separate console window and leave it running. No migrations need to be run.

Note that using the Solr adapter will give a lot of warnings about persisting new resources but it should still work.

## Redis

Just ensure you have Redis installed and running in port 6379, or change the settings in ```config/metadata_adapters/redis.yml```.

Note that Redis adapter does not support alternate identifiers, thus the alternate\_id\_tests will not work.

# Basic usage

To run all enabled tests using all enabled adapters, run

```
bundle exec bin/benchmark start
```

For information about other options run ```bundle exec bin/benchmark``` and ```bundle exec bin/benchmark help start```
