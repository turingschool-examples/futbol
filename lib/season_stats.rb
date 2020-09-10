class SeasonStatistics
  attr_reader :game_data,
              :game_teams_data,
              :teams_data

  def initialize(array_game_data, array_game_teams_data, array_teams_data)
    @game_data = array_game_data
    @game_teams_data = array_game_teams_data
    @teams_data = array_teams_data
  end

  def hash_of_seasons(season) #refactor: move to module
    @game_teams_data.find_all do |game_team|
      game_team[:game_id].to_s.split("")[0..3].join.to_i == season.split("")[0..3].join.to_i
    end
  end
    
  def winningest_coach(season)
    require "pry"; binding.pry
  end
end
