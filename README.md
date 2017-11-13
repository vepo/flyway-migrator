Flyway migrator for docker
===
Automatic migrator for database using docker.

# Setup
Using with `docker-compose`

## Postgresql

```
version: "2"

services:
  test-db:
    image: postgres
    container_name: test-db
    ports:
      - "5432:5432"
    expose:
      - "5432"
    environment:
      - POSTGRES_DB=test
      - POSTGRES_USER=test-user
      - POSTGRES_PASSWORD=test-pw
    volumes:
      - ./env-config/postgres.conf:/etc/postgresql.conf
      - /srv/docker/postgresql:/var/lib/postgresql
    command: postgres -c config_file=/etc/postgresql.conf
    restart: always

  test-migrator:
    image: vepo/flyway-migrator
    depends_on:
      - test-db
    environment:
      - DB_URL=postgresql://test-db/test
      - DB_USER=test-user
      - DB_PASSWORD=test-pw
    volumes:
      - ./migration-sql:/flyway/sql
```

## MySQL

```
version: "2"

services:
  test-db:
    image: mysql
    container_name: test-db
    ports:
      - "3306:3306"
    expose:
      - "3306"
    environment:
      - MYSQL_ROOT_PASSWORD=root
      - MYSQL_DATABASE=test-db
      - MYSQL_USER=log-user
      - MYSQL_PASSWORD=test-pw
    volumes:
      - ./db_data:/var/lib/mysql
    restart: always

  log-migrator:
    container_name: test-db-migrator
    image: vepo/flyway-migrator
    depends_on:
      - test-db
    environment:
      - DB_URL=mysql://test-db/test-db
      - DB_USER=log-user
      - DB_PASSWORD=test-pw
    volumes:
      - ./migration-sql:/flyway/sql
```