Chance = require 'chance'
request = require 'request'

# From FocaBot
class SealModule extends BotModule
  init: =>
    @registerCommand 'seal', {everyone: true}, (msg, args)->
      chance = new Chance()
      if chance.integer({ min: 0, max: 100 }) > 10
        # Get a seal from randomse.al
        seal = chance.integer { min: 1, max: 83 }
        seal = ('0000' + seal).substring(seal.toString().length)
        msg.channel.sendMessage "https://randomse.al/seals/#{seal}.jpg"
      else
        # Send... this...
        msg.channel.uploadFile request(
          'http://danbooru.donmai.us/data/__original_drawn_by_maldives__71425fe9ff40add3a301d5c5d0cf3baf.png'
        ), 'seal.png', 'A strange seal appeared.'

module.exports = SealModule
