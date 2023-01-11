require "csv"
require_relative './game_team_collection'
require_relative './game_collection'
require_relative './team_collection'
require_relative './analytics'

class StatTracker
include Analytics
include GameCollection
include TeamCollection
include GameTeamCollection
	attr_accessor :game_collection, :team_collection, :game_team_collection

  def initialize(locations)
    @game_collection = [] 
    @team_collection = []
    @game_team_collection = []

    # @game_collection << csv_read(locations[:games], Game)
    # @team_collection << csv_read(locations[:teams], Team)
    # @game_team_collection << csv_read(locations[:game_teams], GameTeam)

    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
	    @game_collection << Game.new(row)
	  end

    CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
	    @team_collection << Team.new(row)
	  end

    CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
	    @game_team_collection << GameTeam.new(row)
	  end
	end
  
	def self.from_csv(locations)
    StatTracker.new(locations)
  end
  
  def highest_total_score
    total_score(@game_collection).max
  end

  def lowest_total_score
    total_score(@game_collection).min
  end

	def percentage_home_wins
		(home_wins(@game_collection).count / @game_collection.count.to_f).round(2)
	end

	def percentage_visitor_wins
		(visitor_wins(@game_collection).count / @game_collection.count.to_f).round(2)
	end

	def percentage_ties
		(ties(@game_collection).count / @game_collection.count.to_f).round(2)
	end

  def count_of_games_by_season
    count_of_games(@game_collection)
  end

  def average_goals_per_game
    averages_of_goals_per_game(@game_collection)
  end

  def average_goals_by_season
    average_goals_by_seasons(@game_collection)
  end

  def count_of_teams
    @team_collection.count
  end

	def highest_scoring_visitor
    find_team(@team_collection, total_away_teams_average(@game_collection).max_by{|k, v| v}[0])
	end

	def highest_scoring_home_team
    find_team(@team_collection, total_home_teams_average(@game_collection).max_by{|k, v| v}[0])
	end

	def lowest_scoring_visitor
    find_team(@team_collection, total_away_teams_average(@game_collection).min_by{|k, v| v}[0])
	end

	def lowest_scoring_home_team
    find_team(@team_collection, total_home_teams_average(@game_collection).min_by{|k, v| v}[0])
	end

  def best_offense
    find_team(@team_collection, total_teams_average(@game_team_collection).max_by{|k, v| v}[0])
  end

  def worst_offense
    find_team(@team_collection, total_teams_average(@game_team_collection).min_by{|k, v| v}[0])
  end

  def winningest_coach(season)    
		outcomes_by_game_id = []
    results_by_coach = Hash.new { | k, v | k[v] = [] }

    game_ids_by_season(@game_collection)[season].each do |id|
			outcomes_by_game_id << @game_team_collection.find_all do |game| 
				game.game_id == id
			end
		end
	
    outcomes_by_game_id.each do |outcome|
      outcome.each do |team_stats|
        results_by_coach[(team_stats.head_coach)] << team_stats.result
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
      
      coach_winrate = (wins.to_f / (game_ids_by_season(@game_collection)[season].count).to_f)
      results_by_coach[coach_name] = coach_winrate
    end
    
    max_value = results_by_coach.values.max
		results_by_coach.key(max_value)
	end

  def worst_coach(season)
    outcomes_by_game_id = []
    results_by_coach = Hash.new { | k, v | k[v] = [] }

    game_ids_by_season(@game_collection)[season].each do |id|
			outcomes_by_game_id << @game_team_collection.find_all do |game| 
				game.game_id == id
			end
		end
	
    outcomes_by_game_id.each do |outcome|
      outcome.each do |team_stats|
        results_by_coach[(team_stats.head_coach)] << team_stats.result
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
      
      coach_winrate = (wins.to_f / (game_ids_by_season(@game_collection)[season].count).to_f)
      results_by_coach[coach_name] = coach_winrate
    end
    
    min_value = results_by_coach.values.min

    results_by_coach.key(min_value)
  end
  
  def most_accurate_team(season_id)
		game_ids_by_season = Hash.new { | k, v | k[v]= [] }

		@game_collection.each do |game|
		  game_ids_by_season[game.season] << game.game_id
		end

		variable = []

		game_ids_by_season[season_id].each do |id|
			variable << @game_team_collection.find_all {|row| row.game_id == id}
		end

		total_goals_by_team = Hash.new { | k, v | k[v]= 0.0 }
		total_shots_by_team = Hash.new { | k, v | k[v]= 0.0 }

		variable.flatten(1).each do |row|
			if total_goals_by_team[row.team_id]== nil
				total_goals_by_team[row.team_id] = row.goals.to_f
				total_shots_by_team[row.team_id] = row.shots.to_f
			else
				total_goals_by_team[row.team_id] += row.goals.to_f
				total_shots_by_team[row.team_id] += row.shots.to_f
			end
		end

		teams_and_accuracy = Hash.new { | k, v | k[v]= 0.0 }

		total_shots_by_team.each do |team_id, total_shots|
			teams_and_accuracy[team_id] = (total_shots/total_goals_by_team[team_id])
		end

		highest_accuracy_by_id = teams_and_accuracy.min_by { |k,v| v }[0]
		find_team(@team_collection, highest_accuracy_by_id)
	end


  def least_accurate_team(season_id)
		game_ids_by_season = Hash.new { | k, v | k[v]= [] }

		@game_collection.each do |game|
		  game_ids_by_season[game.season] << game.game_id
		end

		variable = []

		game_ids_by_season[season_id].each do |id|
			variable << @game_team_collection.find_all {|row| row.game_id == id}
		end

		total_goals_by_team = Hash.new { | k, v | k[v]= 0.0 }
		total_shots_by_team = Hash.new { | k, v | k[v]= 0.0 }

		variable.flatten(1).each do |row|
			if total_goals_by_team[row.team_id]== nil
				total_goals_by_team[row.team_id] = row.goals.to_f
				total_shots_by_team[row.team_id] = row.shots.to_f
			else
				total_goals_by_team[row.team_id] += row.goals.to_f
				total_shots_by_team[row.team_id] += row.shots.to_f
			end
		end

		teams_and_accuracy = Hash.new { | k, v | k[v]= 0.0 }

		total_shots_by_team.each do |team_id, total_shots|
			teams_and_accuracy[team_id] = (total_shots/total_goals_by_team[team_id])
		end

		highest_accuracy_by_id = teams_and_accuracy.max_by { |k,v| v }[0]
		find_team(@team_collection, highest_accuracy_by_id)
	end

  def most_tackles(season_id)
		game_ids_by_season = Hash.new { | k, v | k[v]= [] }

		@game_collection.each do |game|
			game_ids_by_season[game.season] << game.game_id
		end

		variable = []

		game_ids_by_season[season_id].each do |id|
			variable << @game_team_collection.find_all {|row| row.game_id == id}
		end

		teams_and_tackles = Hash.new { | k, v | k[v]= 0 }

		variable.flatten(1).each do |row|
			teams_and_tackles[row.team_id] += row.tackles.to_i
		end

		most_tackles_by_id = teams_and_tackles.max_by{ |k,v| v }[0]
		find_team(@team_collection, most_tackles_by_id)
	end

	def fewest_tackles(season_id)
		game_ids_by_season = Hash.new { | k, v | k[v]= [] }

		@game_collection.each do |game|
			game_ids_by_season[game.season] << game.game_id
		end

		variable = []

		game_ids_by_season[season_id].each do |id|
			variable << @game_team_collection.find_all {|row| row.game_id == id}
		end

		teams_and_tackles = Hash.new { | k, v | k[v]= 0 }

		variable.flatten(1).each do |row|
			teams_and_tackles[row.team_id] += row.tackles.to_i
		end

		most_tackles_by_id = teams_and_tackles.min_by{ |k,v| v }[0]
		find_team(@team_collection, most_tackles_by_id)
	end
  
  def team_info(team_id)
    team_stats = Hash.new {|k, v| k[v]= []}
    
    @team_collection.each do |id|
      if id.team_id == team_id 
        team_stats["team_id"] = id.team_id
        team_stats["franchise_id"] = id.franchise_id
        team_stats["team_name"] = id.team_name
        team_stats["abbreviation"] = id.abbreviation
        team_stats["link"] = id.link
      end
    end

    team_stats
  end

  def best_season(team_id)
    team_game_ids_and_results = Hash.new {|k, v| k[v]= ''}
    results_by_season = Hash.new{|k, v| k[v]= []}

    @game_team_collection.each do |row|
      if row.team_id == team_id
        team_game_ids_and_results[row.game_id] = row.result
      end  
    end

    team_game_ids_and_results.each do |game_id, result|
      @game_collection.each do |row|
        if row.game_id == game_id
          results_by_season[row.season] << result
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
    results_by_season = Hash.new{|k, v| k[v]= []}

    @game_team_collection.each do |row|
      if row.team_id == team_id
        team_game_ids_and_results[row.game_id] = row.result
      end  
    end

    team_game_ids_and_results.each do |game_id, result|
      @game_collection.each do |row|
        if row.game_id == game_id
          results_by_season[row.season] << result
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

	def average_win_percentage(team_id)
		total_games = 0.0
		total_wins = 0.0

		@game_team_collection.each do |row|			
			if row.team_id == team_id
				total_games += 1.0
				if row.result == "WIN"
					total_wins += 1.0
				end
			end
		end

		(total_wins / total_games).round(2) 
	end

	def most_goals_scored(team_id)
		individual_goals_per_game = []

		games_played = @game_team_collection.find_all {|row| row.team_id == team_id }

		games_played.each do |game|
			individual_goals_per_game << game.goals.to_i
		end

		individual_goals_per_game.max
	end

	def fewest_goals_scored(team_id)
		individual_goals_per_game = []

		games_played = @game_team_collection.find_all {|row| row.team_id == team_id }

		games_played.each do |game|
			individual_goals_per_game << game.goals.to_i
		end

		individual_goals_per_game.min
	end

  def favorite_opponent(team_id)
    game_ids_by_team_id = []

    game_teams_by_team_ids(@game_team_collection)[team_id].each do |i_team_id|
      game_ids_by_team_id << @game_team_collection.find_all do |games|
        games.game_id == i_team_id.game_id
      end
    end
     
    game_ids_by_team_id

    matches = []

    game_ids_by_team_id.each do |match|
      match.each do |team_stat|
        matches << team_stat if team_stat.team_id != team_id
      end
    end 
    
    opponent_outcomes = Hash.new { | k, v | k[v] = [] }
    
    matches.each do |match|
      opponent_outcomes[match.team_id] << match.result
    end

    opponent_winrates = Hash.new { | k, v | k[v] = 0.0 }

    opponent_outcomes.each do |id, outcomes|
      opponent_winrates[id] += ((outcomes.tally["WIN"].to_f) / (outcomes.tally.values.sum.to_f) * 100).round(2)
    end

    lowest_winrate = opponent_winrates.min_by do |id, percentage|
      percentage
    end
    
    favorite_opponent = @team_collection.find do |team|
      team.team_id == lowest_winrate[0]
    end
    
    favorite_opponent.team_name
  end

  def rival(team_id)
    game_ids_by_team_id = []

    game_teams_by_team_ids(@game_team_collection)[team_id].each do |i_team_id|
      game_ids_by_team_id << @game_team_collection.find_all do |games|
        games.game_id == i_team_id.game_id
      end
    end
     
    game_ids_by_team_id

    matches = []

    game_ids_by_team_id.each do |match|
      match.each do |team_stat|
        matches << team_stat if team_stat.team_id != team_id
      end
    end 
    
    opponent_outcomes = Hash.new { | k, v | k[v] = [] }
    
    matches.each do |match|
      opponent_outcomes[match.team_id] << match.result
    end

    opponent_winrates = Hash.new { | k, v | k[v] = 0.0 }

    opponent_outcomes.each do |id, outcomes|
      opponent_winrates[id] += ((outcomes.tally["WIN"].to_f) / (outcomes.tally.values.sum.to_f) * 100).round(2)
    end

    highest_winrate = opponent_winrates.max_by do |id, percentage|
      percentage
    end
    
    favorite_opponent = @team_collection.find do |team|
      team.team_id == highest_winrate[0]
    end
    
    favorite_opponent.team_name
  end
end
