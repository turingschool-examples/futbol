require 'csv'

class SeasonStats
  def self.from_csv(locations)
    SeasonStats.new(locations)
  end

  def initialize(locations)
    @locations = locations
    @games_teams_table = CSV.parse(File.read(@locations[:game_teams]), headers: true)
    @games_table = CSV.parse(File.read(@locations[:games]), headers: true)
    @teams_table = CSV.parse(File.read(@locations[:teams]), headers: true)
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

  def games_in_season(season)
    @games_teams_table.find_all do |game|
     game_ids_per_season[season].include?(game["game_id"])
    end
  end

  def games_per_coach(season)
    coaches_and_games = {}
    games_in_season(season).each do |game|
     if coaches_and_games[game["head_coach"]]
       coaches_and_games[game["head_coach"]] << game
     else coaches_and_games[game["head_coach"]] = [game]
     end
   end
   coaches_and_games
  end

  def count_coach_results(season)
    coaches_and_results = {}
    games_per_coach(season).map do |coach, games|
        coaches_and_results[coach] = games.count do |game|
        game["result"] == "WIN"
      end
    end
    coaches_and_results
  end

  def coach_percentage(season)
    coaches_and_percentages = {}
    wins = count_coach_results(season)
    wins.keys.map do |coach|
      coaches_and_percentages[coach] = wins[coach].to_f /
                                games_per_coach(season)[coach].count
    end
    coaches_and_percentages
  end

  def winningest_coach(season)
    coach = coach_percentage(season).max_by do |coach, percentage|
      percentage
    end
    coach[0]
  end

  def worst_coach(season)
    coach = coach_percentage(season).min_by do |coach, percentage|
      percentage
    end
    coach[0]
  end

  def team_scores(season, header)
    scores = {}
    games_in_season(season).each do |game|
      if scores[game["team_id"]]
        scores[game["team_id"]] += game[header].to_i
      else scores[game["team_id"]] = game[header].to_i
      end
    end
    scores
  end
end
