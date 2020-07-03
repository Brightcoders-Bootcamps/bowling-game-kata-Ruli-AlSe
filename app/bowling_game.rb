# frozen_string_literal: true

require './app/bowling_board'
require './app/game_helper.rb'
include GameHelper

puts 'Begining the game'
bowling_game = BowlingBoard.new
ball1 = 0
ball2 = 0
ball3 = 0

10.times do |roll|
  puts "\n--------------------------- FRAME #{roll + 1}---------------------------"
  ball1 = rand(0...10)
  puts "rolliing first ball... you knock down #{ball1} pins"

  offset = 10 - ball1
  if offset != 0 || roll == 9
    offset = 10 if roll == 9
    ball2 = rand(0..offset)
    puts "rolliing second ball... you knock down #{ball2} pins"
  end

  bowling_game.record_results(roll, ball1, ball2)

  next unless GameHelper.third_roll?(bowling_game.table[roll])

  ball3 = rand(0..10)
  puts "rolliing third ball... you knock down #{ball3} pins\n\n"
  bowling_game.record_extra_ball(ball3)
end

bowling_game.calculate_totals

GameHelper.print_table_score(bowling_game.table)
