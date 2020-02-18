require './lib/data_module'

class GamesStats
  include DataLoadable

  def initialize(games_path_param)
    @games_path = games_path_param

  end

  def percentage_ties
    games = csv_data(@games_path)

    ties = games.count do |game|
      game[:away_goals] == game[:home_goals]
    end

    (100 * ties.fdiv(games.length)).round(2)
  end

  def count_of_games_by_season
    csv_data(@games_path).reduce(Hash.new(0)) do |games_by_season, game|
      games_by_season[game[:season]] += 1
      games_by_season
    end
  end

  def percentage_visitor_wins
    games = csv_data(@games_path)
    vistor_wins = games.find_all {|game| game[:away_goals] > game[:home_goals]}
    sum = (vistor_wins.length).to_f / (games.length).to_f
    (100 * sum).round(2)
  end

  def average_goals_per_game
    games = csv_data(@games_path)
    all_goals = games.sum {|game| game[:away_goals].to_i + game[:home_goals].to_i}
    sum = all_goals.to_f / games.length
    sum.round(2)
  end

end
