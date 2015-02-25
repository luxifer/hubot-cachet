chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'cachet', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/cachet')(@robot)

  it 'list cachet components', ->
    expect(@robot.respond).to.have.been.calledWith(/cachet components list/)
