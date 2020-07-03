# frozen_string_literal: true

require './app/frame'

# The goal of this class is is create an array of frames and
# implement the logic to record each frame information.
class BowlingBoard
  attr_reader :table

  def initialize
    @table = 10.times.map { |position| Frame.new(position) }
  end

  def record_results(position, score, pts)
    frame = table[position]
    frame.hit1 = score
    frame.hit2 = pts
  end

  def record_extra_ball(hit)
    table.last.hit3 = hit
  end

  def calculate_totals
    table.each do |frame|
      position = frame.position
      score_for_valid_position(frame, position)

      frame.score += table[position - 1].score unless position.zero?
    end
  end

  private

  def score_for_valid_position(frame, position)
    return unless position < 9

    next_position = position + 1
    frame.score += get_bonus(next_position, true) if frame.strike?
    frame.score += get_bonus(next_position) if frame.spare?
  end

  def get_bonus(position, strike = false)
    calculate_if_extra_ball(strike, position, table.last)
    frame = table[position]
    hit_val = frame.hit1
    return hit_val unless strike

    frame.strike? ? hit_val + get_bonus(position + 1) : frame.score
  end

  def calculate_if_extra_ball(strike, position, frame)
    return unless position == 10

    hit_val = frame.hit2
    strike ? hit_val + frame.hit3 : hit_val
  end
end
