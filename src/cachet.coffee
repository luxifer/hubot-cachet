# Description:
# Get status and control CircleCI from hubot
#
# Dependencies:
# None
#
# Commands:
# hubot cachet components list - Returns the list of the composants on the cachet status page
#
# Configuration:
# HUBOT_CACHET_API_URL
# HUBOT_CACHET_API_KEY
#
# Author:
# luxifer

cachetUrl = process.env.HUBOT_CACHET_API_URL
cachetApiKey = process.env.HUBOT_CACHET_API_KEY

cachetGet = (robot, path) ->
  robot.http("#{cachetUrl}#{path}")
    .header('Accept', 'application/json')
    .header('X-Cachet-Token', cachetApiKey)
    .get() (err, res, body) ->
      return JSON.parse(body)

module.exports = (robot) ->

  getComponents = (msg) ->
    components = cachetGet(msg, '/api/components')
    for component in components
      msg.send "[#{component.status}] #{component.name}"

  robot.respond /cachet components list/i, (msg) ->
    getComponents(msg)
