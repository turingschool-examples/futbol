require 'spec_helper'

RSpec.describe GamesStats do
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
    # @games_stats.merge_team_to_game_game_teams
  end

  describe '#initialize' do
    xit 'exists' do
      expect(@games_stats).to be_a(GamesStats)
    end
  end

  # highest sum of winning and losing teams score
  describe '#highest_total_score' do
    xit 'checks highest total score of a game' do
      expect(@games_stats.highest_total_score).to eq(11)
    end
  end


  describe '#count_of_games_by_season' do
    xit 'returns a hash of total games in a season' do
      expect(@games_stats.count_of_games_by_season).to be_a(Hash)
      expect(@games_stats.count_of_games_by_season).to eq({
        "20122013"=>806,
        "20162017"=>1317,
        "20142015"=>1319,
        "20152016"=>1321,
        "20132014"=>1323,
        "20172018"=>1355
      })
    end
  end

  describe '#average_goals_per_game' do
    xit 'returns a float of goals scored in a game across all seasons' do
      expect(@games_stats.average_goals_per_game).to be_a(Float)
      expect(@games_stats.average_goals_per_game).to eq(4.22)
    end
  end

  describe '#average_goals_by_season' do
    it 'returns a hash of average number of goals by season' do
      expect(@games_stats.average_goals_by_season).to be_a(Hash)
      expect(@games_stats.average_goals_by_season).to eq({
        "20122013"=>4.12,
        "20162017"=>4.23,
        "20142015"=>4.14,
        "20152016"=>4.16,
        "20132014"=>4.19,
        "20172018"=>4.44
      })
    end
  end
end