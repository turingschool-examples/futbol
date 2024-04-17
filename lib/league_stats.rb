

module LeagueStats
  def count_of_teams
    @teams.count
  end
  
  def best_offense
    team_averages_list.max_by {|key, value| value}.first
  end

  def worst_offense
    team_averages_list.min_by {|key, value| value}.first
  end
  
  def team_averages_list
    team_averages = {}
    @teams.each do |team|
      if total_games(team.team_id) != 0
        team_averages[team.team_name] = average_game_points(team.team_id)
      end
    end
    team_averages
  end

  def average_game_points(team_id)
    (total_points(team_id).to_f / total_games(team_id)).round(2)
  end

  def total_points(team_id)
    total = 0
    @games.each do |game|
      if game.home_team_id == team_id
        total += game.home_goals.to_i
      elsif game.away_team_id == team_id
        total += game.away_goals.to_i
      end
    end
    total
  end

  def total_games(team_id)
    total = 0
    @games.each do |game|
      if game.home_team_id == team_id || game.away_team_id == team_id
        total += 1
      end
    end
    total
  end

  def highest_scoring_visitor
    winner_id = visitor_averages.max_by {|key, value| value}.first
    team_id_to_name(winner_id)
  end
  
  def visitor_averages
    averages_list = {}
    visitor_team_scores.each do |key, value|
      averages_list[key] = (value.to_f / away_game_count(key)).round(2)
    end
    averages_list
  end
  
  def visitor_team_scores
    away_team_scores = Hash.new(0)
    @games.each do |game|
      away_team_scores[game.away_team_id] += game.away_goals.to_i
    end
    away_team_scores
  end
  
  def away_game_count(team_id)
    total = 0
    @games.each do |game|
      if game.away_team_id == team_id
        total += 1
      end
    end
    total
  end
  
  def highest_scoring_home_team
    winner_id = home_averages.max_by {|key, value| value}.first
    team_id_to_name(winner_id)
  end
  
  def home_averages
    averages_list = {}
    home_team_scores.each do |key, value|
      averages_list[key] = (value.to_f / home_game_count(key)).round(2)
    end
    averages_list
  end

  def home_team_scores
    home_team_scores = Hash.new(0)
    @games.each do |game|
      home_team_scores[game.home_team_id] += game.home_goals.to_i
    end
    home_team_scores
  end

  def home_game_count(team_id)
    total = 0
    @games.each do |game|
      if game.home_team_id == team_id
        total += 1
      end
    end
    total
  end

  def team_id_to_name(teams_id)
    @teams.find {|team| team.team_id == teams_id}.team_name
  end
end