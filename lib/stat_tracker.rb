
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

############season stats##############
  def winningest_coach(season)
    # review which games are in specified season
    games_in_season = @games.select do |game|
      game if game[:season].to_i == season
    end
    game_ids = games_in_season.map do |game|
      game[:game_id]
    end
    games = @game_teams.select do |game|
     game if game_ids.include?(game[:game_id])
    end
    wins = games.select do |game|
      game if game[:result] == "WIN"
    end
    coach_wins_hash = Hash.new(0.0)
    wins.each do |game|
      coach_wins_hash[game[:head_coach]] += 1.0
    end
    games_coached = Hash.new(0.0)
    games.each do |game|
      games_coached[game[:head_coach]] += 1.0
    end
    coach_wins_hash.each_key do |key|
      coach_wins_hash[key] = coach_wins_hash[key] / games_coached[key]
    end
    coach_wins_hash.key(coach_wins_hash.values.max)
    # require 'pry'; binding.pry
  end

  # def worst_coach
  #   #coach with fewest wins per total games (they particated in)
  #   coaches = @game_teams.map do |game|
  #     game[:head_coach]
  #   end
  # end
#########################################

end
