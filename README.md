# Paradise CoreInfrastructure

This repository contains the docker compose project that manages the core components of the ParadiseSS13 infrastructure. This includes:

- Nginx Proxy Manager - Used as webserver ingress for various services and cert renewal
- Valkey - Redis fork used as a message broker

This is a fairly standard docker compose stack, and most generic instructions regarding docker compose should be applicable here.

## Deployment

### Important Note

Some of these projects are internal and will need removing from the stack if you are doing testing. These projects are:

- Nothing yet, but there will be soon(TM)

Simply comment these lines out of the root `docker-compose.yaml` file and you should be able to deploy.

### Deployment Instructions

1. Rename any `.example` files and modify as required
2. Deploy with `docker compose up -d --build`

## Management commands

### Deploying stack

You may specify service names at the end to only start the specified services and their dependencies.

```bash
docker compose up -d --build
```

### Listing containers

```bash
docker compose ps
```

### Restarting a container

*If services is left unspecified, all containers will be restarted.*

```bash
docker compose restart <services...>
```

### Recreating a container

Useful to force docker compose to pick up on changes that it otherwise can't detect. If services is left unspecified, all containers will be recreated.

```bash
docker compose build --no-cache <services...> && docker compose up -d --force-recreate <services...>
```

### Stop a container

*If services is left unspecified, all containers will be stopped.*

```bash
docker compose stop <services...>
```

### Delete a container

This will not delete volumes unless the '-v' switch is added. If services is left unspecified, all containers will be
deleted.

```bash
docker compose down <services...>
```

## License

This project is licensed under AGPL-3. You can find a copy of this license in the file `LICENSE.md`.
