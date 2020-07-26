require_relative "game_data"
require_relative "team_data"
require_relative "game_team_data"

class SeasonStatistics

  def initialize
  end

  def all_teams
    TeamData.create_objects
  end

  def all_games
    GameData.create_objects
  end

  def all_game_teams
    GameTeamData.create_objects
  end

  def winningest_coach(season)

  end

  def worst_coach(season)

  end

end
