# frozen_string_literal: true

require './app/frame'

# The goal of this class is is create an array of frames and
# implement the logic to record each frame information.
class BowlingBoard
  attr_reader :table

  def initialize
    @table = 10.times.map { |position| Frame.new(position) }
    @scores = []
  end

  def record_results(position, hit1, hit2)
    table[position].hit1 = hit1
    table[position].hit2 = hit2
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

    frame.score += get_bonus(position + 1, true) if frame.strike?
    frame.score += get_bonus(position + 1) if frame.spare?
  end

  def get_bonus(position, strike = false)
    calculate_if_extra_ball(strike, position, table.last)
    frame = table[position]
    return frame.hit1 unless strike

    frame.strike? ? frame.hit1 + get_bonus(position + 1) : frame.score
  end

  def calculate_if_extra_ball(strike, position, frame)
    return unless position == 10

    strike ? frame.hit2 + frame.hit3 : frame.hit2
  end
end
