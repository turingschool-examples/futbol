require './required_files'

class StatTracker
include TeamModule
include GameModule
include LeagueModule
include SeasonModule

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
			away_team_id = row[:away_team_id].to_i
			home_team_id = row[:home_team_id].to_i
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

  def create_games(games)
    game_arr = []
    games.each do |row|
      game_id = row[:game_id]
      season = row[:season]
      type = row[:type]
      date_time = row[:date_time]
      away_team_id = row[:away_team_id]
      home_team_id = row[:home_team_id].to_i
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      venue = row[:venue]
      venue_link = row[:venue_link]
      game_arr << Game.new(game_id, season, type, date_time, away_team_id, home_team_id,
        away_goals, home_goals, venue, venue_link)
    end
  return game_arr
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
		team = @teams.find { |team| team.team_id == team_id }
		team_hash[:team_id] = team.team_id
		team_hash[:franchise_id] = team.franchise_id.to_i
		team_hash[:team_name] = team.team_name
		team_hash[:abbreviation] = team.abbreviation
		team_hash[:link] = team.link
		team_hash
	end

	def best_season(team_id)
		 season_win_percentage_hash = TeamModule.season_win_percentages(team_id, @game_teams)
		 best_season = season_win_percentage_hash.invert.max
		 best_game = @games.find do |game|
		  best_season[1] == game.season[0..3]
		end
		best_game.season
	end

	def worst_season(team_id)
		 season_win_percentage_hash = TeamModule.season_win_percentages(team_id, @game_teams)
	 	 best_season = season_win_percentage_hash.invert.min
	 	 best_game = @games.find do |game|
	 		best_season[1] == game.season[0..3]
	 	end
 		best_game.season
	end

	def most_tackles(season_id)
		tackles_hash = SeasonModule.tackles_hash(season_id, @game_teams)
		tackle_id = tackles_hash.sort_by{|team_id, tackles| tackles}.last[0]
		LeagueModule.team_name_by_id(tackle_id, @teams)
	end

	def least_tackles(season_id)
		tackles_hash = SeasonModule.tackles_hash(season_id, @game_teams)
		tackle_id = tackles_hash.sort_by{|team_id, tackles| tackles}.first[0]
		LeagueModule.team_name_by_id(tackle_id, @teams)
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
		SeasonModule.best_coach(season, @game_teams)
  end

	def worst_coach(season)
		SeasonModule.worst_coach(season, @game_teams)
	end

	def most_accurate_team(season)
		SeasonModule.best_team(season, @game_teams, @teams)
	end

	def least_accurate_team(season)
		SeasonModule.worst_team(season, @game_teams, @teams)
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
  end


	def highest_scoring_home_team
		home_win_id = home_goals_hash.sort_by{|team_id, score| score}.last[0]
		LeagueModule.team_name_by_id(home_win_id, @teams)
	 end

	 def lowest_scoring_home_team
		 home_score_id = home_goals_hash.sort_by{|team_id, score| score}.first[0]
		 LeagueModule.team_name_by_id(home_score_id, @teams)
	 end

	def home_goals_hash
	 home_team_hash = {}
	 @games.each do |game|
		 game.home_team_id
			 if home_team_hash[game.home_team_id] == nil
				 home_team_hash[game.home_team_id] = [game.home_goals.to_i]
			 else
				 home_team_hash[game.home_team_id] << game.home_goals.to_i
			 end
		 end
	 home_team_hash.each do |team_id, scores|
		 home_team_hash[team_id] = (scores.sum.to_f / scores.count.to_f).ceil(2)
	 end
	 home_team_hash
	end




	def highest_scoring_visitor
		team_id = LeagueModule.average_visitor_scores(@games).invert.max.last
		LeagueModule.team_name_by_id(team_id.to_i, @teams)
	end

	def lowest_scoring_visitor
		team_id = LeagueModule.average_visitor_scores(@games).invert.min.last
		LeagueModule.team_name_by_id(team_id.to_i, @teams)
	end

	def highest_scoring_home_team
		team_id = LeagueModule.average_home_scores(@games).invert.max.last
		LeagueModule.team_name_by_id(team_id.to_i, @teams)
	end

	def lowest_scoring_home_team
		team_id = LeagueModule.average_home_scores(@games).invert.min.last
		LeagueModule.team_name_by_id(team_id.to_i, @teams)
	end

	def rival(team_name)
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
		lowest_win_percentage = 0
		opponent_game_info.each do |team_id, game_teams|
			wins_losses = []
			game_teams.each do |game_team|
				wins_losses << game_team.result
			end
			win_percentage = (wins_losses.count("WIN"
			).to_f / wins_losses.count.to_f) * 100
			if win_percentage > lowest_win_percentage
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
		end
	end
# end
