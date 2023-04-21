require 'spec_helper'

RSpec.describe SeasonStats do
  before(:each) do
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
    games: @game_path,
    teams: @team_path,
    game_teams: @game_teams_path
    }

    @games_stats = GamesStats.new(@locations)
    @games_stats.merge_game_game_teams
    @games_stats.merge_teams_to_game_game_teams
  end

  describe '#initialize' do
    xit 'exists' do
    end
  end
end