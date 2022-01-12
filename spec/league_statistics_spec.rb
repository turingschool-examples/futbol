require './lib/stat_tracker.rb'
require './spec/spec_helper.rb'
require './lib/league_statistics'
require 'pry'

RSpec.describe LeagueStatistics do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

  end

    it 'exists' do
      league = LeagueStatistics.new(@locations)
      expect(league).to be_instance_of(LeagueStatistics)
    end

    it 'count the number of teams' do
      league = LeagueStatistics.new(@locations)
      expect(league.count_of_teams).to eq(32)
    end

    it 'team with highest average number of goals' do
      league = LeagueStatistics.new(@locations)
      expect(league.best_offense).to eq("Reign FC")
    end

    it 'team with lowest average number of goals' do
      league = LeagueStatistics.new(@locations)
      expect(league.worst_offense).to eq("Utah Royals FC")
    end

    it 'team with highest average score when away' do
      league = LeagueStatistics.new(@locations)
      expect(league.highest_scoring_visitor).to eq("FC Dallas")
    end

    it 'team with highest average score when home' do
      league = LeagueStatistics.new(@locations)
      expect(league.highest_scoring_home_team).to eq("Reign FC")
    end

    it 'team with lowest average score when away' do
      league = LeagueStatistics.new(@locations)
      expect(league.lowest_scoring_visitor).to eq("San Jose Earthquakes")
    end

    it 'team with lowest average score when home' do
      league = LeagueStatistics.new(@locations)
      expect(league.lowest_scoring_home_team).to eq("Utah Royals FC")
    end


  end
