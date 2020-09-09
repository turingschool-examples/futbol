class SeasonStatistics
  attr_reader :game_data,
              :game_teams_data,
              :teams_data

  def initialize(array_game_data, array_game_teams_data, array_teams_data)
    @game_data = array_game_data
    @game_teams_data = array_game_teams_data
    @teams_data = array_teams_data
  end

  def hash_of_seasons #refactor: move to module
    @game_teams_data.group_by do |game|
      game[:result] == "WIN"
    end
  end

  def winningest_coach(season)
    require "pry"; binding.pry
  end
end
