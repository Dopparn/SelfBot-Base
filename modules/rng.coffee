# Everything's' ported from FocaBot
Chance = require 'chance'

class RNGModule extends BotModule
  init: =>
    @chance = new Chance

    @registerCommand 'roll', (msg, args)=>
      max = parseInt(args) or 100
      result = @chance.integer {min: 0, max}
      msg.channel.sendMessage "#{msg.author.mention} 🎲 rolls **#{result}/#{max}**."

    @registerCommand 'choose', { argSeparator: ';' }, (msg, args)=>
      if args.length < 2
        msg.reply 'Not enough items to choose from. Remember to use `;` to separate them.'
      else
        msg.reply "I choose #{@chance.pickone args}"

    # Baits go here
    @registerCommand 'bait', {everyone: true}, (msg)=> msg.channel.sendMessage @chance.pickone [
      "1"
      "2"
      "3"
      "4"
      "5"
      "6"
      "7"
      "8"
      "9"
      "10"
      "11"
      "12"
      "13"
      "14"
      "15"
      "16"
      "17"
      "18"
      "19"
      "20"
    ]

    @registerCommand 'rate', (msg, args)=>
      return if not args
      for i in [0 ... args.length]
        chr   = args.charCodeAt(i)
        hash  = ((hash << 5) - hash) + chr
        hash |= 0
      rate = Math.ceil(((hash & 0xFF) / 255) * 10)
      msg.reply "I'd give #{args} a #{rate}/10."

module.exports = RNGModule