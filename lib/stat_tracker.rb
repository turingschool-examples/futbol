require "csv"
require './lib/game_team_collection'
require './lib/game_collection'
require './lib/team_collection'

class StatTracker
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
		(@game_collection.home_wins.count / @game_collection.games_array.count.to_f).round(2)
	end

	def percentage_visitor_wins
		(@game_collection.visitor_wins.count / @game_collection.games_array.count.to_f).round(2)
	end

	def percentage_ties
		(@game_collection.ties.count / @game_collection.games_array.count.to_f).round(2)
	end

  def count_of_games_by_season
    @game_collection.count_of_games
  end

  def average_goals_per_game
    @game_collection.average_goals_per_game
  end

  def average_goals_by_season
    @game_collection.average_goals_by_season
  end

	def team_away_goals_by_id
		goals = Hash.new { | k, v | k[v]= [] } 
		games.each do |game|
			goals[game[:away_team_id]] << game[:away_goals].to_i			
		end
		scores_by_team_name = Hash.new { | k, v | k[v]= [] } 
		goals.each do |team_id, score|
			teams.each do |team|
				if team_id == team[:team_id]
					scores_by_team_name[team[:teamname]] = score					
				end
			end
		end
		scores_by_team_name
	end
	
	def team_home_goals_by_id
		goals = Hash.new { | k, v | k[v]= [] } 
		games.each do |game|
			goals[game[:home_team_id]] << game[:home_goals].to_i
		end
		scores_by_team_name = Hash.new { | k, v | k[v]= [] } 
		goals.each do |team_id, score|
			teams.each do |team|
				if team_id == team[:team_id]
					scores_by_team_name[team[:teamname]] = score					
				end
			end
		end
		scores_by_team_name		
	end	

	def average_score_away_game
		averages_by_teamname = Hash.new { | k, v | k[v]= [] }
		team_away_goals_by_id.each do | k, v |
			value = v.sum.to_f / v.count.to_f
			averages_by_teamname[k] = value
		end
		averages_by_teamname
	end
	
	def average_score_home_game
		averages_by_teamname = Hash.new { | k, v | k[v]= [] }
		team_home_goals_by_id.each do | k, v |
			value = v.sum.to_f / v.count.to_f
			averages_by_teamname[k] = value
		end
		averages_by_teamname
	end

	def highest_scoring_visitor
		max = average_score_away_game.max_by { |teamname, average_score| average_score}
		max[0]
	end

	def highest_scoring_home_team
		max = average_score_home_game.max_by { |teamname, average_score| average_score}
		max[0]
	end

	def lowest_scoring_visitor
		min = average_score_away_game.min_by { |teamname, average_score| average_score}
		min[0]
	end

	def lowest_scoring_home_team
		min = average_score_home_game.min_by { |teamname, average_score| average_score}
		min[0]
	end

  def count_of_teams
    total_teams = teams.count
  end

  def best_offense
    teams_total_scores = Hash.new{0}
    teams_total_games = Hash.new{0}
    teams_total_averages = Hash.new{0}
    i = 0
    
    game_teams[:team_id].each do |id|
      if teams_total_scores[id] == nil
        teams_total_scores[id] = game_teams[:goals][i].to_f
        teams_total_games[id] = 1
      else
        teams_total_scores[id] += game_teams[:goals][i].to_f
        teams_total_games[id] += 1
      end
      i += 1
    end
    teams_total_scores.each do |key, value|
      teams_total_averages[key] = (value / teams_total_games[key].to_f).round(5)
    end
    best_offensive_team_id = teams_total_averages.max_by{|k, v| v}[0]

    best_offensive_team_name = teams.find {|row| row[:team_id] == best_offensive_team_id}[:teamname]
  end

  def worst_offense
    teams_total_scores = Hash.new{0}
    teams_total_games = Hash.new{0}
    teams_total_averages = Hash.new{0}
    i = 0
    
    game_teams[:team_id].each do |id|
      if teams_total_scores[id] == nil
        teams_total_scores[id] = game_teams[:goals][i].to_f
        teams_total_games[id] = 1
      else
        teams_total_scores[id] += game_teams[:goals][i].to_f
        teams_total_games[id] += 1
      end
      i += 1
    end
    teams_total_scores.each do |key, value|
      teams_total_averages[key] = (value / teams_total_games[key].to_f).round(5)
    end
    worst_offensive_team_id = teams_total_averages.min_by{|k, v| v}[0]

    worst_offensive_team_name = teams.find {|row| row[:team_id] == worst_offensive_team_id}[:teamname]

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
