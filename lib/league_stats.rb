module LeagueStats
  def count_of_teams
    @teams.length
  end

  def best_offense # mm
    team_id_goals_hash = Hash.new { |h, k| h[k] = [] }
    game_teams_hash_elements = @game_teams.map(&:to_h)
    game_teams_hash_elements.each do |x|
      team_id_goals_hash[x[:team_id]] << x[:goals].to_i
    end
    team_id_goals_hash.map do |k,v|
      team_id_goals_hash[k] = (v.sum / v.length.to_f).round(2)
    end
    @teams.find { |x| x.fetch(:team_id) == team_id_goals_hash.max_by { |k,v| v }.first }[:teamname]
  end

  def worst_offense # mm
    team_id_goals_hash = Hash.new { |h, k| h[k] = [] }
    game_teams_hash_elements = @game_teams.map(&:to_h)
    game_teams_hash_elements.each do |x|
      team_id_goals_hash[x[:team_id]] << x[:goals].to_i
    end
    team_id_goals_hash.map do |k,v|
      team_id_goals_hash[k] = (v.sum / v.length.to_f).round(2)
    end
    @teams.find { |x| x.fetch(:team_id) == team_id_goals_hash.min_by { |k,v| v }.first }[:teamname]
  end

  def home_team_score
    home_team_score = Hash.new(0)
    home_team_count = Hash.new(0)
    @games.map do |game|
      home_team_score[game[:home_team_id]] += game[:home_goals].to_i
      home_team_count[game[:home_team_id]] += 1
    end
    home_score_average = home_team_score.map { |id, score| {id => (score.to_f / home_team_count[id].to_f).round(2)} }
    home_score_hash = {}
    home_score_average.map { |average| home_score_hash[average.keys[0]] = average.values[0] }
    home_score_hash
  end

  def away_team_score
    away_team_score = Hash.new(0)
    away_team_count = Hash.new(0)
    @games.each do |game|
      away_team_score[game[:away_team_id]] += game[:away_goals].to_i
      away_team_count[game[:away_team_id]] += 1
    end
    away_score_average = away_team_score.map { |id, score| {id => (score.to_f / away_team_count[id].to_f).round(2)} }
    away_score_hash = {}
    away_score_average.map { |average| away_score_hash[average.keys[0]] = average.values[0] }
    away_score_hash
  end

  def highest_scoring_visitor
    away_score = away_team_score
    team_id_highest_average = away_score.key(away_score.values.max)
    @teams.find { |team| team[:team_id] == team_id_highest_average }[:teamname]
  end

  def lowest_scoring_visitor
    away_score = away_team_score
    team_id_lowest_average = away_score.key(away_score.values.min)
    @teams.find { |team| team[:team_id] == team_id_lowest_average }[:teamname]
  end

  def highest_scoring_home_team
    home_score = home_team_score
    team_id_highest_average = home_score.key(home_score.values.max)
    @teams.find { |team| team[:team_id] == team_id_highest_average }[:teamname]
  end

  def lowest_scoring_home_team
    home_score = home_team_score
    team_id_lowest_average = home_score.key(home_score.values.min)
    team_lowest_average = @teams.find { |team| team[:team_id] == team_id_lowest_average }[:teamname]
  end
end