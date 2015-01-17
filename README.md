# Hubot Assign Issues

A script to assign people to github issues with Hubot

## Installation

In hubot project repo, run:

```
npm install hubot-github-assign-issues --save
```

Then add **hubot-github-assign-issues** to your `external-scripts.json`:

```javascript
["hubot-github-assign-issues"]
```

## Configuration

You can use either

* The package use https://github.com/tombell/hubot-github-identity to authenticate the user
* `HUBOT_GITHUB_TOKEN` environment variable to authenticate with github

`HUBOT_GITHUB_USER` is the default owner of the repositories you'll target.

### Acquire a token

If you don't have a token yet, run this:

```
curl -i https://api.github.com/authorizations -d '{"note":"githubot","scopes":["repo"]}' -u "yourusername"
```

Enter your Github password when prompted. When you get a response, look for the "token" value.

## Hubot Commands

```
hubot issues assign to <user> [user/]repo #id
```
