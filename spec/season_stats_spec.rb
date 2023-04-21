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
    it 'exists' do
      expect(@season_stats).to be_a(SeasonStats)
    end
  end

  describe '#most_accurate_team' do
    it 'returns the team name with best shot:goal' do
      expect(@season_stats.most_accurate_team(games.season)).to be_a(String)
      expect(@season_stats.most_accurate_team("20132014")).to eq "Real Salt Lake"
      expect(@season_stats.most_accurate_team("20142015")).to eq "Toronto FC"
    end
  end



end

