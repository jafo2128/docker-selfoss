# jantman/selfoss

![selfoss](https://i.imgur.com/8hJyBgk.png "selfoss")

Current build: [selfoss-2.18-5339432](https://bintray.com/fossar/selfoss/selfoss-git/2.18-5339432) December 2, 2017

## You probably want [hardware/selfoss](https://github.com/hardware/selfoss)

This repository is forked from [hardware/selfoss](https://github.com/hardware/selfoss).
You probably want to use that project unless you need the changes, which are:

- Lightweight & secure image (no root process)
- Based on Alpine Linux
- Latest Selfoss version (2.17)
- SQLite driver
- With Nginx and PHP7

### Build-time variables

- **VERSION** = selfoss version (default: **2.17**)
- **SHA256_HASH** = SHA256 hash of selfoss archive

### Ports

- 8888

### Environment variables

| Variable | Description | Type | Default value |
| -------- | ----------- | ---- | ------------- |
| **UID** | selfoss user id | *optional* | 991
| **GID** | selfoss group id | *optional* | 991
| **CRON_PERIOD** | Cronjob period for updating feeds | *optional* | 15m

### Docker-compose.yml

```yml
selfoss:
  image: hardware/selfoss
  container_name: selfoss
  volumes:
    - /mnt/docker/selfoss:/selfoss/data
```
