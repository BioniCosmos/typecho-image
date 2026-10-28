# Typecho Image

Run Typecho in a container with the power of FrankenPHP.

```shellsession
$ podman run ghcr.io/bionicosmos/typecho:latest
```

## Volumes

For persistence, The following locations should be mounted outside the container.

### Typecho

- `/app/public/config.inc.php`: the configuration file
- `/app/public/usr`: the data directory (database, themes, plugins, uploads, etc.)

### FrankenPHP (Caddy)

- `/config`: the configuration directory
- `/data`: the data directory

## Example

```shellsession
$ podman run \
  --name typecho \
  -dtp 8080:80 \
  -v ./typecho/config.inc.php:/app/public/config.inc.php \
  -v ./typecho/usr:/app/public/usr \
  -v caddy-data:/data \
  -v caddy-config:/config \
  ghcr.io/bionicosmos/typecho:2610
```

> [!NOTE]
> 1. When initializing with the web installer, create `config.inc.php` before mounting, or an empty directory with the same name will be created, resulting in an error.
> 2. For safety reasons, it is recommended to restart the container after initialization. Then the entry script will delete `install.php` and the default `usr` automatically.
