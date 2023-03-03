require 'spec_helper'

RSpec.describe Season do
  let(:team_1) { Team.new(DATA[:teams][5]) }
  let(:team_2) { Team.new(DATA[:teams][4]) }

  let(:game_1) do
    data = {
      game: DATA[:games][0],
      game_teams: DATA[:game_teams][0..1]
    }
    team_refs = {
      home_team: team_1,
      away_team: team_2
    }
    Game.new(data, team_refs)
  end

  let(:game_2) do
    data = {
      game: DATA[:games][1],
      game_teams: DATA[:game_teams][0..1]
    }
    team_refs = {
      home_team: team_2,
      away_team: team_1
    }
    Game.new(data, team_refs)
  end

  let(:season_1) { Season.new('20122013', [team_1, team_2], [game_1, game_2]) }
  let(:season_2) { Season.new('20132014', [team_1, team_2], [game_1, game_2]) }

  describe '#initialize' do
    it 'exists' do
      expect(season_1).to be_a(Season)
      expect(season_2).to be_a(Season)
    end
  end

  describe '#year' do
    it 'has a year' do
      expect(season_1.year).to eq('20122013')
    end
  end

  describe '#teams' do
    it 'has a list of teams' do
      actual = season_1.teams.all? do |team|
        team.is_a?(Team)
      end

      expect(actual).to eq(true)
    end
  end

  describe '#games' do
    it 'has a list of games' do
      actual = season_1.games.all? do |game|
        game.is_a?(Game)
      end

      expect(actual).to eq(true)
    end
  end
end
