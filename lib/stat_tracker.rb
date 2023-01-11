require "csv"
require './lib/game_team_collection'
require './lib/game_collection'
require './lib/team_collection'
require './lib/analytics'

class StatTracker
include Analytics
	attr_accessor :game_collection, :team_collection, :game_team_collection

	def initialize(locations)
 		@game_collection = GameCollection.new(locations[:games])
 		@team_collection = TeamCollection.new(locations[:teams])
 		@game_team_collection = GameTeamCollection.new(locations[:game_teams])
	end
  
	def self.from_csv(locations)
    StatTracker.new(locations)
  end
  
  def highest_total_score
    @game_collection.total_score.max
  end

  def lowest_total_score
    @game_collection.total_score.min
  end

	def percentage_home_wins
		home_wins = []
		games.each do |game|
			if game[:home_goals].to_i > game[:away_goals].to_i
				home_wins << game
			end
		end
		(home_wins.count / games.count.to_f).round(2)
	end

	def percentage_visitor_wins
		# look for helper methods during refactor
		visitor_wins = []
		games.each do |game|
			if game[:away_goals].to_i > game[:home_goals].to_i
				visitor_wins << game
			end
		end
		(visitor_wins.count / games.count.to_f).round(2)
	end

	def percentage_ties
		ties = []
		games.each do |game|
			if game[:away_goals].to_i == game[:home_goals].to_i
				ties << game
			end
		end
		(ties.count / games.count.to_f).round(2)
	end

  def count_of_games_by_season
    count_of_games_by_season = Hash.new {0}

    games[:season].each do |season|
      count_of_games_by_season[season] += 1
    end
    
    count_of_games_by_season
  end

  def average_goals_per_game
    sums = []
    i = 0
    while i < games.count
      sums << games[:away_goals][i].to_f + games[:home_goals][i].to_f
      i += 1
    end
    total_average = (sums.sum/games.count).round(2)
  end

  def average_goals_by_season
    average_goals_by_season = Hash.new {0}
    total_goals_by_season = Hash.new {0}
		
    i = 0
    games[:season].each do |season|
      if total_goals_by_season[season] == nil
        total_goals_by_season[season] = games[:away_goals][i].to_f + games[:home_goals][i].to_f
      else
        total_goals_by_season[season] += games[:away_goals][i].to_f + games[:home_goals][i].to_f
      end
      i += 1
			
    end
    total_goals_by_season.each do |season, total_goals|
      average_goals_by_season[season] = (total_goals/count_of_games_by_season[season]).round(2)
    end

    average_goals_by_season
  end

	def highest_scoring_visitor
    @team_collection.find_team(total_away_teams_average(@game_collection).max_by{|k, v| v}[0])
	end

	def highest_scoring_home_team
    @team_collection.find_team(total_home_teams_average(@game_collection).max_by{|k, v| v}[0])
	end

	def lowest_scoring_visitor
    @team_collection.find_team(total_away_teams_average(@game_collection).min_by{|k, v| v}[0])
	end

	def lowest_scoring_home_team
    @team_collection.find_team(total_home_teams_average(@game_collection).min_by{|k, v| v}[0])
	end

  def count_of_teams
    @team_collection.teams_array.count
  end

  def best_offense
    @team_collection.find_team(total_teams_average(@game_team_collection).max_by{|k, v| v}[0])
  end

  def worst_offense
    @team_collection.find_team(total_teams_average(@game_team_collection).min_by{|k, v| v}[0])
  end

  def winningest_coach(season)
		game.outcomes_by_game_id

    game_ids_by_season.season.each do |id|
			outcomes_by_game_id << game_teams.find_all {|games| games[:game_id] == id[:game_id]}
    end

    outcomes_by_game_id

    
    results_by_coach = Hash.new { | k, v | k[v] = [] }
    outcomes_by_game_id.each do |outcome|
      outcome.each do |team_stats|
        results_by_coach[team_stats[:head_coach]] << team_stats[:result]
      end
    end

    results_by_coach.each do |coach_name, results|
      wins = 0
      total_games = 0

      results.each do |result|
        if result == 'WIN'
          wins += 1
          total_games += 1
        else
          total_games += 1
        end
      end
      
      coach_winrate = (wins.to_f / (game_ids_by_season[season].count).to_f)
      results_by_coach[coach_name] = coach_winrate
    end
    
    max_value = results_by_coach.values.max

    results_by_coach.key(max_value)
  end
  
  def worst_coach(season)
    outcomes_by_game_id = []

    game_ids_by_season[season].each do |id|
			outcomes_by_game_id << game_teams.find_all {|games| games[:game_id] == id[:game_id]}
    end

    outcomes_by_game_id

    results_by_coach = Hash.new { | k, v | k[v] = [] }
    outcomes_by_game_id.each do |outcome|
      outcome.each do |team_stats|
        results_by_coach[team_stats[:head_coach]] << team_stats[:result]
      end
    end

    results_by_coach.each do |coach_name, results|
      wins = 0
      total_games = 0

      results.each do |result|
        if result == 'WIN'
          wins += 1
          total_games += 1
        else
          total_games += 1
        end
      end
      
      coach_winrate = (wins.to_f / (game_ids_by_season[season].count).to_f)
      results_by_coach[coach_name] = coach_winrate
    end
    
    min_value = results_by_coach.values.min

    results_by_coach.key(min_value)
  end

  def game_teams_by_team_ids
    @game_teams_by_team_ids ||= game_teams.group_by do |game|
      game[:team_id]
    end
  end
  
  def favorite_opponent(team_id)
    
    game_ids_by_team_id = []

    game_teams_by_team_ids[team_id].each do |i_team_id|
      game_ids_by_team_id << game_teams.find_all do |games|
        games[:game_id] == i_team_id[:game_id]
      end
    end
     
    game_ids_by_team_id

    matches = []

    game_ids_by_team_id.each do |match|
      match.each do |team_stat|
        matches << team_stat if team_stat[:team_id] != team_id
      end
    end 
    
    opponent_outcomes = Hash.new { | k, v | k[v] = [] }
    
    matches.each do |match|
      opponent_outcomes[match[:team_id]] << match[:result]
    end

    opponent_winrates = Hash.new { | k, v | k[v] = 0.0 }

    opponent_outcomes.each do |id, outcomes|
      opponent_winrates[id] += ((outcomes.tally["WIN"].to_f) / (outcomes.tally.values.sum.to_f) * 100).round(2)
    end

    lowest_winrate = opponent_winrates.min_by do |id, percentage|
      percentage
    end
    
    favorite_opponent = teams.find do |team|
      team[:team_id] == lowest_winrate[0]
    end[:teamname]

    favorite_opponent
  end

  def rival(team_id)
       
    game_ids_by_team_id = []

    game_teams_by_team_ids[team_id].each do |i_team_id|
      game_ids_by_team_id << game_teams.find_all do |games|
        games[:game_id] == i_team_id[:game_id]
      end
    end
     
    game_ids_by_team_id

    matches = []

    game_ids_by_team_id.each do |match|
      match.each do |team_stat|
        matches << team_stat if team_stat[:team_id] != team_id
      end
    end 
    
    opponent_outcomes = Hash.new { | k, v | k[v] = [] }
    
    matches.each do |match|
      opponent_outcomes[match[:team_id]] << match[:result]
    end

    opponent_winrates = Hash.new { | k, v | k[v] = 0.0 }

    opponent_outcomes.each do |id, outcomes|
      opponent_winrates[id] += ((outcomes.tally["WIN"].to_f) / (outcomes.tally.values.sum.to_f) * 100).round(2)
    end

    highest_winrate = opponent_winrates.max_by do |id, percentage|
      percentage
    end
    
    rival = teams.find do |team|
      team[:team_id] == highest_winrate[0]
    end[:teamname]

    rival
  end
  
  # winrate_by_season =  Hash.new { |k, v| k[v] = []}
  # game_teams.each do |row|
  #   if winrate_by_season.keys.include?(row[:head_coach])
  #     winrate_by_season[row[:head_coach]].push(row[:result])
  #   else
  #     winrate_by_season[row[:head_coach]] = [row[:result]]
  #   end
  # end
  # winrate_by_season
  
  def team_info(team_id)
    team_stats = Hash.new {|k, v| k[v]= []}
    
    teams.each do |id|
      if id[:team_id] == team_id 
        team_stats["team_id"] = id[:team_id]
        team_stats["franchise_id"] = id[:franchiseid]
        team_stats["team_name"] = id[:teamname]
        team_stats["abbreviation"] = id[:abbreviation]
        team_stats["link"] = id[:link]
      end
    end

    team_stats
  end

	def most_tackles(season_id)
		game_ids_by_season = Hash.new { | k, v | k[v]= [] }
		games.each do |game|
			if game_ids_by_season[game[:season]]== nil
				game_ids_by_season[game[:season]] = [game[:game_id]]
			else
				game_ids_by_season[game[:season]] << game[:game_id]
			end
		end
		variable = []
		game_ids_by_season[season_id].each do |id|
			variable << game_teams.find_all {|row| row[:game_id]== id}
		end
		teams_and_tackles = Hash.new { | k, v | k[v]= 0 }
		variable.flatten(1).each do |row|
			if teams_and_tackles[row[:team_id]]== nil
				teams_and_tackles[row[:team_id]] = [row[:tackles]].to_i
			else
				teams_and_tackles[row[:team_id]] += row[:tackles].to_i
			end
		end
		most_tackles_by_id = teams_and_tackles.max_by{ |k,v| v }[0]
		most_tackles_by_name = teams.find {|row| row[:team_id] == most_tackles_by_id}[:teamname]
	end

	def fewest_tackles(season_id)
		game_ids_by_season = Hash.new { | k, v | k[v]= [] }
		games.each do |game|
			if game_ids_by_season[game[:season]]== nil
				game_ids_by_season[game[:season]] = [game[:game_id]]
			else
				game_ids_by_season[game[:season]] << game[:game_id]
			end
		end
		variable = []
		game_ids_by_season[season_id].each do |id|
			variable << game_teams.find_all {|row| row[:game_id]== id}
		end
		teams_and_tackles = Hash.new { | k, v | k[v]= 0 }
		variable.flatten(1).each do |row|
			if teams_and_tackles[row[:team_id]]== nil
				teams_and_tackles[row[:team_id]] = [row[:tackles]].to_i
			else
				teams_and_tackles[row[:team_id]] += row[:tackles].to_i
			end
		end
		fewest_tackles_by_id = teams_and_tackles.min_by{ |k,v| v }[0]
		fewest_tackles_by_name = teams.find {|row| row[:team_id] == fewest_tackles_by_id}[:teamname]
	end

	def most_accurate_team(season_id)
		game_ids_by_season = Hash.new { | k, v | k[v]= [] }
		games.each do |game|
			if game_ids_by_season[game[:season]]== nil
				game_ids_by_season[game[:season]] = [game[:game_id]]
			else
				game_ids_by_season[game[:season]] << game[:game_id]
			end
		end
		variable = []
		game_ids_by_season[season_id].each do |id|
			variable << game_teams.find_all {|row| row[:game_id]== id}
		end

		total_goals_by_team = Hash.new { | k, v | k[v]= 0.0 }
		total_shots_by_team = Hash.new { | k, v | k[v]= 0.0 }

		variable.flatten(1).each do |row|
			if total_goals_by_team[row[:team_id]]== nil
				total_goals_by_team[row[:team_id]] = row[:goals].to_f
				total_shots_by_team[row[:team_id]] = row[:shots].to_f
			else
				total_goals_by_team[row[:team_id]] += row[:goals].to_f
				total_shots_by_team[row[:team_id]] += row[:shots].to_f
			end
		end

		teams_and_accuracy = Hash.new { | k, v | k[v]= 0.0 }
		total_shots_by_team.each do |team_id, total_shots|
			teams_and_accuracy[team_id] = (total_shots/total_goals_by_team[team_id])
		end

		highest_accuracy_by_id = teams_and_accuracy.min_by{ |k,v| v }[0]
		highest_accuracy_by_name = teams.find {|row| row[:team_id] == highest_accuracy_by_id}[:teamname]
	end

	def least_accurate_team(season_id)
		game_ids_by_season = Hash.new { | k, v | k[v]= [] }
		games.each do |game|
			if game_ids_by_season[game[:season]]== nil
				game_ids_by_season[game[:season]] = [game[:game_id]]
			else
				game_ids_by_season[game[:season]] << game[:game_id]
			end
		end
		variable = []
		game_ids_by_season[season_id].each do |id|
			variable << game_teams.find_all {|row| row[:game_id]== id}
		end

		total_goals_by_team = Hash.new { | k, v | k[v]= 0.0 }
		total_shots_by_team = Hash.new { | k, v | k[v]= 0.0 }

		variable.flatten(1).each do |row|
			if total_goals_by_team[row[:team_id]]== nil
				total_goals_by_team[row[:team_id]] = row[:goals].to_f
				total_shots_by_team[row[:team_id]] = row[:shots].to_f
			else
				total_goals_by_team[row[:team_id]] += row[:goals].to_f
				total_shots_by_team[row[:team_id]] += row[:shots].to_f
			end
		end

		teams_and_accuracy = Hash.new { | k, v | k[v]= 0.0 }
		total_shots_by_team.each do |team_id, total_shots|
			teams_and_accuracy[team_id] = (total_shots/total_goals_by_team[team_id])
		end

		least_accuracy_by_id = teams_and_accuracy.max_by{ |k,v| v }[0]
		least_accuracy_by_name = teams.find {|row| row[:team_id] == least_accuracy_by_id}[:teamname]
	end

	def average_win_percentage(team_id)
		total_games = 0.0
		total_wins = 0.0

		game_teams.each do |row|			
			if row[:team_id] == team_id
				total_games += 1.0
				if row[:result] == "WIN"
					total_wins += 1.0
				end
			end
		end
		(total_wins / total_games).round(2) 
	end

  def best_season(team_id)
    team_game_ids_and_results = Hash.new {|k, v| k[v]= ''}


    game_teams.each do |row|
      if row[:team_id] == team_id
        team_game_ids_and_results[row[:game_id]] = row[:result]
      end  
    end
    results_by_season = Hash.new{|k, v| k[v]= []}

    team_game_ids_and_results.each do |game_id, result|
      games.each do |row|
        if row[:game_id] == game_id
          results_by_season[row[:season]] << result
        end
      end
    end
    
    percentage_by_season = Hash.new{|k, v| k[v]= ''}

    results_by_season.each do |season, results|
      wins = 0
      results.each do |result|
        if result == 'WIN'
          wins += 1
        end
      end
      percentage_by_season[season] = wins.to_f / results.count.to_f
    end
    percentage_by_season.max_by{|k, v| v}[0]
  end


  def worst_season(team_id)
    team_game_ids_and_results = Hash.new {|k, v| k[v]= ''}


    game_teams.each do |row|
      if row[:team_id] == team_id
        team_game_ids_and_results[row[:game_id]] = row[:result]
      end  
    end
    results_by_season = Hash.new{|k, v| k[v]= []}

    team_game_ids_and_results.each do |game_id, result|
      games.each do |row|
        if row[:game_id] == game_id
          results_by_season[row[:season]] << result
        end
      end
    end
    
    percentage_by_season = Hash.new{|k, v| k[v]= ''}

    results_by_season.each do |season, results|
      wins = 0
      results.each do |result|
        if result == 'WIN'
          wins += 1
        end
      end
      percentage_by_season[season] = wins.to_f / results.count.to_f
    end
    percentage_by_season.min_by{|k, v| v}[0]
  end

	def most_goals_scored(team_id)
		# individual_team_goals_per_game = Hash.new { | k, v | k[v]= [] }
		individual_goals_per_game = []

		games_played = game_teams.find_all {|row| row[:team_id] == team_id }

		games_played.each do |game|
			individual_goals_per_game << game[:goals].to_i
		end

		individual_goals_per_game.max
	end

	def fewest_goals_scored(team_id)
		individual_goals_per_game = []

		games_played = game_teams.find_all {|row| row[:team_id] == team_id }

		games_played.each do |game|
			individual_goals_per_game << game[:goals].to_i
		end
		individual_goals_per_game.min
	end
end
