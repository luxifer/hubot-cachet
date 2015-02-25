# Description:
#   Get status and control Cachet from hubot
#
# Dependencies:
#   None
#
# Commands:
#   hubot cachet components list - Returns the list of the composants on the cachet status page
#
# Configuration:
#   HUBOT_CACHET_API_URL
#   HUBOT_CACHET_API_KEY
#
# Author:
#   luxifer

cachetUrl = process.env.HUBOT_CACHET_API_URL
cachetApiKey = process.env.HUBOT_CACHET_API_KEY

module.exports = (robot) ->

  makeRequest = (robot, path) ->
    return robot.http("#{cachetUrl}#{path}")
      .header('Accept', 'application/json')
      .header('X-Cachet-Token', cachetApiKey)

  robot.respond /cachet components list/i, (msg) ->
    req = makeRequest(msg, '/api/components')
    req
      .get() (err, res, body) ->
        if err
          msg.send "Problem accessing the Cachet API"
          console.log(err)
          return
        components = JSON.parse(body)
        for component in components
          msg.send "[#{component.status}] #{component.name}"
