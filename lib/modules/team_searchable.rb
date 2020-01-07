
module TeamSearchable
	def count_of_teams
		teams.length
	end

  def highest_scoring_visitor
		teams.max_by(&:average_goals_away).team_name
  end

  def highest_scoring_home_team
		teams.max_by(&:average_goals_home).team_name
  end

  def lowest_scoring_visitor
    teams.min_by(&:average_goals_away).team_name
  end

  def lowest_scoring_home_team
		teams.min_by(&:average_goals_home).team_name
  end

  def best_offense
		teams.max_by(&:average_goals_total).team_name
  end

	def worst_offense
		teams.min_by(&:average_goals_total).team_name
	end

	def winningest_team
		teams.max_by(&:win_percent_total).team_name
	end

	def worst_fans
		worst_fan_teams = teams.find_all { |team| team.average_goals_away > team.average_goals_home}
		worst_fan_teams.map(&:team_name)
	end

	def best_fans
		teams.max_by { |team| (team.home_win_percentage - team.away_win_percentage)}.team_name
	end

	def best_defense
		teams.min_by(&:total_scores_against).team_name
	end

	def worst_defense
		teams.max_by(&:total_scores_against).team_name
  end

  def seasonal_summary(teamid)
    team = teams.find {|team| team.team_id.to_s == teamid}
    team.stats_by_season
  end

	# def all_games_played
	# 	all_games = []
	# 	@away_games.each {|game| all_games << game}
	# 	@home_games.each {|game| all_games << game}
	# 	end

	def most_goals_scored(teamid)
		team = teams.find {|team| team.team_id.to_s == teamid}
		most_goals = []
		most_goals << (team.away_games.max_by{|game| game.away_goals}).away_goals
		most_goals << (team.home_games.max_by{|game| game.home_goals}).home_goals
		return most_goals.max
	end

	def fewest_goals_scored(teamid)
		team = teams.find {|team| team.team_id.to_s == teamid}
		least_goals = []
		least_goals << (team.away_games.min_by{|game| game.away_goals}).away_goals
		least_goals << (team.home_games.min_by{|game| game.home_goals}).home_goals
		return least_goals.min
	end


  def team_info(teamid)
    team = teams.find {|team| team.team_id.to_s == teamid}
    team.team_info
  end

  def average_win_percentage(teamid)
    team = teams.find {|team| team.team_id.to_s == teamid}
    team.total_winning_percentage
  end

end
