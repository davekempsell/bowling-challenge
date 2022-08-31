require 'scorecard'

RSpec.describe Scorecard do
  describe '#take_turn method' do
    it 'doesnt incremement the current frame if first roll is less than 10' do
      scorecard = Scorecard.new
      scorecard.take_turn(6)
      expect(scorecard.current_frame).to eq 1
    end
    it 'increments the current frame by 1 after second roll when first is less than 10' do
      scorecard = Scorecard.new
      scorecard.take_turn(0)
      scorecard.take_turn(0)
      expect(scorecard.current_frame).to eq 2
    end
    it 'increments the current frame by 1 after first roll when a strike is rolled' do
      scorecard = Scorecard.new
      scorecard.take_turn(10)
      expect(scorecard.current_frame).to eq 2
      scorecard.take_turn(3)
      scorecard.take_turn(5)
      expect(scorecard.current_frame).to eq 3
    end
    it 'passes score from turn into scorecard' do
      scorecard = Scorecard.new
      scorecard.take_turn(3)
      scorecard.take_turn(5)
      expect(scorecard.scores).to eq ([[3, 5]])
    end
    it 'passes scores from multiple open frames to scorecard' do
      scorecard = Scorecard.new
      scorecard.take_turn(3)
      scorecard.take_turn(5)
      scorecard.take_turn(2)
      scorecard.take_turn(3)
      expect(scorecard.scores).to eq ([[3, 5],[2, 3]])
    end
    it 'gives correct bonus when a spare is scored' do
      scorecard = Scorecard.new
      scorecard.take_turn(3)
      scorecard.take_turn(7)
      scorecard.take_turn(4)
      scorecard.take_turn(4)
      expect(scorecard.show_score).to eq 22
    end
    it 'gives the correct bonus when a strike is scored' do
      scorecard = Scorecard.new
      scorecard.take_turn(10)
      scorecard.take_turn(4)
      scorecard.take_turn(4)
      expect(scorecard.show_score).to eq 26
    end
    it 'gives the correct bonus when two consecutive strikes are scored' do
      scorecard = Scorecard.new
      scorecard.take_turn(10)
      scorecard.take_turn(10)
      scorecard.take_turn(4)
      scorecard.take_turn(4)
      expect(scorecard.show_score).to eq 50
    end
    it 'gives the correct bonus when strikes and spares are scored' do
      scorecard = Scorecard.new
      scorecard.take_turn(6)
      scorecard.take_turn(3)
      scorecard.take_turn(4)
      scorecard.take_turn(6)
      scorecard.take_turn(10)
      scorecard.take_turn(3)
      scorecard.take_turn(3)
      scorecard.take_turn(3)
      scorecard.take_turn(3)
      expect(scorecard.show_score).to eq (57)
    end
    it 'scores a perfect game as 300' do
      scorecard = Scorecard.new
      for i in 1..12 do
        scorecard.take_turn(10)
      end
      expect(scorecard.show_score).to eq 300
    end
    it 'scores a gutter game as 0' do 
      scorecard = Scorecard.new
      for i in 1..20 do
        scorecard.take_turn(0)
      end
      expect(scorecard.show_score).to eq 0
    end
    it 'calculates score correctly when final frame is a spare' do
      scorecard = Scorecard.new
      for i in 1..9 do
        scorecard.take_turn(10)
      end
      scorecard.take_turn(1)
      scorecard.take_turn(9)
      scorecard.take_turn(10)
      p scorecard.scores
      expect(scorecard.show_score).to eq 271
    end
  end 
  describe '#show_score method' do
    it 'returns the total score for the game' do
      scorecard = Scorecard.new
      scorecard.take_turn(3)
      scorecard.take_turn(5)
      scorecard.take_turn(2)
      scorecard.take_turn(3)
      expect(scorecard.show_score).to eq 13
    end
  end
end