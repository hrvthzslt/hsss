# Home Server Service Stack

One **compose** file, many **services**, many **profiles**.

All **services** are defined in one place, and the Makefile provides targets to run them modularly. All volumes are stored under a single directory: `/docker/volumes/`, for easy management on the host.

## Dependencies

- Docker compose
- Make

## Services

| Service      | Profiles             |
| ------------ | -------------------- |
| Jellyfin     | `jellyfin,media`     |
| Transmission | `transmission,media` |

## Make targets

Start all services

```shell
make start
```

Start services by profile

```shell
make start profile=media
```

Stop all services

```shell
make stop
```

Tail all logs

```shell
make log
```

Check running services

```shell
make ps
```
