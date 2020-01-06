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
    # Create a hash that matches, for each game, the team id to the matching goals
    # If the team id shows up more than once, then its goals for that new game
    # are added to the hash key created for it. This should give us for each team,
    # the total amount of goals they made for all games.
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
    # Create a hash that matches each team_id to their goal average (total
    # amount of goals divided by the number of games they played)
    team_id_to_games.reduce({}) do |acc, id_and_games|
      id = id_and_games[0]
      avg = (id_and_games[1].sum) / (id_and_games[1].length).to_f
      acc[id] = [avg]
      acc
    end
  end

  def best_offense_id
    avg_hash = team_id_to_avg
    #Find team_id with highest average goals
    highest_avg = avg_hash.max_by {|k, v| v}
    #pull that team's id
    highest_avg[0]
  end

  def worst_offense_id
    avg_hash = team_id_to_avg
    lowest_avg = avg_hash.min_by {|k, v| v}
    lowest_avg[0]
  end

  def reg_season_game_ids(season_id)
    #create array with regular season game ids to be used in game_teams_collection
    @games.reduce([]) do |acc, game|
      if game.season == season_id && game.type == "Regular Season"
          acc << game.game_id
      end
      acc
    end
  end

  def post_season_game_ids(season_id)
    #create array with postseason game ids to be used in game_teams_collection
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

  def average_goals_scored_by_opposite_team
    id_associate= games.reduce({}) do |acc, game|
      if acc.has_key?(game.home_team_id) == false
        acc[game.home_team_id] = []
      end
      acc[game.home_team_id] << game.away_goals.to_f.round(2)
      if acc.has_key?(game.away_team_id) == false
        acc[game.away_team_id] = []
      end
      acc[game.away_team_id] << game.home_goals.to_f.round(2)
      acc
    end
    id_associate.reduce({}) do |acc, id_goals|
      id = id_goals.first
      goal_average = (id_goals.last.sum / id_goals.last.length).to_f.round(2)
      acc[id] = [goal_average]
      acc
    end
  end

  def best_defense_id
    best_d = average_goals_scored_by_opposite_team.min_by { |team_id, goals| goals }
    best_d.first
  end

  def worst_defense_id
    worst_d = average_goals_scored_by_opposite_team.max_by { |team_id, goals| goals }
    worst_d.first
  end
end
