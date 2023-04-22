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

  describe '#most_accurate_team' do
    it 'returns the team name with best shot:goal' do
      expect(@season_stats.most_accurate_team(games.season)).to be_a(String)
      expect(@season_stats.most_accurate_team("20132014")).to eq "Real Salt Lake"
      expect(@season_stats.most_accurate_team("20142015")).to eq "Toronto FC"
    end
  end

  # Name of the Coach with the best win percentage for the season
  describe '#winningest_coach' do
    xit 'returns the coach with the best win percentage for the season' do
      expect(@season_stats.winningest_coach("20132014")).to eq("Claude Julien")
      expect(@season_stats.winningest_coach("20142015")).to eq("Alain Vigneault")
    end
  end

  describe '#worst_coach' do
    it 'returns the coach with the worst win percentage' do
      expect(@season_stats.worst_coach("20132014")).to eq("Peter Laviolette")
      expect(@season_stats.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
    end
  end

  describe '#head_coach_games' do
    xit 'returns the number of games a coach has played' do
      expect(@season_stats.head_coach_games("Craig MacTavish")).to be_a(Integer)
    end
  end
end