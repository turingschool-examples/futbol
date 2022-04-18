require './required_files'

class StatTracker
include GameModule
	attr_reader :games, :teams, :game_teams

	def initialize(games_hash, teams_hash, game_teams_hash)
		@games = create_games(games_hash)
		@teams = create_teams(teams_hash)
		@game_teams = create_game_teams(game_teams_hash)
	end

	def self.from_csv(locations)
	 games_hash = CSV.open(locations[:games], headers: true, header_converters: :symbol)
	 teams_hash = CSV.open(locations[:teams], headers: true, header_converters: :symbol)
	 game_teams_hash = CSV.open(locations[:game_teams], headers: true, header_converters: :symbol)
	 stat_tracker1 = self.new(games_hash, teams_hash, game_teams_hash)
	end

	def create_teams(teams)
		team_arr = Array.new
		teams.each do |row|
			team_id = row[:team_id].to_i
			franchise_id = row[:franchiseid]
			team_name = row[:teamname]
			abbreviation = row[:abbreviation]
			stadium = row[:stadium]
			link = row[:link]
			team_arr << Team.new(team_id, franchise_id, team_name, abbreviation, stadium, link)
		end
		return team_arr
	end

	def create_games(games)
		game_arr = []
		games.each do |row|
			game_id = row[:game_id]
			season = row[:season]
			type = row[:type]
			date_time = row[:date_time]
			away_team_id = row[:away_team_id]
			home_team_id = row[:home_team_id]
			away_goals = row[:away_goals].to_i
			home_goals = row[:home_goals].to_i
			venue = row[:venue]
			venue_link = row[:venue_link]
			game_arr << Game.new(game_id, season, type, date_time, away_team_id, home_team_id,
				away_goals, home_goals, venue, venue_link)
		end
		return game_arr
	end

  def create_game_teams(game_teams)
    game_team_array = []
    game_teams.each do |row|
      game_id = row[:game_id]
      team_id = row[:team_id].to_i
      hoa = row[:hoa]
      result = row[:result]
      settled_in = row[:settled_in]
      head_coach = row[:head_coach]
      goals = row[:goals].to_i
      shots = row[:shots].to_i
      tackles = row[:tackles]
      pim = row[:pim]
      power_play_opportunities = row[:powerplayopportunities]
      power_play_goals = row[:powerplaygoals]
      face_off_win_percentage = row[:faceoffwinpercentage]
      giveaways = row[:giveaways]
      takeaways = row[:takeaways]
      # binding.pry
      game_team_array << GameTeam.new(game_id,team_id,hoa,result,settled_in,head_coach,goals,shots,tackles,pim,power_play_opportunities,power_play_goals,face_off_win_percentage,giveaways,takeaways)
    end
    return game_team_array
  end

	def game_count
		@games.count
	end

	def highest_total_score
		GameModule.total_score(@games).max
	end


	def lowest_total_score
		GameModule.total_score(@games).min
	end

	def percentage_visitor_wins
		return ((GameModule.total_visitor_wins(@games).count).to_f / (@games.count).to_f) * 100
	end

	def percentage_home_wins
		return ((GameModule.total_home_wins(@games).count).to_f / game_count.to_f) * 100
	end

	def average_goals_per_game
		(GameModule.total_score(@games).sum.to_f / game_count).ceil(2)
	end

	def average_goals_per_season
		season_goals_avg = {}
		@games.each do |game|
			season = game.season
			if season_goals_avg[season] == nil
				season_goals_avg[season] = [game.away_goals + game.home_goals]
			else
				season_goals_avg[season] << game.away_goals + game.home_goals
			end
		end
		season_goals_avg.each do |season, goals|
			season_goals_avg[season] = (goals.sum.to_f / goals.count.to_f).ceil(2)
		end
		return season_goals_avg
	end

	def count_of_teams
		total_teams = []
		@teams.each do |team|
			total_teams << team.team_id
		end
			total_teams.count
	end


	def team_info(team_id)
		team_hash = {}
		team = @teams.find do |team|
			team.team_id == team_id
		end
		team_hash[:team_id] = team.team_id
		team_hash[:franchise_id] = team.franchise_id.to_i
		team_hash[:team_name] = team.team_name
		team_hash[:abbreviation] = team.abbreviation
		team_hash[:link] = team.link
		team_hash
	end

	def best_season(team_id)
	game_team_arr = @game_teams.find_all do |game|
		game.team_id == team_id
	end
	season_record_hash = {}
	game_team_arr.each do |game|
		if season_record_hash[game.game_id[0..3]] == nil
			season_record_hash[game.game_id[0..3]] = [game.result]
		else
			season_record_hash[game.game_id[0..3]] << game.result
		end
	end
	win_counter = 0
	best_win_percentage = 0
	season_record_hash.each do |season, result|
		 win_counter = result.count("WIN")
		 win_percentage = (win_counter.to_f / result.count.to_f) * 100
		 season_record_hash[season] = win_percentage
		 if best_win_percentage < win_percentage
			 best_win_percentage = win_percentage
		 end
	 end
	 best_season = season_record_hash.select{|season, result| result == best_win_percentage}
	 best_game = @games.find do |game|
		  best_season.keys[0] == game.season[0..3]
		end
		best_game.season
	end

	def worst_season(team_id)
	game_team_arr = @game_teams.find_all do |game|
		game.team_id == team_id
	end
	season_record_hash = {}
	game_team_arr.each do |game|
		if season_record_hash[game.game_id[0..3]] == nil
			season_record_hash[game.game_id[0..3]] = [game.result]
		else
			season_record_hash[game.game_id[0..3]] << game.result
		end
	end
	win_counter = 0
	worst_win_percentage = 100
	season_record_hash.each do |season, result|
		 win_counter = result.count("WIN")
		 win_percentage = (win_counter.to_f / result.count.to_f) * 100
		 season_record_hash[season] = win_percentage
		 if worst_win_percentage > win_percentage
			 worst_win_percentage = win_percentage
		 end
	 end
	 worst_season = season_record_hash.select{|season, result| result == worst_win_percentage}
	 worst_game = @games.find do |game|
			worst_season.keys[0] == game.season[0..3]
		end
		worst_game.season
	end

	def team_name_by_id(team_id)
	 	name = ""
		@teams.find_all do |team|
			if team.team_id == team_id
				 name << team.team_name
		  end
		end
		name
	end

	def tackles_by_id(team_id)
		tackles_hash = {}
		game_team_id = @game_teams.find_all do |gameteam|
			 gameteam.team_id == team_id
		 end
		 game_team_id.each do |game|
			if tackles_hash[game.team_id] == nil
	 			tackles_hash[game.team_id] = [game.tackles.to_i]
	 		else
	 			tackles_hash[game.team_id] << game.tackles.to_i
	  	end
		 end
			tackles_hash
	end

	def game_id_to_season(game_id)
		season = ""
		@games.find do |game|
			if game_id[0..3] == game.season[0..3]
				season << game.season
			end
		end
		season
	end

	def most_tackles(season_id)
		game_season = []
		@game_teams.each do |game|
			if season_id[0..3] == game.game_id[0..3]
				game_season << game
			end
		end
		tackles_hash = {}
 		game_season.each do |game|
			if tackles_hash[game.team_id] == nil
				tackles_hash[game.team_id] = game.tackles.to_i
			else
				tackles_hash[game.team_id] += game.tackles.to_i
			end
		end
		tackle_id = tackles_hash.sort_by{|team_id, tackles| tackles}.last[0] #first
		team_name_by_id(tackle_id)
	end

	def least_tackles(season_id)
		game_season = []
		@game_teams.each do |game|
			if season_id[0..3] == game.game_id[0..3]
				game_season << game
			end
		end
		tackles_hash = {}
 		game_season.each do |game|
			if tackles_hash[game.team_id] == nil
				tackles_hash[game.team_id] = game.tackles.to_i
			else
				tackles_hash[game.team_id] += game.tackles.to_i
			end
		end
		tackle_id = tackles_hash.sort_by{|team_id, tackles| tackles}.first[0]
		team_name_by_id(tackle_id)
	end

	def average_win_percentage(team_id)
		games_by_team_arr = @game_teams.find_all do |game|
			 game.team_id == team_id
		end
		results_arr = []
		games_by_team_arr.each do |games|
			results_arr << games.result
		end
		wins = results_arr.count("WIN")
		win_percentage = (wins.to_f / results_arr.count.to_f) * 100
		return win_percentage
	end

	def best_offense
		#creates hash w/ team ids keys and team goals values
		team_goals = {}
		@game_teams.each do |game|
			team = game.team_id
			if team_goals[team] == nil
				team_goals[team] = [game.goals.to_f]
			else
				team_goals[team] << game.goals.to_f
			end
		end
	#averages all value arrays and reassigns it to team_goals key
		avg_goals = {}
		 team_goals.each do |team, goals|
			avg_goals[team] = (goals.sum / goals.size).ceil(2)
		end
	#creates hash w/team_id keys and team name values
		team_names = {}
		@teams.each do |team|
			team_names[team.team_id] = team.team_name
		end
		#reassigns key of team_id with team_name in avg_goals hash
		avg_goals.keys.each do |key|
		team_names.each do |id, name|
			if id == key
				avg_goals[name] = avg_goals[key]
				avg_goals.delete(key)
			end
		end
	end
	#turns avg_goals into an array with the key and value pair and calling first
	#index position
	max_avg = avg_goals.values.max
	max_team = avg_goals.select{|team, goals| goals == max_avg}
	max_team.keys[0]
	end

	def worst_offense
		team_goals = {}
		@game_teams.each do |game|
			team = game.team_id
			if team_goals[team] == nil
				team_goals[team] = [game.goals.to_f]
			else
				team_goals[team] << game.goals.to_f
			end
		end
		avg_goals = {}
		 team_goals.each do |team, goals|
			avg_goals[team] = (goals.sum / goals.size).ceil(2)
		end
		team_names = {}
		@teams.each do |team|
			team_names[team.team_id] = team.team_name
		end
		avg_goals.keys.each do |key|
		team_names.each do |id, name|
			if id == key
				avg_goals[name] = avg_goals[key]
				avg_goals.delete(key)
			end
		end
	end
	min_avg = avg_goals.values.min
	min_team = avg_goals.select{|team, goals| goals == min_avg}
	min_team.keys[0]
	end

	def most_goals_scored(team_id)
		team_number = @game_teams.find_all{|game_team| game_team.team_id.to_i == team_id}
		team_goals = {}
		team_number.each do |game|
			if team_goals[game.team_id] == nil
				team_goals[game.team_id] = [game.goals.to_i]
			else
				team_goals[game.team_id] << game.goals.to_i
			end
		end
		team_goals.values.flatten!.max
	end

	def fewest_goals_scored(team_id)
		team_number = @game_teams.find_all{|game_team| game_team.team_id.to_i == team_id}
		team_goals = {}
		team_number.each do |game|
			if team_goals[game.team_id] == nil
				team_goals[game.team_id] = [game.goals.to_i]
			else
				team_goals[game.team_id] << game.goals.to_i
			end
		end
		team_goals.values.flatten!.min
  end

	def winningest_coach(season)
    #find all the games for the given season
    season_games = @games.find_all{|game| game.season == season}
    #use the season to find the game_id and then get an array of all the game_teams for that season
    game_teams_by_season = []
    season_games.each do |game|
      matching_game_team = @game_teams.find_all{|g_t| g_t.game_id == game.game_id}
      if matching_game_team
        game_teams_by_season << matching_game_team
      end
    end
    game_teams_by_season.flatten!
    #go through the game_team objects to calculate win precentage for each coach
    coach_wins_losses = {}
    game_teams_by_season.each do |game_team|
      if coach_wins_losses.keys.include?(game_team.head_coach)
        coach_wins_losses[game_team.head_coach] << game_team.result
      else
        coach_wins_losses[game_team.head_coach] = [game_team.result]
      end
    end
    #calculate win percentage for each coach
    highest_percentage = 0.0
    best_coach = nil
    coach_wins_losses.each do |coach, win_loss|
        wins = 0
        win_loss.each do |val|
          if val == "WIN"
            wins += 1
          end
        end
        percentage = ((wins.to_f / win_loss.length) * 100).round(2)
        if percentage > highest_percentage
          best_coach = coach
          highest_percentage = percentage
        end
    end
    return best_coach
  end

	def worst_coach(season)
		#find all the games for the given season
		season_games = @games.find_all{|game| game.season == season}
		#use the season to find the game_id and then get an array of all the game_teams for that season
		game_teams_by_season = []
		season_games.each do |game|
			matching_game_team = @game_teams.find_all{|g_t| g_t.game_id == game.game_id}
			if matching_game_team
				game_teams_by_season << matching_game_team
			end
		end
		game_teams_by_season.flatten!
		#go through the game_team objects to calculate win precentage for each coach
		coach_wins_losses = {}
		game_teams_by_season.each do |game_team|
			if coach_wins_losses.keys.include?(game_team.head_coach)
				coach_wins_losses[game_team.head_coach] << game_team.result
			else
				coach_wins_losses[game_team.head_coach] = [game_team.result]
			end
		end
		#calculate win percentage for each coach
		lowest_percentage = 100.0
		worst_coach = nil
		coach_wins_losses.each do |coach, win_loss|
				wins = 0
				win_loss.each do |val|
					if val == "WIN"
						wins += 1
					end
				end
				percentage = ((wins.to_f / win_loss.length) * 100).round(2)
				if percentage < lowest_percentage
					worst_coach = coach
					lowest_percentage = percentage
				end
		end
		return worst_coach
	end

	def most_accurate_team(season)
		team_shots_goals = {}
		season_games = @game_teams.find_all{|game_team| game_team.game_id[0..3] == season[0..3]}
		season_games.each do |season_game|
			team_id = season_game.team_id
			if team_shots_goals[team_id]
				team_shots_goals[team_id][0] += season_game.shots
				team_shots_goals[team_id][1] +=  season_game.goals
			else
				team_shots_goals[team_id] = [season_game.shots, season_game.goals]
			end
		end
		best_team_id = 0
		best_ratio = 100
		team_shots_goals.each do |team_id, shots_goals|
			ratio = shots_goals[0].to_f / shots_goals[1].to_f
			if ratio < best_ratio
				best_ratio = ratio
				best_team_id = team_id
			end
		end
		best_team = @teams.find{|team| team.team_id == best_team_id}
		return best_team.team_name
	end

	def least_accurate_team(season)
		team_shots_goals = {}
		season_games = @game_teams.find_all{|game_team| game_team.game_id[0..3] == season[0..3]}
		season_games.each do |season_game|
			team_id = season_game.team_id
			if team_shots_goals[team_id]
				team_shots_goals[team_id][0] += season_game.shots
				team_shots_goals[team_id][1] +=  season_game.goals
			else
				team_shots_goals[team_id] = [season_game.shots, season_game.goals]
			end
		end
		worst_team_id = 0
		worst_ratio = 0
		team_shots_goals.each do |team_id, shots_goals|
			ratio = shots_goals[0].to_f / shots_goals[1].to_f
			if ratio > worst_ratio
				worst_ratio = ratio
				worst_team_id = team_id
			end
		end
		worst_team = @teams.find{|team| team.team_id == worst_team_id}
		return worst_team.team_name
  end

	def percentage_ties
		ties = []
		@games.each do |game|
			if game.home_goals == game.away_goals
				ties << game
			end
		end
		return ((ties.count.to_f / game_count.to_f).ceil(4)) * 100
	end


	def count_of_games_by_season
		seasons_arr = []
		@games.each do |game|
			seasons_arr << game.season
		end
		game_count_by_season_hash = Hash.new
		seasons_arr.uniq.each do |season|
			game_count_by_season_hash[season] = seasons_arr.count(season)
		end
		return game_count_by_season_hash
	end


# highest_scoring_visitor	Name of the team with the highest average score per game across all seasons when they are away.
# create a hash of team_id as key and value (goals)


	# def average_visitor_scores
	# 	away_team_goals_hash = {}
	# 	@games.each do |game|
	# 		away_team_goals_hash[game.away_team_id] = average_away_goals_per_team(game.away_team_id)
	# 	end
	# 	away_team_goals_hash
	# end

	def average_scores(arg)
		if arg == "home"
			team_id = home_team_id
		else
			team_id = away_team_id
		end
		team_goals_hash = {}
		@games.each do |game|
			team_goals_hash[game.team_id] = average_goals_per_team(game.team_id)
		end
		team_goals_hash
	end

  def favorite_opponent(team_name)
		team_id = @teams.find{|team| team.team_name == team_name}.team_id
		#find every GameTeam object for this team
		game_info_for_team = @game_teams.find_all{|game_team| game_team.team_id == team_id}
		#find every GameTeam object for all opponents of the team and associate them with team id in a hash
		opponent_game_info = {}
		game_info_for_team.each do |given_team|
			opponent = @game_teams.find{|game_team| ((game_team.team_id != team_id) && (game_team.game_id == given_team.game_id))}
			if opponent
				if opponent_game_info[opponent.team_id]
					opponent_game_info[opponent.team_id] << opponent
				else
					opponent_game_info[opponent.team_id] = [opponent]
				end
			end
		end
		#calculate win percentage for each team in opponent_game_info_hash
		opponent_win_percentage = {}
		lowest_win_percentage = 100
		opponent_game_info.each do |team_id, game_teams|
			wins_losses = []
			game_teams.each do |game_team|
				wins_losses << game_team.result
			end
			win_percentage = (wins_losses.count("WIN"
			).to_f / wins_losses.count.to_f) * 100
			if win_percentage < lowest_win_percentage
				lowest_win_percentage = win_percentage
			end
			opponent_win_percentage[team_id] = win_percentage
		end
		fav_opponent_id = nil
		opponent_win_percentage.each do |id, win|
			if win == lowest_win_percentage
				fav_opponent_id = id
				break
			end
		end
		#find the name associated with the id for fav_opponent
		fav_opponent_team = @teams.find{|team| team.team_id == fav_opponent_id}
		return fav_opponent_team.team_name



	def average_goals_per_team(team_id, arg)
		goals = 0
		games = 0
		@games.each do |game|
			if game.team_id == team_id
				goals += game.goals
				games += 1
			end
		end
		goals / games.to_f
	end

	def highest_scoring_visitor
		average_visitor_scores.invert.max.last
	end

	def lowest_scoring_visitor
		average_visitor_scores.invert.min.last
	end

end


# 	def average_away_goals_per_team(team_id)
# 		goals = 0
# 		games = 0
# 		@games.each do |game|
# 			if game.away_team_id == team_id
# 				goals += game.away_goals
# 				games += 1
# 			end
# 		end
# 		goals / games.to_f
# 	end
#
# 	def highest_scoring_visitor
# 		average_visitor_scores.invert.max.last
# 	end
#
# 	def lowest_scoring_visitor
# 		average_visitor_scores.invert.min.last
# 	end
# end

# def highest_scoring_visitor
# 	away_team_goals_hash = {}
# 	away_team_num_of_games = {}
# 	@games.each do |game|
# 		if away_team_goals_hash.key?(game.away_team_id) == false
# 			away_team_goals_hash[game.away_team_id] = game.away_goals
# 			away_team_num_of_games[game.away_team_id] = 1
# 		else
# 			away_team_goals_hash[game.away_team_id] += game.away_goals
# 			away_team_num_of_games[game.away_team_id] += 1
# 		end
# 	end
# 	average_goals_per_team = {}
# 	away_team_goals_hash.each do |key, value|
# 		average_goals_per_team[key] = value.to_f/away_team_num_of_games[key]
# 	end
# 	average_goals_per_team
# end

