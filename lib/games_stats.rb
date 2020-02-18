require './lib/data_module'

class GamesStats
  include DataLoadable

  def initialize(games_path_param)
    @games_path = games_path_param
    @games = csv_data(@games_path)
  end

  def percentage_ties
    ties = @games.count do |game|
      game[:away_goals] == game[:home_goals]
    end

    (100 * ties.fdiv(@games.length)).round(2)
  end

  def count_of_games_by_season
    @games.reduce(Hash.new(0)) do |games_by_season, game|
      games_by_season[game[:season]] += 1
      games_by_season
    end
  end

  def percentage_visitor_wins
    vistor_wins = @games.find_all {|game| game[:away_goals] > game[:home_goals]}
    sum = (vistor_wins.length).to_f / (@games.length).to_f
    (100 * sum).round(2)
  end

  def average_goals_per_game
    all_goals = @games.sum {|game| game[:away_goals].to_i + game[:home_goals].to_i}
    sum = all_goals.to_f / @games.length
    sum.round(2)
  end

  def average_goals_by_season
    goals_per_season = {}
    @games.each do |game|
      if goals_per_season[game[:season]] == nil
        goals_per_season[game[:season]] = game[:away_goals].to_i + game[:home_goals].to_i
      else
        goals_per_season[game[:season]] += game[:away_goals].to_i + game[:home_goals].to_i
      end
    end
    count = count_of_games_by_season
    @games.reduce(Hash.new(0)) do |average_goals, game|
      average_goals[game[:season]] = (goals_per_season[game[:season]].to_f / count[game[:season]]).round(2)
      average_goals
    end
  end

end
