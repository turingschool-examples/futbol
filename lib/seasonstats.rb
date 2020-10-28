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
   coaches_and_games
  end

  def results_per_coach_per_season(season)
    coaches_and_results_per_season = {}
    games_per_coach.each do |coach, games|
      games.each do |game|
        if coaches_and_results_per_season[coach] && game_ids_per_season[season].include?(game["game_id"])
          coaches_and_results_per_season[coach] << game["result"]
        elsif game_ids_per_season[season].include?(game["game_id"])
          coaches_and_results_per_season[coach] = [game["result"]]
        end
      end
    end
  end

  def count_coach_results(season, result)
    coaches_and_results = {}
      results_per_coach_per_season.each do |coach, results|
        results.count do |item|
          item == result
        end
      end
    require "pry"; binding.pry
  end

  def winningest_coach(season)
    # require "pry"; binding.pry
    most_wins = count_coach_results(season, "WIN")

    #coach_wins(season, WIN)
    #coach_wins[key].
  end

end
