# frozen_string_literal: true

require './app/bowling_board'

def print_table_score(bowling_table)
  first_frame_section = second_frame_section = '|'
  line = ''

  bowling_table.each do |frame|
    first_frame_section += " #{frame.strike? ? 'X' : frame.hit1}| #{frame.spare? ? '/' : frame.hit2}\t|"
    first_frame_section += " #{frame.hit3 == 10 ? 'X' : frame.hit3} |" if frame.position == 9
    second_frame_section += "   #{frame.score}\t|"
    line += '---------'
  end

  puts first_frame_section, line, second_frame_section, line
end

def third_roll?(frame)
  frame.position == 9 && (frame.strike? || frame.spare?)
end

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

  next unless third_roll?(bowling_game.table[roll])

  ball3 = rand(0..10)
  puts "rolliing third ball... you knock down #{ball3} pins\n\n"
  bowling_game.record_extra_ball(ball3)
end

bowling_game.calculate_totals

print_table_score(bowling_game.table)
