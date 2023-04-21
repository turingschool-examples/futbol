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

    @season_stats = SeasonStats.new(@locations)
    @season_stats.merge_game_game_teams
    @season_stats.merge_teams_to_game_game_teams
  end

  describe '#initialize' do
    xit 'exists' do
      expect(@season_stats).to be_a(SeasonStats)
    end
  end

  # Name of the Coach with the best win percentage for the season
  describe '#winningest_coach' do
    it 'returns the coach with the best win percentage for the season' do
      expect(@season_stats.winningest_coach("20132014")).to eq("Claude Julien")
      expect(@season_stats.winningest_coach("20142015")).to eq("Alain Vigneault")

    end
  end
end