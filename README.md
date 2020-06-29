# Greentap

## Setup
1. Clone repo
2. Install client side dependencies
```
cd greentap/client && npm install && cd ..
```
3. In another tab: install client side dependencies
```
cd greentap/server && npm install && cd ..
```
Keep both tabs open as the client and server run as two separate bash processes

4. Install db schema
```
psql -h localhost -p 5432 -U postgres -f .db_schema_11-26.sql
```

5. Start the client
```
cd client && npm start
```
6. Start the server
```
cd server && npm run server
```
Visit UI at localhost:3000

Make api calls to localhost:3001 (you'll need a session in the form of a Cookie parameter)

## Docker

### Postgres
```
docker build -f ./docker/PostgresDockerfile -t greentap-postgres .
docker run -d -e POSTGRES_DB=postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 greentap-postgres:latest
psql -h localhost -p 5432 -W -U postgres postgres
```

#### Generating a backup sql file
Once you're on the db host, we use the standard `pg_dump` to generate the backup. For some reason, there were issues 
with the default backup format with the `COPY` command. When trying to restore the backup, some rows had mismatched columns and failed insertion.
As a workaround, use `--column-inserts` when generating the backup, which gives you a series of `INSERT`s instead of copy. [PG docs|https://www.postgresql.org/docs/9.6/app-pgdump.html]
``` 
pg_dump -U postgres --column-inserts -d postgres > pg-insert-backup
```