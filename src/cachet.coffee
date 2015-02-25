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

mkeRequest = (robot, path) ->
  return robot.http("#{cachetUrl}#{path}")
    .header('Accept', 'application/json')
    .header('X-Cachet-Token', cachetApiKey)

module.exports = (robot) ->
  robot.respond /cachet components list/i, (msg) ->
    mkeRequest(msg, '/api/components')
      .get() (err, res, body) ->
        if err
          msg.send "Problem accessing the Cachet API"
          console.log(err)
          return
        components = JSON.parse(body)
        for component in components
          msg.send "[#{component.status}] #{component.name}"
