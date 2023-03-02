require 'spec_helper'

RSpec.describe Game do
  let(:team_1) { Team.new(DATA[:teams][5]) }
  let(:team_2) { Team.new(DATA[:teams][4]) }

  let(:game_1) do
    data = {
      game: DATA[:games][0],
      teams: DATA[:teams][4..5],
      game_teams: DATA[:game_teams][0..1]
    }
    refs = {
      season: Season.new(DATA, []),
      home_team: team_1,
      away_team: team_2
    }
    Game.new(data, refs)
  end

  let(:game_2) do
    data = {
      game: DATA[:games][1],
      teams: DATA[:teams][4..5],
      game_teams: DATA[:game_teams][0..1]
    }
    refs = {
      season: Season.new(DATA, []),
      home_team: team_2,
      away_team: team_1
    }
    Game.new(data, refs)
  end

  describe '#initialize' do
    it 'exists' do
      expect(game_1).to be_a(Game)
      expect(game_2).to be_a(Game)
    end
  end

  describe '#info' do
    it 'has game information' do
      expect(game_1.info).to be_a(Hash)
    end
  end

  describe '#team_stats' do
    it 'has team_stats' do
      expect(game_1.team_stats).to be_a(Hash)
    end
  end

  describe '#refs' do
    it 'has references to other objects' do
      expect(game_1.refs).to be_a(Hash)
    end
  end
end
