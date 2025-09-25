# Home Server Service Stack

One **compose** file, many **services**, many **profiles**.

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

Start services per profile

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

Check all running services

```shell
make ps
```
