require 'csv'
class StatTracker

  attr_reader :game_manager, :team_manager, :game_team_manager


  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    load_managers(locations)
  end

  def load_managers(locations)
    @game_manager = GameManager.new(locations[:games], self)
    @team_manager = TeamManager.new(locations[:teams], self)
    @game_team_manager = GameTeamManager.new(locations[:game_teams], self)
  end

  require 'pry'; binding.pry

  # Coaching Statistics


  def winningest_coach

  end

  def worst_coach
    # Name of the Coach with the worst win percentage for the season (String)

  end

  def most_accurate_team
    # Name of the Team with the best ratio of shots to goals for the season (String)
  end

  def least_accurate_team
    # Name of the Team with  the worst ratio of shots to goals for the season (String)
  end

  def most_tackles
    # Name of the Team with the most tackles in the season (String)
  end

  def fewest_tackles
    # Name of the Team with the fewest tackles in the season (String)
  end

  # Team Statistics
>>>>>>> d47329378e2b4b86fa1a8c973fe2d2de9882d2ef
end
