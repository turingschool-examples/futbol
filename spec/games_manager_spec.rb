require 'spec_helper'

RSpec.describe GamesManager do
  context 'games_manager' do
    games_manager = GamesManager.new('./data/mini_games.csv')

    it 'has attributes' do
      expect(games_manager.games).not_to be_empty
    end

    it 'makes games' do
      expect(games_manager).to respond_to(:make_games)
    end

    it 'has highest and lowest total scored' do
      expect(games_manager.score_results(:max)).to eq(7)
      expect(games_manager.score_results(:min)).to eq(1)
    end

    it 'counts games per season' do
      expected = {
        '20132014' => 6,
        '20142015' => 19,
        '20152016' => 9,
        '20162017' => 17
      }
      expect(games_manager.count_of_games_by_season).to eq(expected)
    end

    it 'has average goals by season' do
      expected = {
        '20142015' => 3.63,
        '20152016' => 4.33,
        '20132014' => 4.67,
        '20162017' => 4.24
      }
      expect(games_manager.average_goals_by_season).to eq(expected)
    end

    it 'goals per season' do
      expect(games_manager).to respond_to(:goals_per_season)
    end

    it 'has average goals per game' do
      expect(games_manager.average_goals_per_game).to eq(4.08)
    end

    it 'games per season' do
      expect(games_manager.games_per_season('20132014')).to eq(6)
    end

    it 'highest scoring vistor and home team' do
      expect(games_manager.team_scores(:away, :max)).to eq('5')
      expect(games_manager.team_scores(:home, :max)).to eq('24')
    end

    it 'lowest scoring vistor and home team' do
      expect(games_manager.team_scores(:away, :min)).to eq('13')
      expect(games_manager.team_scores(:home, :min)).to eq('13')
    end

    it 'has a favourite opponent' do
      expect(games_manager.opponent_results('15', :fav)).to eq('10')
    end

    it 'has a rival' do
      expect(games_manager.opponent_results('15', :rival)).to eq('2')
    end

    it 'calcs win percents' do
      input = [
        ['3', { win: 3, loss: 7 }],
        ['10', { win: 0, loss: 4 }],
        ['2', { win: 2, loss: 3 }]
      ]
      expected = [['3', 3.fdiv(7)], ['10', 0.0], ['2', 2.fdiv(3)]]
      expect(games_manager.win_percent(input)).to eq(expected)
    end
  end
end
