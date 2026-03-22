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
docker compose --env-file .my-project.env run --rm claude
docker compose --env-file .other-project.env run --rm claude
```