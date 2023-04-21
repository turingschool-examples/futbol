require 'spec_helper'

RSpec.describe GamesStats do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }

    @games_stats = GamesStats.new(locations)
    @games_stats.merge_game_game_teams
  end

  describe '#initialize' do
    it 'exists' do
      expect(@games_stats).to be_a(GamesStats)
    end
  end

  # highest sum of winning and losing teams score
  describe '#highest_total_score' do
    expect(@games_stats.highest_total_score).to be_a(String)
  end
end