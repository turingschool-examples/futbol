module Calculatable
  def highest_total_score
    @game_stats_data.highest_total_score
  end

  def lowest_total_score
    @game_stats_data.lowest_total_score
  end

  def percentage_home_wins
    @game_stats_data.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats_data.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats_data.percentage_ties
  end

  def count_of_games_by_season
    @game_stats_data.count_of_games_by_season
  end

  def average_goals_per_game
    @game_stats_data.average_goals_per_game
  end

  def average_goals_by_season
    @game_stats_data.average_goals_by_season
  end

  def average_win_percentage(team_id)
    @team_stats.all_team_games(team_id)
    @team_stats.total_wins(team_id)
    @team_stats.average_win_percentage(team_id)
  end
end
