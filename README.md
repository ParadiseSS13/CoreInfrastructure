# Paradise CoreInfrastructure

This repository contains the docker compose project that manages the core components of the ParadiseSS13 infrastructure. This includes:

- ALICE - The discord bot
- Authentik - Authentication and RBAC for backend resources
- CC Exporter - Exporter that powers the [Centcom Ban DB](https://centcom.melonmesa.com/)
- IP2ASN - Internal tool to get the ASN associated with an IP
- Nginx Proxy Manager - Used as webserver ingress for various services and cert renewal
- PostgreSQL - Used to back Authentik (coming soon) and possibly SS14 in the future
- Public API - The public API for round and profiler stats
- Taskdaemon - Java project that orchestrates various backend tasks within Paradise
- Valkey - Redis fork used as a message broker
- YTDLP - Hosted `yt-dlp` API for the ingame "Play Internet Sound" feature

This is a fairly standard docker compose stack, and most generic instructions regarding docker compose should be applicable here.

## Deployment

### Important Note

Some of these projects are internal and will need removing from the stack if you are doing testing. These projects are:

- ALICE

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
