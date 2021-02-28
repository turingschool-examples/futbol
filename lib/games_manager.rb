require_relative './game'

class GamesManager
  attr_reader :data_path, :games

  def initialize(data_path)
    @games = generate_list(data_path)
  end

  def generate_list(data_path)
    list_of_data = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      list_of_data << Game.new(row)
    end
    list_of_data
  end

  def home_and_away_goals_sum
    games.map do |game|
      game.away_goals + game.home_goals
    end
  end

  def highest_total_score
    home_and_away_goals_sum.max
  end

  def lowest_total_score
    home_and_away_goals_sum.min
  end

  def percentage_home_wins
    home_wins = 0.0
    games.each do |game|
      home_wins += 1 if game.away_goals < game.home_goals
    end
    (home_wins/games.count).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0.0
    games.each do |game|
      visitor_wins += 1 if game.away_goals > game.home_goals
    end
    (visitor_wins/games.count).round(2)
  end

  def percentage_ties
    ties = 0.0
    games.each do |game|
      ties += 1 if game.away_goals == game.home_goals
    end
    (ties/games.count).round(2)
  end

  def count_of_games_by_season
    games_in_season = Hash.new
    games.each do |game|
      if games_in_season[game.season].nil?
        games_in_season[game.season] = 1
      else
        games_in_season[game.season] += 1
      end
    end
    games_in_season
  end

  def average_goals_per_game
    total_goals = games.sum do |game|
      game.away_goals + game.home_goals
    end.to_f
    (total_goals / games.count).round(2)
  end

  def average_goals_by_season
    goals_in_season = Hash.new
    games.each do |game|
      if goals_in_season[game.season].nil?
        goals_in_season[game.season] = (game.away_goals + game.home_goals)
      else
        goals_in_season[game.season] += (game.away_goals + game.home_goals)
      end
    end

    count_of_games_by_season.merge(goals_in_season) do |season, games, goals|
      (goals/games.to_f).round(2)
    end
  end

  def get_season_results(team_id)
    summary = {}
    @games.each do |game|
      if team_id == game.away_team_id || team_id == game.home_team_id
        summary[game.season] = [] if summary[game.season].nil?
        if team_id == game.home_team_id && game.home_goals > game.away_goals
          result = "W"
        elsif team_id == game.away_team_id && game.home_goals < game.away_goals
          result = "W"
        elsif game.home_goals == game.away_goals
          result = "T"
        else
          result = "L"
        end
        summary[game.season] << result
      end
    end
    summary
  end

  def best_season(team_id)
    most = 0
    best = nil
    get_season_results(team_id).each do |key, value|   #refactor-able? #I think we can use .valuses.max/.min
      if value.count('W').to_f / value.size > most
        most = value.count('W').to_f / value.size
        best = key
      end
    end
    best
  end

  def worst_season(team_id)
    least = 1
    worst = nil
    get_season_results(team_id).each do |key, value|   #refactor-able?
      if value.count('W').to_f / value.size < least
        least = value.count('W').to_f / value.size
        worst = key
      end
    end
    worst
  end

  def average_win_percentage(team_id)
    wins = 0
    all = 0
    get_season_results(team_id).each do |key, value|   #refactor-able?
      wins += value.count("W")
      all += value.count
    end
    (wins.to_f/all).round(2)    #leave as decimal to 0.00 like previous
  end

  def get_goals_scored(team_id)
    scored = []
    @games.each do |game|       #probably refactor-able
      if team_id == game.away_team_id || team_id == game.home_team_id
        if team_id == game.home_team_id
          scored << game.home_goals
        elsif team_id == game.away_team_id
          scored << game.away_goals
        end
      end
    end
    scored
  end

  def most_goals_scored(team_id)
    get_goals_scored(team_id).max_by {|score|score.to_i}
  end

  def fewest_goals_scored(team_id)
    get_goals_scored(team_id).min_by {|score|score.to_i}
  end

  def get_season_games(season)
    season_games = @games.find_all do |game|
      game.season == season
    end
    season_games.map do |game|
      game.game_id
    end
  end

  def total_home_goals
    home_team_id_goals = {}
    games.each do |game|
      if home_team_id_goals[game.home_team_id].nil?
        home_team_id_goals[game.home_team_id] = game.home_goals
      else
        home_team_id_goals[game.home_team_id] += game.home_goals
      end
    end
    home_team_id_goals
  end

  def total_home_games
    home_team_id_games = {}
    games.each do |game|
      if home_team_id_games[game.home_team_id].nil?
        home_team_id_games[game.home_team_id] = 1
      else
        home_team_id_games[game.home_team_id] += 1
      end
    end
    home_team_id_games
  end

  def highest_scoring_home
    averages = total_home_goals.merge(total_home_games) do |team_id, goals, games|
      (goals/games.to_f).round(2)
    end
    average_max = averages.max_by do |team_id, average|
      average
    end
     average_max[0]
  end

  def total_away_goals
    visitor_team_id_goals = {}
    games.each do |game|
      if visitor_team_id_goals[game.away_team_id].nil?
        visitor_team_id_goals[game.away_team_id] = game.away_goals
      else
        visitor_team_id_goals[game.away_team_id] += game.away_goals
      end
    end
    visitor_team_id_goals
  end

  def total_away_games
    visitor_team_id_games = {}
    games.each do |game|
      if visitor_team_id_games[game.away_team_id].nil?
        visitor_team_id_games[game.away_team_id] = 1
      else
        visitor_team_id_games[game.away_team_id] += 1
      end
    end
    visitor_team_id_games
  end

  def highest_scoring_visitor
    averages = total_away_goals.merge(total_away_games) do |team_id, goals, games|
      (goals/games.to_f).round(2)
    end
    average_max = averages.max_by do |team_id, average|
      average
    end
     average_max[0]
  end

  def lowest_scoring_visitor
    averages = total_away_goals.merge(total_away_games) do |team_id, goals, games|
      (goals/games.to_f).round(2)
    end
    average_min = averages.min_by do |team_id, average|
      average
    end
     average_min[0]
  end

  def lowest_scoring_home
      averages = total_home_goals.merge(total_home_games) do |team_id, goals, games|
      (goals/games.to_f).round(2)
    end
      average_min = averages.min_by do |team_id, average|
      average
    end
      average_min[0]
  end
end 
  