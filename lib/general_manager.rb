class GeneralManager
  attr_reader :teams_manager,
              :games_manager,
              :game_teams_manager

  def initialize(locations)
    @teams_manager = TeamsManager.new(locations[:teams])
    @games_manager = GamesManager.new(locations[:games])
    @game_teams_manager = GameTeamsManager.new(locations[:game_teams])
  end

  def team_info(team_id)
    @teams_manager.team_info(team_id)
  end

  def count_of_teams
    @teams_manager.count_of_teams
  end
end




  # def highest_total_score
  # end
  # def lowest_total_score
  # end
