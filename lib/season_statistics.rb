require_relative "game_data"
require_relative "team_data"
require_relative "game_team_data"

class SeasonStatistics

  def initialize
    @coach_by_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @by_season_game_objects = []
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
    # Helper create_coach_by_team_id
    all_game_teams.each do |game_by_team|
      @coach_by_team_id[game_by_team.team_id] = game_by_team.head_coach
    end
    @coach_by_team_id

    # Helper for by-season collection
    all_games.each do |game_object|
      if season == game_object.season
        @by_season_game_objects << game_object
      end
    end
    @by_season_game_objects

    #Helper
    @counter_wins_team_id = Hash.new{ |hash, key| hash[key] = 0 }
    @by_season_game_objects.each do |season_game_object|
      if season_game_object.home_goals > season_game_object.away_goals
        @counter_wins_team_id[season_game_object.home_team_id] += 1
      elsif season_game_object.away_goals > season_game_object.home_goals
        @counter_wins_team_id[season_game_object.away_team_id] += 1
      end
    end
    @counter_wins_team_id

    
    require "pry"; binding.pry
  end



  def worst_coach(season)

  end

end
