require_relative './game_list'
require_relative './team_list'
require_relative './game_team_list'

class StatTracker
  attr_reader :game_list,
              :team_list,
              :game_team_list
              
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_list = GameList.new(locations[:games], self)
    @team_list = TeamList.new(locations[:teams], self)
    @game_team_list = GameTeamList.new(locations[:game_teams], self)
  end

  def highest_total_score
    @game_list.highest_total_score
  end

  def lowest_total_score
    @game_list.lowest_total_score
  end

  def percentage_home_wins
    @game_list.percentage_home_wins
  end
  
  def percentage_visitor_wins
    @game_list.percentage_visitor_wins
  end

  def percentage_ties
    @game_list.percentage_ties
  end

  def count_of_games_by_season
    @game_list.count_of_games_by_season
  end

  # def highest_scoring_home_team
  #   @team_list.highest_scoring_home_team
  # end

  # def highest_scoring_visitor
  #   @team_list.highest_scoring_visitor
  # end

end