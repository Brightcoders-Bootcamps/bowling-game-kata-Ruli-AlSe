# frozen_string_literal: true

require './app/frame'

RSpec.shared_examples 'false booleans' do
  it do
    %w[spare? strike?].each do |method|
      expect(frame.public_send(method)).to eq false
    end
  end
end

RSpec.shared_examples 'mixed booleans' do |param|
  let(:boolean) { param }
  it do
    [['spare?', boolean], ['strike?', !boolean]].each do |val|
      expect(frame.public_send(val.first)).to eq val.last
    end
  end
end

RSpec.describe Frame, '#variables' do
  let(:frame) { Frame.new(5) }

  context '#hits and #score' do
    before do
      frame.hit1 = 3
      frame.hit2 = 7
      frame.hit3 = 10
    end

    it '#hit1 should value' do
      expect(frame.hit1).to eq 3
    end

    it '#hit2 should value' do
      expect(frame.hit2).to eq 7
    end

    it '#hit3 should value' do
      expect(frame.hit3).to eq 10
    end

    it '#score should value' do
      expect(frame.score).to eq 20
    end
  end

  context '#spare and #strike' do
    context 'when hit1 is not 10' do
      before { frame.hit1 = 5 }

      it_behaves_like 'false booleans'

      context 'and hit1 + hit2 does not sum 10' do
        before { frame.hit2 = 1 }

        it_behaves_like 'false booleans'
      end

      context 'and hit1 + hit2 sum 10' do
        before { frame.hit2 = 5 }

        include_examples 'mixed booleans', true
      end
    end

    context 'when hit1 is 10' do
      before { frame.hit1 = 10 }

      include_examples 'mixed booleans', false
    end
  end
end
