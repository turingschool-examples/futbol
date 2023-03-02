require './spec/spec_helper'


RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.new(locations)
  end

  describe 'game_stats' do
    it 'highest_total_score' do
      expect(@stat_tracker.highest_total_score).to eq(11)
    end
    
    it 'lowest_total_score' do
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end

    it 'average_goals_by_season' do
      avg_goals = @stat_tracker.average_goals_by_season
      expect(avg_goals).to be_a(Hash)
      expect(avg_goals[20122013]).to eq(4.12)
      expect(avg_goals[20132014]).to eq(4.19)
    end

    it 'average_home_wins' do
      expect(@stat_tracker.percent_home_wins).to eq(0.44)
    end

    it 'average_away_wins' do
      expect(@stat_tracker.percent_away_wins).to eq(0.36)
    end

    it 'average_ties' do
      expect(@stat_tracker.percent_ties).to eq(0.20)
    end

    it 'count_of_games_by_season' do
      expect(@stat_tracker.count_of_games_by_season[20122013]).to eq(806)
    end

    it 'average_goals_per_game' do
      expect(@stat_tracker.average_goals_per_game).to eq(4.22)
    end
  end

  describe 'league_stats' do
    it 'count_of_teams' do
      expect(@stat_tracker.count_of_teams).to eq(32)
    end

    it 'best_offense' do
      expect(@stat_tracker.best_offense).to eq("Reign FC")
    end
    
    it 'worst_offense' do
      expect(@stat_tracker.worst_offense).to eq("Utah Royals FC")
    end

    it 'highest_scoring_visitor' do
      expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
    end

    it 'lowest_scoring_visitor' do
      expect(@stat_tracker.lowest_scoring_visitor).to eq("San Jose Earthquakes")
    end

    it 'highest_scoring_home_team' do
      expect(@stat_tracker.highest_scoring_home_team).to eq("Reign FC")
    end

    it 'lowest_scoring_visitor' do
      expect(@stat_tracker.lowest_scoring_home_team).to eq("Utah Royals FC")
    end

    it 'winningest_coach' do
      expect(@stat_tracker.winningest_coach('2012')).to eq("Mike Babcock")
    end
  end
end