require './lib/managers/game_team_manager'
require 'pry'
# THIS IS MICHAEL'S
# Season Statistics
class SeasonStatistics
  attr_reader :gtmd
  def initialize(game_team_manager)
    @gtmd = game_team_manager # accronym for gameteammanagerdata
  end
  def winningest_coach(season_id) #best win percentage for the season)
    #season_coaches(season_id).max_by {|coach| coaches_by_win_percentage(season_id, coach) }
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

  ## Necessary helper methods for above result methods

  def season_coaches(season_id)
    game_teams_data_by_season(season_id).map { |game| game.head_coach }.uniq
  end

  def game_teams_data_by_season(season_id) # currently requires a string do we want to change to integers?
    @gtmd.data.find_all {|game| game.game_id[0..3] == season_id[0..3]}
  end
end

a = SeasonStatistics.new($game_team_manager_data)
binding.pry
