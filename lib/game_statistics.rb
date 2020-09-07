class GameStatistics
  attr_reader :game_data,
              :game_teams_data

  def initialize(array_game_data, array_game_teams_data)
    @game_data = array_game_data
    @game_teams_data = array_game_teams_data
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
    (all_home_wins.count.to_f / @game_data.count).round(2)
  end

  def all_home_wins
    @game_teams_data.select do |game|
      game[:hoa] == "home" && game[:result] == "WIN"
    end
  end

  def percentage_visitor_wins
    (all_visitor_wins.count.to_f / @game_data.count).round(2)
  end

  def all_visitor_wins
    @game_teams_data.select do |game|
      game[:hoa] == "away" && game[:result] == "WIN"
    end
  end
end
