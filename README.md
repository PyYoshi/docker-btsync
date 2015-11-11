# build & push

```bash
docker build -t pyyoshi/btsync .
docker push pyyoshi/btsync
```

# run

## prepare to generate secret key

```bash
$ docker run --name generate_btsync_seckey pyyoshi/btsync
```

```bash
Starting btsync with secret: <btsync secret key>
```

Copy ``<btsync secret key>``

```bash
$ docker kill generate_btsync_seckey
$ docker rm -v generate_btsync_seckey
$ docker run --name foo_vol pyyoshi/btsync <btsync secret key>
```

# coreos sample service

foo-data.service

```txt
[Unit]
Description=Foo Data Service
Requires=docker.service
After=docker.service

[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker kill %p%i
ExecStartPre=-/usr/bin/docker rm -v %p%i
ExecStartPre=-/usr/bin/docker pull pyyoshi/btsync
ExecStart=/usr/bin/docker run --name %p%i pyyoshi/btsync <REPLACE SECRET KEY>
ExecStop=/usr/bin/docker kill %p%i

[Install]
WantedBy=multi-user.target
```

# thanks

- [masato/btsync](https://github.com/masato/btsync)
- [CoreOSのfleetからfigに移行する - Part2: Data Volume Container](http://masato.github.io/2014/11/26/migrating-fleet-to-fig-data-volume-container/)
