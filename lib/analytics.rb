require_relative './game_team_collection'
require_relative './game_collection'
require_relative './team_collection'

module Analytics
  include GameCollection
  include TeamCollection
  include GameTeamCollection

  def csv_read(locations_path, class_arg)
    CSV.foreach(locations_path, headers: true, header_converters: :symbol) do |row|
	    class_arg.new(row)
	  end
  end

  def find_average(collection, hash1, hash2, id1, id2)
    collection.each do |element|
      teams_total_scores[game_team.team_id] += game_team.goals.to_f
      teams_total_games[game_team.team_id] += 1.0
    end
  end

  def total_teams_average(game_team_collection)
    teams_total_scores = Hash.new{0}
    teams_total_games = Hash.new{0}
    teams_total_averages = Hash.new{0}
    
    add_total_score_and_games(game_team_collection, teams_total_scores, teams_total_games)
    
    teams_total_scores.each do |key, value|
      teams_total_averages[key] = (value / teams_total_games[key].to_f).round(5)
    end
    
    teams_total_averages
  end

  def total_away_teams_average(game_collection)
    teams_total_away_scores = Hash.new{0}
    teams_total_away_games = Hash.new{0}
    teams_total_away_averages = Hash.new{0}
    
    add_total_away_score_and_away_games(game_collection, teams_total_away_scores, teams_total_away_games)
    
    teams_total_away_scores.each do |key, value|
      teams_total_away_averages[key] = (value / teams_total_away_games[key].to_f).round(5)
    end

    teams_total_away_averages
  end

  def total_home_teams_average(game_team_collection)
    teams_total_home_scores = Hash.new{0}
    teams_total_home_games = Hash.new{0}
    teams_total_home_averages = Hash.new{0}
    
    add_total_home_score_and_home_games(game_collection, teams_total_home_scores, teams_total_home_games)
    
    teams_total_home_scores.each do |key, value|
      teams_total_home_averages[key] = (value / teams_total_home_games[key].to_f).round(5)
    end

    teams_total_home_averages
  end

  def find_coach(season, game_team_collection, game_collection)    
		outcomes_by_game_id = []
    results_by_coach = Hash.new { | k, v | k[v] = [] }

    game_ids_by_season(game_collection)[season].each do |id|
			outcomes_by_game_id << game_team_collection.find_all do |game| 
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
      
      coach_winrate = (wins.to_f / (game_ids_by_season(game_collection)[season].count).to_f)
      results_by_coach[coach_name] = coach_winrate
    end

    results_by_coach
	end

  def team_accuracy(season_id, game_collection, game_team_collection)
    variable = []
		game_ids_by_season = Hash.new { | k, v | k[v]= [] }

		game_collection.each do |game|
		  game_ids_by_season[game.season] << game.game_id
		end

		game_ids_by_season[season_id].each do |id|
			variable << game_team_collection.find_all {|row| row.game_id == id}
		end

		total_goals_by_team = Hash.new { | k, v | k[v]= 0.0 }
		total_shots_by_team = Hash.new { | k, v | k[v]= 0.0 }

		variable.flatten(1).each do |row|
				total_goals_by_team[row.team_id] += row.goals.to_f
				total_shots_by_team[row.team_id] += row.shots.to_f
		end

		teams_and_accuracy = Hash.new { | k, v | k[v]= 0.0 }

		total_shots_by_team.each do |team_id, total_shots|
			teams_and_accuracy[team_id] = (total_shots/total_goals_by_team[team_id])
		end

		teams_and_accuracy
	end
end