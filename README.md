# Claude in Docker

## Run

This will run `claude` executable using credentials and settings in `~/.claude` and `~/.claude.json`
and load the project.

```bash
PROJECT=my/project/path docker compose run --rm claude
```

The project name is `project` by default. You can override it like this:

```bash
PROJECT_NAME=my-project PROJECT=my/project/path docker compose run --rm claude
```

Alternatively, use a custom env file:

```bash
docker compose --env-file .my-project.env run --rm claude
```