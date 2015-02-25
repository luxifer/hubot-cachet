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

moment = require('moment');

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
        if components.data.length
          for component in components.data
            msg.send "[#{component.id}][#{component.status}] #{component.name}"
        else
          msg.send "No components :("

  robot.respond /cachet incidents list/i, (msg) ->
    req = makeRequest(msg, '/api/incidents')
    req
      .get() (err, res, body) ->
        if err
          msg.send "Problem accessing the Cachet API"
          console.log(err)
          return
        incidents = JSON.parse(body)
        if incidents.data.length
          for incident in incidents.data
            incidentDay = moment.unix(incident.created_at) # format("dddd, MMMM Do YYYY, h:mm:ss a")
            if incident.component
              msg.send "[#{incident.id}] #{incident.human_status} \"#{incident.component.name}\" at #{incidentDay.format('dddd, MMMM Do YYYY, h:mm:ss a')}, #{incident.message}"
            else
              msg.send "[#{incident.id}] #{incident.human_status} at #{incidentDay.format('dddd, MMMM Do YYYY, h:mm:ss a')}, #{incident.message}"
