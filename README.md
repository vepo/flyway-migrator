Flyway migrator for docker
===

Using with `docker-compose`

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