

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

  def LeagueModule.get_team_goals(game_teams_arr)
    team_goals = {}
		game_teams_arr.each do |game|
			team = game.team_id
			if team_goals[team] == nil
				team_goals[team] = [game.goals.to_f]
			else
				team_goals[team] << game.goals.to_f
			end
    end
    team_goals
  end

  def LeagueModule.goals_average(team_goals)
    avg_goals = {}
		team_goals.each do |team, goals|
			avg_goals[team] = (goals.sum / goals.size).ceil(2)
		end
    avg_goals
  end

  def LeagueModule.team_names(teams_arr)
    team_names = {}
    teams_arr.each do |team|
      team_names[team.team_id] = team.team_name
    end
    team_names
  end

  def LeagueModule.id_to_name(avg_goals, name_of_teams)#team_names
    avg_goals.keys.each do |key|
      name_of_teams.each do |id, name| #team_names
        if id == key
          avg_goals[name] = avg_goals[key]
          avg_goals.delete(key)
        end
      end
    end
    avg_goals
  end

  def LeagueModule.max_avg_goals(avg_goals)
    max_avg = avg_goals.values.max
    max_team = avg_goals.select{|team, goals| goals == max_avg}
    return max_team.keys[0]
    require "pry";binding.pry
  end

  def LeagueModule.min_avg_goals(avg_goals)
    min_avg = avg_goals.values.min
    min_team = avg_goals.select{|team, goals| goals == min_avg}
    min_team.keys[0]
  end

  def LeagueModule.total_team_count(teams_arr)
    total_teams = []
    teams_arr.each do |team|
      total_teams << team.team_id
    end
    total_teams
  end

  def LeagueModule.goals_scored(team_id, game_teams_arr)
    team_number = game_teams_arr.find_all{|game_team| game_team.team_id.to_i == team_id}
		team_goals = {}
		team_number.each do |game|
			if team_goals[game.team_id] == nil
				team_goals[game.team_id] = [game.goals.to_i]
			else
				team_goals[game.team_id] << game.goals.to_i
			end
		end
		team_goals.values.flatten!
  end

  def LeagueModule.team_name_by_id(team_id, teams)
    name = ""
    teams.find_all do |team|
      if team.team_id == team_id
         name << team.team_name
      end
    end
    name
  end


end
