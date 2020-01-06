require 'csv'
require_relative 'game'
require_relative 'csvloadable'

class GamesCollection
  include CsvLoadable

  attr_reader :games

  def initialize(games_path)
    @games = create_games(games_path)
  end

  def create_games(games_path)
    create_instances(games_path, Game)
  end

  def average_goals_per_game
    goals_per_game = @games.map {|game| game.away_goals + game.home_goals}
    all_goals = goals_per_game.sum
    number_of_games = goals_per_game.length
    average_goals_per_game = all_goals / number_of_games.to_f
    average_goals_per_game.round(2)
  end

  def highest_total_score
    highest_total = @games.max_by { |game| game.away_goals + game.home_goals}
    highest_total.away_goals + highest_total.home_goals
  end

  def lowest_total_score
    lowest_total = @games.min_by { |game| game.away_goals + game.home_goals }
    lowest_total.away_goals + lowest_total.home_goals
  end

  def biggest_blowout
    blowout = @games.max_by { |game| (game.home_goals - game.away_goals).abs }
    (blowout.home_goals - blowout.away_goals).abs
  end

  def percentage_home_wins
    home_wins = @games.find_all { |game| game.home_goals > game.away_goals}
    (home_wins.length.to_f / @games.length.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.find_all { |game| game.away_goals > game.home_goals}
    (visitor_wins.length.to_f / @games.length.to_f).round(2)
  end

  def count_of_games_by_season
    games_per_season = Hash.new(0)
      games.each do |game|
        games_per_season[game.season] += 1
    end
    games_per_season
  end

  def percentage_ties
    ties = @games.find_all { |game| game.home_goals == game.away_goals}
    (ties.length.to_f / @games.length.to_f).round(2)
  end

  def average_goals_by_season
    season_to_game = games.reduce({}) do |acc, game|
    if acc[game.season] == nil
      acc[game.season] = []
      acc[game.season] << game
    else
      acc[game.season] << game
    end
    acc
  end

  avg_by_season = {}
  season_to_game.each do |season, games|
  avg_by_season[season] = ((games.map {|game| game.away_goals +
    game.home_goals}).sum / (games.map {|game| game.away_goals +
       game.home_goals}).length.to_f).round(2)
    end
  avg_by_season
  end

  def team_id_to_avg
    team_id_to_games = games.reduce({}) do |acc, game|
      if acc[game.home_team_id] == nil
        acc[game.home_team_id] = []
        acc[game.home_team_id] << game.home_goals
        if acc[game.away_team_id] == nil
          acc[game.away_team_id] = []
          acc[game.away_team_id] << game.away_goals
        else
          acc[game.away_team_id] << game.away_goals
        end
      else
        acc[game.home_team_id] << game.home_goals
        if acc[game.away_team_id] == nil
          acc[game.away_team_id] = []
          acc[game.away_team_id] << game.away_goals
        else
          acc[game.away_team_id] << game.away_goals
        end
      end
      acc
    end
    team_id_to_games.reduce({}) do |acc, id_and_games|
      id = id_and_games[0]
      avg = (id_and_games[1].sum) / (id_and_games[1].length).to_f
      acc[id] = [avg]
      acc
    end
  end

  def best_offence_id
    avg_hash = team_id_to_avg
    highest_avg = avg_hash.max_by {|k, v| v}
    highest_avg[0]
  end

  def worst_offence_id
    avg_hash = team_id_to_avg
    lowest_avg = avg_hash.min_by {|k, v| v}
    lowest_avg[0]
  end

  def reg_season_game_ids(season_id)
    @games.reduce([]) do |acc, game|
      if game.season == season_id && game.type == "Regular Season"
          acc << game.game_id
      end
      acc
    end
  end

  def post_season_game_ids(season_id)
    @games.reduce([]) do |acc, game|
      if game.season == season_id && game.type == "Postseason"
        acc << game.game_id
      end
      acc
    end
  end

  def winningest_coach_game_ids(season_id)
    @games.reduce([]) do |acc, game|
      if game.season == season_id
        acc << game.game_id
      end
      acc
    end
  end

  def best_season(teamid)
    seasons_result = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      if teamid.to_i == game.away_team_id
        result = "WIN" if game.away_goals > game.home_goals
        result = "LOSS" if game.away_goals < game.home_goals
        result = "TIE" if game.away_goals == game.home_goals
        seasons_result[game.season] << result

      elsif teamid.to_i == game.home_team_id
        result = "WIN" if game.home_goals > game.away_goals
        result = "LOSS" if game.home_goals < game.away_goals
        result = "TIE" if game.home_goals == game.away_goals
        "LOSS" if game.home_goals < game.away_goals
        seasons_result[game.season] << result
      end
    end
    seasons_to_winpercent = seasons_result.reduce({}) do |acc, (key, value)|
      avg = value.count("WIN") / value.length.to_f
      acc[key] = avg
      acc
    end
    top_season = seasons_to_winpercent.max_by {|seasonid, winpercentage| winpercentage}
    top_season[0]
  end

  def worst_season(teamid)
    seasons_result = Hash.new {|hash, key| hash[key] = []}
    games.each do |game|
      if teamid.to_i == game.away_team_id
        result = "WIN" if game.away_goals > game.home_goals
        result = "LOSS" if game.away_goals < game.home_goals
        result = "TIE" if game.away_goals == game.home_goals
        seasons_result[game.season] << result

      elsif teamid.to_i == game.home_team_id
        result = "WIN" if game.home_goals > game.away_goals
        result = "LOSS" if game.home_goals < game.away_goals
        result = "TIE" if game.home_goals == game.away_goals
        "LOSS" if game.home_goals < game.away_goals
        seasons_result[game.season] << result
      end
    end
    seasons_to_winpercent = seasons_result.reduce({}) do |acc, (key, value)|
      avg = value.count("WIN") / value.length.to_f
      acc[key] = avg
      acc
    end
    bottom_season = seasons_to_winpercent.min_by {|seasonid, winpercentage| winpercentage}
    bottom_season[0]
  end

  def average_win_percentage(teamid)
    results = []
    games.each do |game|
      if teamid.to_i == game.away_team_id
        result = "WIN" if game.away_goals > game.home_goals
        result = "LOSS" if game.away_goals < game.home_goals
        result = "TIE" if game.away_goals == game.home_goals
        results << result

      elsif teamid.to_i == game.home_team_id
        result = "WIN" if game.home_goals > game.away_goals
        result = "LOSS" if game.home_goals < game.away_goals
        result = "TIE" if game.home_goals == game.away_goals
        "LOSS" if game.home_goals < game.away_goals
        results << result
      end
    end
    avg = results.count("WIN") / results.length.to_f
    avg.round(2)
  end


end
# expect(@stat_tracker.average_win_percentage("6")).to eq 0.49

# average_win_percentage	Average win percentage of all games for a team.	Float
