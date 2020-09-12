class GameManager
  attr_reader :game_data,
              :tracker

  def initialize(location, tracker)
    @game_data = game_stats(location)
    @tracker = tracker
  end

  def game_stats(location)
    rows = CSV.read(location, { encoding: 'UTF-8', headers: true, header_converters: :symbol})
    result = []
    rows.each do |game|
      game.delete(:venue)
      game.delete(:venue_link)
      result << Game.new(game, self)
    end
    result
  end

  def total_games
    @game_data.count
  end

  def get_all_scores_by_game_id
    game_data.map do |game|
      game.away_goals + game.home_goals
    end
  end

  def highest_total_score
    get_all_scores_by_game_id.max
  end

  def lowest_total_score
    get_all_scores_by_game_id.min
  end

  def percentage_home_wins
    (all_home_wins.count.to_f / total_games).round(2)
  end

  def all_home_wins
    @tracker.game_teams_manager.all_home_wins
  end

  def all_visitor_wins
    @tracker.game_teams_manager.all_visitor_wins
  end

  def percentage_visitor_wins
    (all_visitor_wins.count.to_f / total_games).round(2)
  end

  def count_of_ties
    @tracker.game_teams_manager.count_of_ties
  end

  def percentage_ties
    (count_of_ties.to_f / total_games).round(2)
  end

  def hash_of_seasons
    @game_data.group_by {|game| game.season}
  end

  def count_of_games_by_season
    hash = {}
    hash_of_seasons.each do |key, value|
      hash[key.to_s] = value.count
    end
    hash
  end

  def average_goals_per_game
    (get_all_scores_by_game_id.sum / total_games.to_f).round(2)
  end

  def average_goals_by_season
    hash = {}
    hash_of_seasons.each do |season, stat|
      goals_per_season = stat.map do |game|
        game.home_goals + game.away_goals
      end
      hash[season.to_s] = (goals_per_season.sum / stat.count.to_f).round(2)
    end
    hash
  end
end
