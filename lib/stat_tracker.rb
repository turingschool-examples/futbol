require 'CSV'
require './lib/game_manager'
require './lib/team_manager'
require './lib/game_teams_manager'
require './lib/game'
require './lib/game_teams'
require './lib/team'

class StatTracker

  attr_reader :game_manager, :game_teams_manager, :team_manager

  def self.from_csv(data)
    StatTracker.new(data)
  end

  def initialize(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]

    @game_teams_manager = GameTeamsManager.new(game_teams_path)

    @game_manager = GameManager.new(game_path)

    @team_manager = TeamManager.new(team_path)
  end

  def highest_total_score
    @game_manager.highest_total_score
  end


  def lowest_total_score
    @game_manager.lowest_total_score
  end
  #
  #   def find_team_id(team)
  #     results = @teams_file.find {|row| row[2] == team}
  #     results[0]
  #   end
  #
  #
  # #### Need to figure out how to un-chain method

  def percentage_home_wins
   @game_teams_manager.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_teams_manager.percentage_visitor_wins
  end
  




end
