# tiddlywiki-docker

A minimal Docker image for running [TiddlyWiki5](https://github.com/TiddlyWiki/TiddlyWiki5)
as a self-hosted server. The container runs Node on Alpine as a non-root
user, auto-initializes a new wiki on first run, and persists data to a
volume.

## Features

- Based on `node:lts-alpine`
- Runs as a non-root `tiddlywiki` user (UID/GID overridable at build time)
- `WIKI_NAME` environment variable controls the wiki folder under `/data`
- First-run auto-init via `tiddlywiki <name> --init server`
- Node V8 old-space heap capped at 128 MB by default

## Build

Default build:

```sh
docker build -t tiddlywiki-docker .
```

Pin a specific TiddlyWiki version:

```sh
docker build --build-arg TIDDLYWIKI_VERSION=5.3.5 -t tiddlywiki-docker .
```

Match a specific host UID/GID (useful when bind-mounting a host directory):

```sh
docker build \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g) \
  -t tiddlywiki-docker .
```

## Run

With a named volume:

```sh
docker run -d --name tiddlywiki \
  -p 8080:8080 \
  -e WIKI_NAME=mywiki \
  -v tiddlywiki-data:/data \
  tiddlywiki-docker
```

Or with `docker compose`:

```sh
WIKI_NAME=mywiki docker compose up -d --build
```

Then open <http://localhost:8080>.

## Configuration

| Env var        | Default                    | Purpose                                |
| -------------- | -------------------------- | -------------------------------------- |
| `WIKI_NAME`    | `wiki`                     | Wiki folder name under `/data`         |
| `PORT`         | `8080`                     | Listen port inside the container       |
| `HOST`         | `0.0.0.0`                  | Listen address inside the container    |
| `NODE_OPTIONS` | `--max-old-space-size=128` | V8 heap cap; raise for larger wikis    |

| Build arg            | Default  | Purpose                                |
| -------------------- | -------- | -------------------------------------- |
| `TIDDLYWIKI_VERSION` | `latest` | npm version of `tiddlywiki` to install |
| `UID`                | `1000`   | UID of the in-container user           |
| `GID`                | `1000`   | GID of the in-container user           |

## License

Apache 2.0 — see [LICENSE](LICENSE).
