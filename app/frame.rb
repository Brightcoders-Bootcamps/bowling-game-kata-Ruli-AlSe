# frozen_string_literal: true

# This is the most basic component that a bowling game contains.
class Frame
  attr_reader :hit1, :hit2, :hit3, :position
  attr_accessor :score

  def initialize(position)
    @hit1 = 0
    @hit2 = 0
    @hit3 = 0
    @score = 0
    @spare = false
    @strike = false
    @position = position
  end

  def hit1=(value)
    @strike = true if value == 10
    @hit1 = value
    @score += value
  end

  def hit2=(value)
    @spare = true if @hit1 + value == 10 && !@strike
    @hit2 = value
    @score += value
  end

  def hit3=(value)
    @hit3 = value
    @score += value
  end

  def spare?
    @spare
  end

  def strike?
    @strike
  end
end
