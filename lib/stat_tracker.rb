
class StatTracker
  attr_reader :games, :teams, :game_teams, :home_goals, :away_goals, :season

  def initialize(locations)
    @games = CSV.read locations[:games], headers: true, header_converters: :symbol
    @teams = CSV.read locations[:teams], headers: true, header_converters: :symbol
    @game_teams = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
    @home_goals = []
    @away_goals = []
    @season = []
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    game_with_max = @games.max_by do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    return game_with_max[:away_goals].to_i + game_with_max[:home_goals].to_i
  end

  def lowest_total_score
    game_with_min = @games.min_by do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
    return game_with_min[:away_goals].to_i + game_with_min[:home_goals].to_i
  end

  def percentage_home_wins
    home_wins = @game_teams.count do |game|
      game[:hoa] == "home" && game[:result] == "WIN"
    end
    (home_wins.to_f / @game_teams.count.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @game_teams.count do |game|
      game[:hoa] == "away" && game[:result] == "WIN"
    end
    (visitor_wins.to_f / @game_teams.count.to_f).round(2)
  end

  def average_goals_per_game
    total_goals = @games.sum do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end.to_f/@games.count
    total_goals.round(2)
  end

  def average_goals_by_season
    h = Hash.new(0)
    count = Hash.new(0)
    @games.each do |row|
      h[row[:season]] += row[:home_goals].to_f + row[:away_goals].to_f
      count[row[:season]] += 1
    end
    h.each do |key, val|
      h[key] = (val/count[key]).round(2)
    end
    h
  end

  def tie
    @games.find_all do |game|
      game[:home_goals] == game[:away_goals]
    end
  end

  def percentage_ties
    (tie.count.to_f / games.count * 100).round(3)
  end

  def sum_of_games_in_season(season_number)
    season_games = @games.select do |row|
      row[:season] == season_number
    end
    season_games.count
  end

  def count_of_games_by_season
    new_hash = {}
    keys = games.map do |row|
      row[:season]
    end.flatten.uniq

    keys.each do |key|
      new_hash[key] = sum_of_games_in_season(key)
    end
    new_hash
  end

end
