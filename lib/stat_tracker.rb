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
end
