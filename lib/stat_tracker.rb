require_relative './helper_class'
require_relative './game_list'
require_relative './team_list'
require_relative './game_team_list'

class StatTracker
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_list = GameList.new(locations[:games], self)
    @team_list = TeamList.new(locations[:teams], self)
    @game_team_list = GameTeamList.new(locations[:game_teams], self)
  end

  # def highest_total_score
  #   @game_list.highest_total_score
  # end

end