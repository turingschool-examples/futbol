module LeagueStats
  
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
end



