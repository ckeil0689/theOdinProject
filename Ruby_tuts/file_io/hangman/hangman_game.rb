#!/usr/bin/env ruby

require './lib/Game'

begin
  puts "Ruby Hangman ----"
  game = Game.new
  game.run
rescue SystemExit, Interrupt => e
  puts "Game was quit. (#{e.class})"
  puts
end