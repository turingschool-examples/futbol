require 'csv'
require 'pry'
require './lib/game'
require './lib/team'
require './lib/game_team'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize
    @games = []
    @teams = []
    @game_teams = []
  end

  def self.from_csv(filenames)
    stat_tracker = StatTracker.new
    stat_tracker.make_games(filenames)
    stat_tracker.make_teams(filenames)
    stat_tracker.make_game_teams(filenames)
    stat_tracker
  end

  def make_games(filenames)
    CSV.foreach(filenames[:games], headers: true) do |row|
      @games << Game.new(row)
    end
  end

  def make_teams(filenames)
    CSV.foreach(filenames[:teams], headers: true) do |row|
      @teams << Team.new(row)
    end
  end

  def make_game_teams(filenames)
    CSV.foreach(filenames[:game_teams], headers: true) do |row|
      @game_teams << GameTeam.new(row)
    end
  end

  def team_info(team_name)

    team_info = {}
    team = @teams.select do |team|
      team.teamName == team_name
    end

    team_info['team_id'] = team[0].team_id
    team_info['franchiseId'] = team[0].franchiseId
    team_info['teamName'] = team[0].teamName
    team_info['abbreviation'] = team[0].abbreviation
    team_info['link'] = team[0].link

    team_info
  end

end


StatTracker.from_csv({ games: './data/games.csv',
                       teams: './data/teams.csv',
                       game_teams: './data/game_teams.csv' })
