module LeagueStats

  def count_of_teams
    creator.teams_hash.count
  end

  def best_offense
    total_goals_by_team = {}
    creator.games_hash.each_value do |game|
      total_goals_by_team[game.away_team_id.to_sym] ||= []
      total_goals_by_team[game.home_team_id.to_sym] ||= []
      total_goals_by_team[game.away_team_id.to_sym] << game.away_goals
      total_goals_by_team[game.home_team_id.to_sym] << game.home_goals
    end

    best_team_id = total_goals_by_team.max_by do |_,goals|
      goals.sum / goals.length
    end
    creator.teams_hash[best_team_id.first.to_s].team_name
  end

  def worst_offense
    total_goals_by_team = {}
    creator.games_hash.each_value do |game|
      total_goals_by_team[game.away_team_id.to_sym] ||= []
      total_goals_by_team[game.home_team_id.to_sym] ||= []
      total_goals_by_team[game.away_team_id.to_sym] << game.away_goals
      total_goals_by_team[game.home_team_id.to_sym] << game.home_goals
    end

    worst_team_id = total_goals_by_team.min_by do |_,goals|
      goals.sum / goals.length
    end
    creator.teams_hash[worst_team_id.first.to_s].team_name
  end

  def highest_scoring_visitor
    total_goals_by_team = {}
    creator.games_hash.each_value do |game|
      total_goals_by_team[game.away_team_id.to_sym] ||= []
      total_goals_by_team[game.away_team_id.to_sym] << game.away_goals
    end

    best_team_id = total_goals_by_team.max_by do |_,goals|
      goals.sum / goals.length
    end
    creator.teams_hash[best_team_id.first.to_s].team_name
  end

  def highest_scoring_home_team
    total_goals_by_team = {}
    creator.games_hash.each_value do |game|
      total_goals_by_team[game.home_team_id.to_sym] ||= []
      total_goals_by_team[game.home_team_id.to_sym] << game.home_goals
    end

    best_team_id = total_goals_by_team.max_by do |_,goals|
      goals.sum / goals.length
    end
    creator.teams_hash[best_team_id.first.to_s].team_name
  end

  def lowest_scoring_visitor
    total_goals_by_team = {}
    creator.games_hash.each_value do |game|
      total_goals_by_team[game.away_team_id.to_sym] ||= []
      total_goals_by_team[game.away_team_id.to_sym] << game.away_goals
    end

    worst_team_id = total_goals_by_team.min_by do |_,goals|
      goals.sum / goals.length
    end
    creator.teams_hash[worst_team_id.first.to_s].team_name
  end

  def lowest_scoring_home_team
    total_goals_by_team = {}
    creator.games_hash.each_value do |game|
      total_goals_by_team[game.home_team_id.to_sym] ||= []
      total_goals_by_team[game.home_team_id.to_sym] << game.home_goals
    end

    worst_team_id = total_goals_by_team.min_by do |_,goals|
      goals.sum / goals.length
    end
    creator.teams_hash[worst_team_id.first.to_s].team_name
  end
end