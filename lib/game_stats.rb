class GameStats
  attr_reader :game_collection,
              :game_team_collection,
              :team_collection

  def initialize(game_collection, game_team_collection, team_collection)
    @game_collection = game_collection
    @game_team_collection = game_team_collection
    @team_collection = team_collection
  end

  def highest_total_score
    sum_total_score = []
    @game_collection.games_array.each do |game|
      sum_total_score << game.away_goals.to_i + game.home_goals.to_i
    end
    sum_total_score.max
  end

  # def lowest_total_score
  #   sum_total_score = []
  #   games.each do |game|
  #     sum_total_score << game.away_goals.to_i + game.home_goals.to_i
  #   end
  #   sum_total_score.min
  # end
  #
  # def percentage_home_wins
  #   home_wins = []
  #   games.each do |game|
  #     home_wins << game if game.home_goals > game.away_goals
  #   end
  #   percentage_of_home_wins = home_wins.count.to_f / games.count.to_f * 100
  #   percentage_of_home_wins.round(2)
  # end
  #
  # def percentage_visitor_wins
  #   visitor_wins = []
  #   games.each do |game|
  #     visitor_wins << game if game.home_goals < game.away_goals
  #   end
  #   percentage_of_visitor_wins = visitor_wins.count.to_f / games.count.to_f * 100
  #   percentage_of_visitor_wins.round(2)
  # end
  #
  # def percentage_ties
  #   ties = []
  #   games.each do |game|
  #     ties << game if game.home_goals == game.away_goals
  #   end
  #   percentage_of_ties = ties.count.to_f / games.count.to_f * 100
  #   percentage_of_ties.round(2)
  # end
  #
  # def count_of_games_by_season
  #   games_by_season = @games.group_by do |game|
  #     game.season
  #   end
  #   games_by_season.transform_values do |game|
  #     game.length
  #   end
  # end
  #
  # def average_goals_per_game
  #   sum_total_score = 0
  #   games.each do |game|
  #     sum_total_score += game.away_goals.to_i + game.home_goals.to_i
  #   end
  #   average_goals_per_game = sum_total_score / (games.count * 2).to_f
  #   average_goals_per_game.round(2)
  # end
  #
  # def average_goals_by_season
  #   games_by_season = @games.group_by do |game|
  #     game.season
  #   end
  #   games_by_season.transform_values do |game|
  #     sum_total_score = 0
  #     game.each do |game|
  #       sum_total_score += game.away_goals.to_i + game.home_goals.to_i
  #     end
  #     average_goals_per_season = sum_total_score / (game.count * 2).to_f
  #     average_goals_per_season.round(2)
  #   end
  # end
end
