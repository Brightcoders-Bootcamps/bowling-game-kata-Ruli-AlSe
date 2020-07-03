# frozen_string_literal: true

# Module that contains functions to use in the game
module GameHelper
  def print_table_score(bowling_table)
    header, body = frames_to_string(bowling_table, '|', '|')
    line = '---------' * 10

    puts header, line, body, line
  end

  def third_roll?(frame)
    frame.position == 9 && (frame.strike? || frame.spare?)
  end

  def frames_to_string(bowling_table, header, body)
    bowling_table.each do |frame|
      header += frame1_to_string(frame)
      body += "   #{frame.score}\t|"
    end

    [header, body]
  end

  def frame1_to_string(frame)
    " #{frame.strike? ? 'X' : frame.hit1} |" + frame2_to_string(frame) + extra_frame(frame)
  end

  def frame2_to_string(frame)
    " #{frame.spare? ? '/' : frame.hit2}\t|"
  end

  def extra_frame(frame)
    return '' unless frame.position == 9

    pts = frame.hit3
    " #{pts == 10 ? 'X' : pts} |"
  end
end
