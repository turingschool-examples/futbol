require 'csv'
require './lib/game_team'
require './lib/team'
require './lib/game'
require './lib/game_module'
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
			stadium = row[:stadium] # do symbols always return all lowercase or the same case as we assign it???
			link = row[:link]
			team_arr << Team.new(team_id, franchise_id, team_name, abbreviation, stadium, link)
		end
		return team_arr
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
      goals = row[:goals]
      shots = row[:shots]
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
		return ((GameModule.total_home_wins(@games).count).to_f / (@games.count).to_f) * 100
	end

	def average_goals_per_game
		(GameModule.total_score(@games).sum.to_f / @games.count).ceil(2)
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
end
