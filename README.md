# Claude in Docker

## Run

Use the `claude-in-docker` script to run `claude` inside Docker. It uses the credentials and settings from `~/.claude` and `~/.claude.json` and mounts the specified project directory into the container.

To make the script available from anywhere, create a symlink in your PATH:

```bash
ln -s /path/to/claude-in-docker/claude-in-docker /usr/local/bin/claude-in-docker
```

Then you can run it from any project root:

```bash
cd /path/to/my/project
claude-in-docker --project .
```

Or with a full path:

```bash
claude-in-docker --project /path/to/my/project
```

The project is mounted at `/home/ubuntu/project` inside the container. You can override the name with the `PROJECT_NAME` environment variable:

```bash
PROJECT_NAME=my-project claude-in-docker --project .
```

### Flags

| Flag | Description |
|---|---|
| `--project <path>` | Path to the project directory to mount (required) |
| `--build` | Rebuild the Docker image before running |
| `--env-file <path>` | Path to an env file to pass to Docker Compose |

## Hiding files from Claude

Create a `.claude-in-docker-ignore` file at the root of your project to specify files that should be hidden from Claude. Each line is a path or glob pattern relative to the project root. Lines starting with `#` are treated as comments.

```gitignore
# Hide all .env files
**/.env

# Hide a specific secrets file
config/secrets.yml
```

Files matched by the ignore file are replaced with an empty `/dev/null` mount inside the container, so Claude cannot read their contents.

## Using multiple accounts

By default, `claude-in-docker` reads settings from `~`. However, in order to mange multiple accounts, you can move your settings to a separated folder e.g.:

```bash
mkdir ~/claude
mv ~/.claude* claude/my-account/
```

Then, set the corresponding environment variables in your `.env` file:

```env
CLAUDE_DIR=~/claude/my-account/.claude
CLAUDE_JSON=~/claude/my-account/.claude.json
```

You can also create more account folders from scratch:

```bash
mkdir ~/claude/other-account/.claude -p
touch ~/claude/other-account/.claude.json
```

And create an additional `.other-project.env` env file.

Now, you'll be able to start multiple projects with different accounts:

```bash
./claude-in-docker --env-file .my-project.env --project /path/to/my-project
./claude-in-docker --env-file .other-project.env --project /path/to/other-project
```