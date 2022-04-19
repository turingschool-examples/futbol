require './required_files'

module LeagueModule

  def LeagueModule.average_visitor_scores(games_arr)
    away_team_goals_hash = {}
    games_arr.each do |game|
      away_team_goals_hash[game.away_team_id] = average_away_goals_per_team(game.away_team_id, games_arr)
    end
    away_team_goals_hash
  end

  def LeagueModule.average_away_goals_per_team(team_id, games_arr)
    goals = 0
    games = 0
    games_arr.each do |game|
      if game.away_team_id == team_id
        goals += game.away_goals
        games += 1
      end
    end
    goals / games.to_f
  end

  def LeagueModule.average_home_scores(games_arr)
		home_team_goals_hash = {}
		games_arr.each do |game|
			home_team_goals_hash[game.home_team_id] = average_home_goals_per_team(game.home_team_id, games_arr)
		end
		home_team_goals_hash
	end

	def LeagueModule.average_home_goals_per_team(team_id, games_arr)
		goals = 0
		games = 0
		games_arr.each do |game|
			if game.home_team_id == team_id
				goals += game.home_goals
				games += 1
			end
		end
		goals / games.to_f
	end

end
