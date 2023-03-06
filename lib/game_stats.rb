require_relative 'stat_data'

class GameStats < StatData

  def initialize(locations)
    super(locations)
  end

  def avg_score_per_game(total_goals_array)
    total_goals_array.sum.fdiv(total_goals_array.count)
  end

  def team_name_by_id(team_id)
    all_teams.find { |team| team.team_id == team_id }.team_name
  end

  def highest_total_score
   all_games.map do |game|
      game.total_score
    end.max
  end

  def lowest_total_score
    all_games.map do |game|
      game.total_score
    end.min
  end

  def percentage_home_wins
    team_wins = all_game_teams.select do |team|
      team.result == 'WIN' && team.home_or_away == 'home'
    end
    home_games = all_game_teams.select do |game|
      game.home_or_away == 'home'
    end
    (team_wins.count / home_games.count.to_f).round(2)
  end
  
  def percentage_visitor_wins
    team_wins = all_game_teams.select do |team|
      team.result == 'WIN' && team.home_or_away == 'away'
    end
    away_games = all_game_teams.select do |game|
      game.home_or_away == 'away'
    end
    (team_wins.count / away_games.count.to_f).round(2)
  end
    
  def percentage_ties
    (1.0 - percentage_home_wins - percentage_visitor_wins).round(2)
  end

  def lowest_scoring_visitor
    team_info = all_games.group_by(&:away_id)
    avg_score = Hash.new(0)
    team_info.map do |team, games|
      total_score = games.map do |game|
        game.away_goals
      end
      avg_score_per_game = total_score.sum.fdiv(total_score.count)
      avg_score[team] = avg_score_per_game
    end
    min_avg_score = avg_score.min_by do |_, avg_scores|
      avg_scores
    end
    team_name_by_id(min_avg_score.first)
  end

  def count_of_games_by_season
    games_by_season.transform_values{|value| value.count} 
  end

  def average_goals_by_season
    games_by_season.transform_values do |games_array|
      scores_array = games_array.map(&:total_score)
      (scores_array.sum.to_f / scores_array.length).round(2)
    end
  end
end
