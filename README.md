# jantman/selfoss

![selfoss](https://i.imgur.com/8hJyBgk.png "selfoss")

Current build: [selfoss-2.18-77d57d1](https://bintray.com/fossar/selfoss/selfoss-git/2.18-77d57d1) January 9, 2018.

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
| **UID** | nginx/s6 user id | *optional* | 0
| **GID** | nginx/s6 group id | *optional* | 0
| **FPM_USER** | selfoss/php fpm user NAME | *optional* | nobody
| **CRON_PERIOD** | Cronjob period for updating feeds | *optional* | 15m

### Docker-compose.yml

```yml
selfoss:
  image: hardware/selfoss
  container_name: selfoss
  volumes:
    - /mnt/docker/selfoss:/selfoss/data
```

## You probably want [hardware/selfoss](https://github.com/hardware/selfoss)

This repository is forked from [hardware/selfoss](https://github.com/hardware/selfoss).
You probably want to use that project unless you need the changes, which are:

* A [nightly build](https://bintray.com/fossar/selfoss/selfoss-git) that fixes autoloading of custom spouts ([selfoss #959](https://github.com/SSilence/selfoss/pull/959))
* UID/GID change to 0/0 (root/root) for services and nginx, and /var/log/nginx symlinks to /dev/stdout and /dev/stderr, to get nginx access logs writing to STDOUT and error logs writing to STDERR.
* Run php-fpm and selfoss itself as different user (nobody).
* php-fpm socket ownership fix for the above.
* php-fpm error logs to STDERR.
