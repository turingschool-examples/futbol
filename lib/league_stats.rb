module LeagueStats
  include GameStats

  def count_of_teams 
    @teams.count
  end

  def lowest_scoring_visitor
    away_games_by_team = Hash.new { |hash, key| hash[key] = { goals: 0, games: 0 } }
    
    @games.each do |game|
      away_games_by_team[game.away_team_id][:goals] += game.away_goals
      away_games_by_team[game.away_team_id][:games] += 1
    end
    
    lowest_avg_team = away_games_by_team.min_by { |_, stats| stats[:goals].to_f / stats[:games] }
    @teams.find { |team| team.team_id == lowest_avg_team.first }.team_name
  end

  # helper methods to combine code? A lot of repeating
  
  def lowest_scoring_home_team
    home_games_by_team = Hash.new { |hash, key| hash[key] = { goals: 0, games: 0 } }
    
    @games.each do |game|
      home_games_by_team[game.home_team_id][:goals] += game.home_goals
      home_games_by_team[game.home_team_id][:games] += 1
    end
    
    lowest_avg_team = home_games_by_team.min_by { |_, stats| stats[:goals].to_f / stats[:games] }
    @teams.find { |team| team.team_id == lowest_avg_team.first }.team_name
  end

  def highest_scoring_visitor
    grouped_teams = @game_teams.group_by { |game| game.team_id }
    sorted_teams = filter_away_games(grouped_teams)
    avg_game = avg_score_away_games(sorted_teams)
    highest_scoring_visitor_array = avg_game.max_by { |team, avg_score| avg_score }
    id_string = highest_scoring_visitor_array[0]
    high_team = " "
    @teams.each { |team| high_team = team.team_name if team.team_id == id_string } 
    high_team 
  end 

  def highest_scoring_home_team
    grouped_teams = @game_teams.group_by { |game| game.team_id }
    sorted_teams = filter_home_games(grouped_teams)
    avg_game = avg_score_away_games(sorted_teams)
    highest_scoring_home_array = avg_game.max_by { |team, avg_score| avg_score }
    id_string = highest_scoring_home_array[0]
    high_team = " "
    @teams.each { |team| high_team = team.team_name if team.team_id == id_string } 
    high_team 
  end

  def best_offense
    best_offense = calculate_average_goals(@game_teams)
    team_id_string = best_offense.max_by { |team, avg_goals| avg_goals }&.first
    best_team = @teams.find { |team| team.team_id == team_id_string }
    best_team&.team_name || ""
    end
  
    def worst_offense
    worst_offense = calculate_average_goals(@game_teams)
    team_id_string = worst_offense.min_by { |team, avg_goals| avg_goals }&.first
    worst_team = @teams.find { |team| team.team_id == team_id_string }
    worst_team&.team_name || ""
  end

  #helper methods for highest scoring team
  def avg_score_away_games(sorted_teams)
    sorted_teams.transform_values do |games|
      goals = games.sum{ |game| game.goals }
      goals.fdiv(games.length)
    end
  end

  def filter_away_games(sorted_teams)
    sorted_teams.transform_values do |games|
      games.select{ |game| game.hoa == "away" }
    end
  end

  def filter_home_games(sorted_teams)
    sorted_teams.transform_values do |games|
      games.select{ |game| game.hoa == "home" }
    end
  end

  def calculate_average_goals(game_teams)
    average_goals = Hash.new(0)
    game_teams.each do |game_team|
      team_id = game_team.team_id
      total_goals = game_teams.select { |game_team| game_team.team_id == team_id }.sum(&:goals)
      total_games = game_teams.count { |game_team| game_team.team_id == team_id }
      average_goals[team_id] = total_goals.fdiv(total_games)
    end
    average_goals
  end
end