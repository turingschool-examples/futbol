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
			team_id = row[:team_id]
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
      team_id = row[:team_id]
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
end
