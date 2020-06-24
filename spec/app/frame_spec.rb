# frozen_string_literal: true

require './app/frame'

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

      it 'spare should be' do
        expect(frame.spare?).to eq false
      end

      it 'strike should be' do
        expect(frame.strike?).to eq false
      end

      context 'and hit1 + hit2 does not sum 10' do
        before { frame.hit2 = 1 }

        it 'spare should be' do
          expect(frame.spare?).to eq false
        end

        it 'strike should be' do
          expect(frame.strike?).to eq false
        end
      end

      context 'and hit1 + hit2 sum 10' do
        before { frame.hit2 = 5 }

        it 'spare should be' do
          expect(frame.spare?).to eq true
        end

        it 'strike should be' do
          expect(frame.strike?).to eq false
        end
      end
    end

    context 'when hit1 is 10' do
      before { frame.hit1 = 10 }

      it 'spare should be' do
        expect(frame.spare?).to eq false
      end

      it 'strike should be' do
        expect(frame.strike?).to eq true
      end
    end
  end
end
