# frozen_string_literal: true

require './app/bowling_board'

RSpec.describe BowlingBoard, '#Methods' do
  let!(:bowling) { BowlingBoard.new }

  it 'validating board contruction' do
    expect([Frame] * 10).to eq(bowling.table.map(&:class))
  end

  context 'recording a frame' do
    before do
      bowling.record_results(0, 5, 4)
      bowling.record_results(5, 2, 8)
    end
    let(:pos) { 0 }
    let(:result) { [bowling.table[pos].hit1, bowling.table[pos].hit2] }

    it 'the first frame should value' do
      expect([5, 4]).to eq(result)
    end

    context 'the fifth frame' do
      let(:pos) { 5 }
      it 'should value' do
        expect([2, 8]).to eq(result)
      end
    end
  end

  context 'recording an extra hit in last frame' do
    before { bowling.record_extra_ball(8) }

    it 'third hit in a random frame should value' do
      expect(0).to eq(bowling.table[rand(0...8)].hit3)
    end

    it 'third hit in tenth frame should value' do
      expect(8).to eq(bowling.table[9].hit3)
    end
  end

  context 'calculating results in a game' do
    let(:values) do
      [[5, 4], [7, 2], [4, 4], [4, 4], [1, 2], [10, 0], [9, 1], [0, 0], [6, 1], [5, 5]]
    end
    before do
      bowling.table.each_with_index do |frame, idx|
        frame.hit1 = values[idx].first
        frame.hit2 = values[idx].last
      end
      bowling.record_extra_ball(10)
      bowling.calculate_totals
    end

    it 'score in each frame should value' do
      [9, 18, 26, 34, 37, 57, 67, 67, 74, 94].each_with_index do |val, idx|
        expect(val).to eq(bowling.table[idx].score)
      end
    end
  end
end
