require './lib/stat_tracker'
require './lib/game'

RSpec.describe Game do
  describe '#total_score' do
    it 'adds together the home_goals and away_goals' do
      away_goals = 3
      home_goals = 4
      game = Game.new({ 'away_goals' => away_goals, 'home_goals' => home_goals })
      expected = away_goals + home_goals
      actual = game.total_score
      expect(actual).to eq(expected)
    end
  end

  describe '.lowest_total_score' do
    context 'when there is a single game fitting the criteria' do
      it 'returns the lowest total score' do
        away_goals = 2
        home_goals = 1
        game = Game.new({ 'away_goals' => away_goals, 'home_goals' => home_goals })
        games = [game]
        expected = game.total_score
        actual = Game.lowest_total_score(games)
        expect(actual).to eq(expected)
      end
    end

    context 'when two games have different total_scores' do
      it 'returns the total_score of the game with the lower score' do
        away_goals = 3
        home_goals = 4
        game = Game.new({ 'away_goals' => away_goals, 'home_goals' => home_goals })
        game2 = Game.new({ 'away_goals' => home_goals, 'home_goals' => home_goals })
        games = [game, game2]
        expected = game.total_score
        actual = Game.lowest_total_score(games)
        expect(actual).to eq(expected)
      end
    end
  end

  describe '.highest_total_score' do
    context 'when there is a single game fitting the criteria' do
      it 'returns the total_score of the game' do
        away_goals = 3
        home_goals = 4
        game = Game.new({ 'away_goals' => away_goals, 'home_goals' => home_goals })
        games = [game]
        expected = game.total_score
        actual = Game.highest_total_score(games)
        expect(actual).to eq(expected)
      end
    end

    context 'when two games have the same total_score' do
      it 'returns the total_score of one of the games' do
        away_goals = 3
        home_goals = 4
        game = Game.new({ 'away_goals' => away_goals, 'home_goals' => home_goals })
        game2 = Game.new({ 'away_goals' => home_goals, 'home_goals' => away_goals })
        games = [game, game2]
        expected = game.total_score
        actual = Game.highest_total_score(games)
        expect(actual).to eq(expected)
      end
    end
  end
end
