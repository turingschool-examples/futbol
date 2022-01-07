require './lib/stat_tracker.rb'
require './spec/spec_helper.rb'
require './lib/league_statistics'
require 'pry'

RSpec.describe LeagueStatistics do
  before(:each) do
    game_path = './data/games_samples.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_samples.csv'

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


    it 'goals by game' do
      league = LeagueStatistics.new(@locations)
      expect(league.goals_by_game).to eq([5, 5, 3, 5, 4, 3, 5, 3, 1, 3, 3, 4, 2, 3])
    end

    it 'games by season' do
      league = LeagueStatistics.new(@locations)
      expect(league.games_by_season).to eq({"20122013"=>["2012030221", "2012030222", "2012030223", "2012030224", "2012030225", "2012030311", "2012030312", "2012030313", "2012030314", "2012030231", "2012030232", "2012030233", "2012030234", "2012030235"]})
    end

    it 'all goals' do
      league = LeagueStatistics.new(@locations)
      expect(league.all_goals).to eq([2, 3, 2, 3, 2, 1, 3, 2, 1, 3, 3, 0, 4, 1, 1, 2, 0, 1, 1, 2, 2, 1, 1, 3, 0, 2, 1, 2])
    end

    it 'average goals per game' do
      league = LeagueStatistics.new(@locations)
      expect(league.average_goals_game).to eq(3.5)
    end

    xit 'average goals per team' do
      league = LeagueStatistics.new(@locations)
      expect(league.average_goals_team).to eq({"16"=>[2, 1, 1, 0, 2, 2, 2], "17"=>[1, 2, 3, 2, 1, 3, 1], "3"=>[2, 2, 1, 2, 1], "5"=>[0, 1, 1, 0], "6"=>[3, 3, 2, 3, 3, 3, 4, 2, 1]})
    end

    xit 'max average goals per team' do
      league = LeagueStatistics.new(@locations)
      expect(league.max_average_goals_team).to eq([""])
    end

    xit 'games by teams' do
      league = LeagueStatistics.new(@locations)
      expect(league.games_by_teams).to eq([""])
    end

    it 'team with highest average number of goals' do
      league = LeagueStatistics.new(@locations)
      expect(league.best_offense).to eq("FC Dallas")
    end

    xit 'team with lowest average number of goals' do
      league = LeagueStatistics.new(@locations)
      expect(league.worst_offense).to eq("FC Dallas")
    end

  end
