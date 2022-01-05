require 'csv'
class StatTracker
  attr_reader :game_manager, :team_manager, :game_team_manager, :game_statistics

  def initialize(locations)
    @game_manager = GameManager.new(locations[:games])
    @team_manager = TeamManager.new(locations[:teams])
    @game_team_manager = GameTeamManager.new(locations[:game_teams])
    @game_statistics = GameStatistics.new(game_manager)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
  # require 'pry'; binding.pry

  # Season Statistics
  def winningest_coach; end

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
end
