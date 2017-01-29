Chance = require 'chance'
request = require 'request'
fs = require 'fs'
path = require 'path'
{ spawn } = require 'child_process'

# This module requires imagemagick installed and on PATH
class ImageModule extends BotModule
  init: =>
    @images = path.join(__dirname, '../images')

    @registerCommand 'trigger', {everyone: true}, (msg, args)=>
      # Get the avatar
      u = msg.mentions[0] or msg.author
      p = spawn 'convert', [
        '-'
        '-resize', '256x'
        '-radial-blur', '10'
        '-fill', 'red'
        '-tint', '100'
        './images/triggerol.png'
        '-append', 'jpeg:-'
      ]
      request(u.avatarURL).pipe p.stdin
      b = []
      p.stdout.on 'data', (d)=> b.push(d)
      p.stdout.on 'end', =>
        msg.channel.uploadFile Buffer.concat(b), 'triggered.jpg'

    @registerCommand 'spoiler', {everyone: true}, (msg, args)=>
      msg.delete()
      b = []
      p = spawn 'convert', [
        '-background', 'black'
        '-pointsize', 16
        '-size', '360x'
        '-fill', 'black'
        "caption:#{args}"
        '-delay', 1
        '-loop', 1
        '-coalesce', '('
          '-fill', 'black'
        ')', '('
          '-fill', 'white'
          "caption:#{args}"
        ')'
        'gif:-'
      ]
      mstr = msg.author.mention if msg.author.id isnt @bot.User.id
      p.stdout.on 'data', (d)=> b.push(d)
      p.stdout.on 'end', =>
        msg.channel.uploadFile Buffer.concat(b), 'spoiler.gif', mstr

    # Example command for custom image command.
    # Place the image files in the "images" folder.
    @registerCommand 'thknig', { everyone: true }, (msg, args)=>
      msg.channel.uploadFile fs.createReadStream("#{@images}/example.png"), 'example.png'
    @registerCommand 'swdelet', { everyone: true }, (msg, args)=>
      msg.channel.uploadFile fs.createReadStream("#{@images}/swdelet.jpg"), 'swdelet.jpg'
    @registerCommand 'spooky', { everyone: true }, (msg, args)=>
      msg.channel.uploadFile fs.createReadStream("#{@images}/spooky.png"), 'spooky.png'
    @registerCommand 'nope', { everyone: true }, (msg, args)=>
      msg.channel.uploadFile fs.createReadStream("#{@images}/nope.png"), 'nope.png'
    @registerCommand 'delet', { everyone: true }, (msg, args)=>
      msg.channel.uploadFile fs.createReadStream("#{@images}/delet.jpg"), 'delet.jpg'
    @registerCommand 'sweet', { everyone: true }, (msg, args)=>
      msg.channel.uploadFile fs.createReadStream("#{@images}/sweet.jpg"), 'sweet.jpg', 'Have a bread!'
    @registerCommand 'italian', { everyone: true }, (msg, args)=>
      msg.channel.uploadFile fs.createReadStream("#{@images}/italian.jpg"), 'italian.jpg', 'Have a bread!'
    @registerCommand 'pita', { everyone: true }, (msg, args)=>
      msg.channel.uploadFile fs.createReadStream("#{@images}/pita.jpg"), 'pita.jpg', 'Have a bread!'
    @registerCommand 'melon', { everyone: true }, (msg, args)=>
      msg.channel.uploadFile fs.createReadStream("#{@images}/melon.jpg"), 'melon.jpg', 'Have a bread!'
    @registerCommand 'baguette', { everyone: true }, (msg, args)=>
      msg.channel.uploadFile fs.createReadStream("#{@images}/baguette.jpg"), 'baguette.jpg', 'Have a bread!'

module.exports = ImageModule
