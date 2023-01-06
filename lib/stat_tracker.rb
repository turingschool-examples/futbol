require 'csv'
class StatTracker
  attr_reader :game_path,
              :team_path,
              :game_teams_path

  def initialize(locations)
    @game_path = CSV.read(locations[:games], headers: true, skip_blanks: true, header_converters: :symbol)
    @team_path = CSV.read(locations[:teams], headers: true, skip_blanks: true, header_converters: :symbol)
    @game_teams_path = CSV.read(locations[:game_teams], headers: true, skip_blanks: true, header_converters: :symbol)
    
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def all_scores #HELPER for highest_total_score and lowest_total_score
   @game_path.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end
  end

  def highest_total_score 
    all_scores.max
  end

  def lowest_total_score 
    all_scores.min
  end

  def home_wins_array #HELPER for percentage_home_wins
    @game_path.find_all do |row|
     row[:home_goals].to_i > row[:away_goals].to_i
    end
  end

  def percentage_home_wins 
    wins = home_wins_array.count
    (wins.to_f / @game_path.count).round(2)
  end

  def visitor_wins_array #HELPER for percentage_visitor_wins
    @game_path.find_all do |row|
        row[:away_goals].to_i > row[:home_goals].to_i
    end
  end

  def percentage_visitor_wins
    visitor_wins = visitor_wins_array.count
    (visitor_wins.to_f / @game_path.count).round(2)
  end

	def ties_array #Helper percentage_ties
		@game_path.find_all do |row|
			row[:away_goals].to_i == row[:home_goals].to_i
		end
	end

	def percentage_ties
		ties = ties_array.count
		(ties.to_f / @game_path.count).round(2)
	end

	def count_of_games_by_season
		season_id = @game_path.group_by { |row| row[:season] }
		season_id.each do |season, game|
			season_id[season] = game.count
		end
	end
   
  def average_goals_per_game
    (all_scores.sum / @game_path.count.to_f).round(2)
  end

  def average_goals_by_season
    games_group_by_season = @game_path.group_by { |row| row[:season] }
    average_season_goals = {}
    games_group_by_season.each do |season, games|
     total_goals = games.sum do |game|
        game[:away_goals].to_i + game[:home_goals].to_i
      end
      average_season_goals[season] = (total_goals / games.count.to_f).round(2)
    end
    average_season_goals
  end

  def count_of_teams
    @team_path.count
  end

  def best_offense
    best = average_goals_by_team_hash.max_by {|k,v| v}

    @team_path.map do |team| 
      if team[:team_id] == best[0]
        team[:teamname]
      end
    end.compact.pop
  end

  def worst_offense 
     worst = average_goals_by_team_hash.min_by {|k,v| v}
     
     @team_path.map do |team| 
      if team[:team_id] == worst[0]
        team[:teamname]
      end
    end.compact.pop
  end

  def average_goals_by_team_hash #HELPER for best and worst offense methods
    games_grouped_by_team = @game_teams_path.group_by {|row| row[:team_id]}
    average_goals_per_team = {}

    games_grouped_by_team.each do |team, games| 
      total_goals = games.sum do |game| 
        game[:goals].to_i 
      end
      average_goals_per_team[team] = (total_goals / games.count.to_f).round(2)
    end
    average_goals_per_team
  end

	def visitor_scores_hash
		games_grouped_by_away_team = @game_teams_path.group_by {|row| row[:team_id]}
		average_away_goals_per_team = {}

		games_grouped_by_away_team.each do |team, games|
			average_away_goals_per_team[team] = 0
				games.each do |game|
				average_away_goals_per_team[team] += game[:goals].to_i if game[:hoa] == "away"
			end
			average_away_goals_per_team[team] = (average_away_goals_per_team[team].to_f / games.size).round(2)
		end
		average_away_goals_per_team
	end

	def home_scores_hash
		games_grouped_by_home_team = @game_teams_path.group_by {|row| row[:team_id]}
		average_home_goals_per_team = {}

		games_grouped_by_home_team.each do |team, games|
			average_home_goals_per_team[team] = 0
				games.each do |game|
				average_home_goals_per_team[team] += game[:goals].to_i if game[:hoa] == "home"
			end
			average_home_goals_per_team[team] = (average_home_goals_per_team[team].to_f / games.size).round(2)
		end
		average_home_goals_per_team
	end

	def highest_scoring_visitor
		visitor_highest = visitor_scores_hash.max_by {|k,v| v }
		@team_path.map do |team| 
      if team[:team_id] == visitor_highest[0]
        team[:teamname]
      end
    end.compact.pop
	end

	def lowest_scoring_visitor
		visitor_lowest = visitor_scores_hash.min_by {|k,v| v}
		@team_path.map do |team| 
      if team[:team_id] == visitor_lowest[0]
        team[:teamname]
      end
    end.compact.pop
	end

	def highest_scoring_home_team
		home_highest = home_scores_hash.max_by { |k, v| v }
		@team_path.map do |team|
			if team[:team_id] == home_highest[0]
				team[:teamname]
			end
		end.compact.pop
	end

	def lowest_scoring_home_team
		home_lowest = home_scores_hash.min_by {|k,v| v}
		@team_path.map do |team| 
      if team[:team_id] == home_lowest[0]
        team[:teamname]
      end
    end.compact.pop
	end

  # def winningest_coach(season_id)
  #   #coach_winning_game_by_season_hash(season_id).invert.max_by {|k,v| v}.pop
  # end

  # def worst_coach(season_id)
  #   coach_winning_game_by_season_hash(season_id).min_by {|k,v| k} 
  # end

  # def coach_winning_game_by_season_hash(season_id)
 
  #   #season_wins_by_coach = Hash.new(0)
  #   season_wins_by_coach = {}
  #   by_season(season_id).each do |season_game|
  #     wins_by_coach.each do |coach, coach_games| 
  #     next if coach_games.empty? == true
  #       coach_games.each do |game|
  #         if season_game[:game_id] == game[:game_id]
  #           season_wins_by_coach[coach] = coach_games.count
  #         end
  #       end
  #     end
  #   end
    
  #   season_wins_by_coach.each do |coach, wins| 
  #     thing = (wins / by_season(season_id).count.to_f).round(2)
  #     season_wins_by_coach[coach] = thing
  #   end
  #   season_wins_by_coach
  
  # end

  def games_by_season
    @games_by_season ||= @game_path.group_by do |row|
      row[:season] 
    end
  end

  def games_by_game_id
    #memoization this
    @game_teams_path.group_by do |row| 
      row[:game_id]
    end
  end

  def game_ids_by_season(season_id)
    games_by_season[season_id].map do |games|
      games[:game_id]
    end
  end

  def wins_by_coach(game_id_array)
    hash = Hash.new{|k, v| k[v] = []}
    game_id_array.each do |game_id|
      next if games_by_game_id[game_id].nil?
      games_by_game_id[game_id].each do |game|
        hash[game[:head_coach]] << game[:result]
      end
    end
    hash 
  end

  def winningest_coach(season_id)
    coach_results = wins_by_coach(game_ids_by_season(season_id)) 
     coach_results.each do |coach, results| 
      coach_results[coach] = (results.count("WIN") / (results.count.to_f / 2))
     end
     coach_results.invert[coach_results.invert.keys.max]
  end

  def worst_coach(season_id)
    coach_results = wins_by_coach(game_ids_by_season(season_id)) 
     coach_results.each do |coach, results| 
      coach_results[coach] = (results.count("WIN") / (results.count.to_f / 2))
     end
     coach_results.invert[coach_results.invert.keys.min]
  end



  

  # def wins_by_coach 
  #   grouped_by_coach = @game_teams_path.group_by {|row| row[:head_coach]}

  #   wins_by_coach = {}

  #   grouped_by_coach.each do |coach, games| 
  #     winner = games.find_all do |game| 
  #       game[:result] == "WIN" && game[:result] != "TIE"
  #     end
  #     wins_by_coach[coach] = winner 
  #   end
  #   wins_by_coach
    
  # end

 
end