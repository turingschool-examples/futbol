class GameStatistics
  attr_reader :game_data,
              :game_teams_data

  def initialize(array_game_data, array_game_teams_data)
    @game_data = array_game_data
    @game_teams_data = array_game_teams_data
  end

  def total_games
    @game_data.count
  end

  def get_all_scores_by_game_id
    game_data.flat_map do |game|
      game[:away_goals] + game[:home_goals]
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
    @game_teams_data.select do |game|
      game[:hoa] == "home" && game[:result] == "WIN"
    end
  end

  def percentage_visitor_wins
    (all_visitor_wins.count.to_f / total_games).round(2)
  end

  def all_visitor_wins
    @game_teams_data.select do |game|
      game[:hoa] == "away" && game[:result] == "WIN"
    end
  end

  def count_of_ties
    double_ties = @game_teams_data.find_all do |game|
      game[:result] == "TIE"
    end
    double_ties.count / 2
  end

  def percentage_ties
    (count_of_ties.to_f / total_games).round(2)
  end

  def hash_of_seasons
    @game_data.group_by do |game|
      game[:season]
    end
  end

  def count_of_games_by_season
    hash = {}
    hash_of_seasons.each do |key, value|
      hash[key.to_s] = value.count
    end
    hash
  end
end
