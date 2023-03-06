require_relative 'stat_data'

class LeagueStats < StatData

  def initialize(locations)
    super(locations)
  end

  def count_of_teams
    @team_data.count
  end

  def best_offense
    team_info = all_game_teams.group_by(&:team_id)
    avg_team_goals = Hash.new(0)
    team_info.map do |team, games|
      all_goals = games.map {|game|game.goals}  
      team_avg_goals_per_game = avg_score_per_game(all_goals)
      avg_team_goals[team] = team_avg_goals_per_game
    end
      max_avg_goals = avg_team_goals.max_by do |team, avg_goals|
      avg_goals
    end
    team_name_by_id(max_avg_goals.first)
  end

  def worst_offense
    team_info = all_game_teams.group_by(&:team_id)
    avg_team_goals = Hash.new(0)
    team_info.map do |team, games|
      all_goals = games.map {|game|game.goals}  
      team_avg_goals_per_game = avg_score_per_game(all_goals)
      avg_team_goals[team] = team_avg_goals_per_game
    end
      min_avg_goals = avg_team_goals.min_by do |team, avg_goals|
      avg_goals
    end
    team_name_by_id(min_avg_goals.first)
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

  def team_name_by_id(team_id)
    all_teams.find { |team| team.team_id == team_id }.team_name
  end

  def avg_score_per_game(total_goals_array)
    total_goals_array.sum.fdiv(total_goals_array.count)
  end
end
