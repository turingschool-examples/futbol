require 'csv'

class SeasonStats
  def self.from_csv(locations)
    SeasonStats.new(locations)
  end

  def initialize(locations)
    @locations = locations
    @games_teams_table = CSV.parse(File.read(@locations[:game_teams]), headers: true)
    @games_table = CSV.parse(File.read(@locations[:games]), headers: true)
  end

  def game_ids_per_season
    seasons_and_games = {}
    @games_table.each do |game|
      if seasons_and_games[game["season"]]
        seasons_and_games[game["season"]] << game["game_id"]
      else seasons_and_games[game["season"]] = [game["game_id"]]
      end
    end
    seasons_and_games
  end

  def games_per_coach
    coaches_and_games = {}
    @games_teams_table.each do |game|
     if coaches_and_games[game["head_coach"]]
       coaches_and_games[game["head_coach"]] << game
     else coaches_and_games[game["head_coach"]] = [game]
     end
   end
  end


  def count_coach_results(season, result)
    coaches_and_games = {}
    game_ids_per_season[season].each do |game_id|
      @games_teams_table.each do |game|
      if coaches_and_games[game["head_coach"]] && (game["game_id"] == game_id) && (game["result"] == result)
        coaches_and_games[game["head_coach"]] += 1
      else (game["game_id"] == game_id) && (game["result"] == result)
        coaches_and_games[game["head_coach"]] = 1
      end
      end
    end
    require "pry"; binding.pry
  end

  def winningest_coach(season)
    count_coach_results(season, "WIN")
    #coach_wins(season, WIN)
    #coach_wins[key].
  end

end
