# Docker-Unison

An extension of https://github.com/leighmcculloch/docker-unison to support mounting into a docker host.

## Usage:

### Install Unison Locally

Unison requires the version of the client (running on the host) and server (running in the container, currently at `2.48.3`) to match.

* On Mac OSX: `brew install unison`
* Otherwise: [download and compile](https://www.cis.upenn.edu/~bcpierce/unison/)

### Install fswatch Locally

* On Mac OSX: `brew install fswatch`
* Otherwise: [download and compile](http://emcrisostomo.github.io/fswatch/)

### Install `coreos-sync` Utility

```bash
curl -L https://gist.githubusercontent.com/cbankester/0ca3d103a1f5e49b8d37/raw/a2af97b0269c0d3110f78e39a1b6e7446ccbffae/coreos-sync.sh > /usr/local/bin/coreos-sync
chmod +x /usr/local/bin/coreos-sync
```

### Docker

First, you can launch a volume container exposing a volume with Unison.

```bash
docker run -d -p 5000:5000 immense/unison
```

You can then sync a local folder to `/code` in the container with with the `coreos-sync` utility:

```bash
coreos-sync ./some-dir some-dir
# this will create the folder /code/some-dir on the docker host
```

Now you can launch another container with /code/some-dir mounted as a volume:

```bash
$ docker run -it -v /code/some-dir:/whatever/you/want /bin/sh
```

### Docker Compose

If you are using the `immense/node-baseimage` container, you can use the `volumes` directive in development:

```yaml
web:
  ...
  volumes:
    - /code/some-dir:/webapp/some-dir
```

You can then keep the local dir `some-dir` in sync with the unison container (and by extension, the docker host) with:

```bash
coreos-sync ./some-dir some-dir -w
```

Your web application container will now receive all file changes from your local copy of the application source code.

## License
This docker image is licensed under GPLv3 because Unison is licensed under GPLv3 and is included in the image. See LICENSE.
