# Description:
#   Assign issues with hubot
#
# Commands:
#   hubot issues assign {user} to {user}/{repo}#id - Assign user to the issue
#
# Author:
#   Soulou

githubot = require('githubot')

module.exports = (robot) ->
  useIdentity = process.env.HUBOT_GITHUB_IDENTITY?

  handleTokenError = (res, err) ->
    switch err.type
      when 'redis'
        res.reply "Oops: #{err}"
      when 'github user'
        res.reply "Sorry, you haven't told me your GitHub username."

  robot.respond /issues assign ([-_\.0-9a-z]+) to (([-_\.0-9a-z]+\/)?[-_\.0-9a-z]+) (#[0-9]+)/i, (res) ->
    console.log(res.match)
    repo = githubot.qualified_repo res.match[2]
    id = res.match[4].slice(1)
    payload = {}
    payload.assignee = res.match[1]
    url  = "/repos/#{repo}/issues/#{id}"
    console.log(url)
    user = res.envelope.user.name

    assignIssue = (github, payload) ->
      github.patch url, payload, (issue) ->
        res.reply "I've assigned #{payload.assignee} to #{issue.number} (#{issue.html_url})"

    return assignIssue(githubot(robot), payload) unless useIdentity

    robot.identity.findToken user, (err, token) ->
      if err
        handleTokenError(res, err)
      else
        assignIssue(githubot(robot, token: token), payload)
