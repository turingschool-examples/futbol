require_relative 'stat_data'

class GameStats < StatData

  def initialize(locations)
    super(locations)
  end

  def highest_total_score
    # super(all_games)
   all_games.map do |game|
      game.total_score
    end.max
  end

  def lowest_total_score
    all_games.map do |game|
      game.total_score
    end.min
  end

  def highest_scoring_home_team
    team_info = all_games.group_by(&:home_id)
    team_avg_score = Hash.new(0)
    team_info.map do |team, games|
      total_score = games.map {|game|game.home_goals}
      avg_score_per_game = avg_score_per_game(total_score)
      team_avg_score[team] = avg_score_per_game
    end
      max_avg_score = team_avg_score.max_by do |team, avg_score|
        avg_score
      end
      team_name_by_id(max_avg_score.first)
  end

  def lowest_scoring_home_team
    team_info = all_games.group_by(&:home_id)
    team_avg_score = Hash.new(0)
    team_info.map do |team, games|
      total_score = games.map {|game|game.home_goals}
      avg_score_per_game = avg_score_per_game(total_score)
      team_avg_score[team] = avg_score_per_game
    end
      min_avg_score = team_avg_score.min_by do |team, avg_score|
        avg_score
      end
      team_name_by_id(min_avg_score.first)
   end
  
  def highest_scoring_visitor
    team_info = all_games.group_by(&:away_id)
    avg_score = Hash.new(0)
    team_info.map do |team, games|
      total_score = games.map do |game|
        game.away_goals
      end
      avg_score_per_game = total_score.sum.fdiv(total_score.count)
      avg_score[team] = avg_score_per_game
    end
    max_avg_score = avg_score.max_by do |_, avg_scores|
      avg_scores
    end
    team_name_by_id(max_avg_score.first)
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
end
