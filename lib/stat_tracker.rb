require 'CSV'
require './lib/games_repo'
require './lib/teams_repo'
require './lib/game_teams_repo'

class StatTracker
  attr_reader :games_repo, :teams_repo, :game_teams_repo

  def initialize(locations)
    @games_repo = GamesRepo.new(locations[:game_path], self)
    @teams_repo = TeamsRepo.new(locations[:teams_path], self)
    @game_teams_repo = GameTeamsRepo.new(locations[:game_teams_path], self)

  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def count_of_teams
    @teams_repo.count_of_teams
  end

  def best_offense
    id = @game_teams_repo.highest_average_goals
    @teams_repo.team_name(id)
  end
  
  def worst_offense
    id = @game_teams_repo.lowest_average_goals
    @teams_repo.team_name(id)
  end
end