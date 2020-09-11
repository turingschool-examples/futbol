class Game
  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :manager,
              :game_data

  def initialize(game_data, manager)
    @manager      = manager
    @game_id      = game_data[:game_id].to_i
    @season       = game_data[:season].to_s
    @type         = game_data[:type]
    @date_time    = game_data[:date_time]
    @away_team_id = game_data[:away_team_id]
    @home_team_id = game_data[:home_team_id]
    @away_goals   = game_data[:away_goals].to_i
    @home_goals   = game_data[:home_goals].to_i
    @game_data    = game_data
  end
  #
  # def total_games
  #   @game_data.count
  # end
  #
  # def get_all_scores_by_game_id
  #   game_data.map do |game|
  #     game.away_goals + game.home_goals
  #   end
  # end
  #
  # def highest_total_score
  #   get_all_scores_by_game_id.max
  # end
  #
  # def lowest_total_score
  #   get_all_scores_by_game_id.min
  # end
  #
  # def percentage_home_wins
  #   (all_home_wins.count.to_f / total_games).round(2)
  # end
  #
  # def all_home_wins
  #   @manager.game_teams_stats.all_home_wins
  # end
  #
  # def all_visitor_wins
  #   @manager.game_teams_stats.all_visitor_wins
  # end
  #
  # def percentage_visitor_wins
  #   (all_visitor_wins.count.to_f / total_games).round(2)
  # end
  #
  # def count_of_ties
  #   @manager.game_teams_stats.count_of_ties
  # end
  #
  # def percentage_ties
  #   (count_of_ties.to_f / total_games).round(2)
  # end
  #
  # def hash_of_seasons
  #   @game_data.group_by {|game| game.season}
  # end
  #
  # def count_of_games_by_season
  #   hash = {}
  #   hash_of_seasons.each do |key, value|
  #     hash[key.to_s] = value.count
  #   end
  #   hash
  # end
  #
  # def average_goals_per_game
  #   (get_all_scores_by_game_id.sum / total_games.to_f).round(2)
  # end
  #
  # def average_goals_by_season
  #   hash = {}
  #   hash_of_seasons.each do |season, stat|
  #     goals_per_season = stat.map do |game|
  #       game.home_goals + game.away_goals
  #     end
  #     hash[season.to_s] = (goals_per_season.sum / stat.count.to_f).round(2)
  #   end
  #   hash
  # end
end
