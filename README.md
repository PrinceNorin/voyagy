# Environment setup

- Ruby 2.7.1 or newer is required
- Docker and Docker compose installed if you want to run in a docker container

# Start development server

### Manual setup

First install dependencies
```SH
$ bundle install
```

Next create and migrate database
```SH
$ rails db:create
$ rails db:migrate
```

And start rails application
```SH
$ rails s
```

### Docker setup

First build docker image
```SH
$ docker build -t voyagy:0.0.1 .
```

Start application server
```SH
$ docker-compose up
```

Create and migrate database
```SH
$ docker-compose exec voyagy rails db:create
$ docker-compose exec voyagy rails db:migrate
```

To be able to debug using `binding.pry`, first start docker compose in background with
```SH
$ docker-compose up -d
```

then attach to the running container with
```SH
$ docker ps # to get container's id
$ docker attach f6e5f3b328e6
```
