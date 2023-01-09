require 'csv'

class StatTracker
	attr_reader :games,
							:teams,
							:game_teams

	def initialize(games, teams, game_teams)
		@games = games
		@teams = teams
		@game_teams = game_teams
	end

	def self.from_csv(multiple_data_paths) # in hash format
		games_data = CSV.read multiple_data_paths[:games], headers: true, header_converters: :symbol
		teams_data = CSV.read multiple_data_paths[:teams], headers: true, header_converters: :symbol
		game_teams_data = CSV.read multiple_data_paths[:game_teams], headers: true, header_converters: :symbol
		StatTracker.new(games_data, teams_data, game_teams_data)
	end

##### GAME STATS
  def average_goals_per_game
    average_score = total_scores.sum.to_f / total_scores.count
    average_score.round(2)
  end

	def highest_total_score
		total_scores.max
	end

	def lowest_total_score
		total_scores.min
	end

	def percentage_home_wins
		h_wins = @game_teams.count do |row|
			row if row[:hoa] == "home" && row[:result] == "WIN"
		end
		(h_wins/@game_teams.count.to_f).round(2)*2
	end

	def percentage_visitor_wins
		v_wins = @game_teams.count do |row|
			row if row[:hoa] == "away" && row[:result] == "WIN"
		end
		(v_wins/@game_teams.count.to_f).round(2)*2
	end

	def percentage_ties
		ties = @game_teams.count do |row|
			row if row[:result] == "TIE"
		end
		(ties/@game_teams.count.to_f).round(2)
	end

	def count_of_games_by_season
		hash = {}
		games_played_by_season.map do |season_id, games|
			hash[season_id] = games.size
		end
		hash
	end

	def average_goals_by_season
		hash = all_game_scores_by_season
		hash.each do |k, v|
			hash[k] = (v.reduce(&:+) / (v.size.to_f) * 2).round(2)
		end
		hash
	end


##### LEAGUE STATS

  def count_of_teams
    teams = []
    @teams.map do |row|
      teams << row[:teamName]
    end
    teams.count
  end

  def best_offense
    hash = Hash.new(0)
    games_by_team_id.each do |team_id, array_of_games|
      hash[team_id] = (array_of_games.sum { |g| g[:goals].to_f})/array_of_games.count
    end
    team_id = hash.key(hash.values.max)
    find_team_by_id[team_id].first[:teamname]
  end

  def worst_offense
    hash = Hash.new(0)
    games_by_team_id.each do |team_id, array_of_games|
      hash[team_id] = (array_of_games.sum { |g| g[:goals].to_f})/array_of_games.count
    end
    team_id = hash.key(hash.values.min)
    find_team_by_id[team_id].first[:teamname]
  end

  def highest_scoring_visitor
    team_id = all_game_scores_by_away_team.key(all_game_scores_by_away_team.values.max)
    find_team_by_id[team_id].first[:teamname]
  end

  def lowest_scoring_visitor
    team_id = all_game_scores_by_away_team.key(all_game_scores_by_away_team.values.min)
    find_team_by_id[team_id].first[:teamname]
  end

  def highest_scoring_home_team
    team_id = all_game_scores_by_home_team.key(all_game_scores_by_home_team.values.max)
    find_team_by_id[team_id].first[:teamname]
  end

  def lowest_scoring_home_team
    team_id = all_game_scores_by_home_team.key(all_game_scores_by_home_team.values.min)
    find_team_by_id[team_id].first[:teamname]
  end

####### SEASON STATS

  def winningest_coach(season_id)
    coach_game_results = coach_game_results_by_game(game_ids_for_season(season_id))
    coach_game_results.each do |k, v|
      coach_game_results[k] = (v.count('WIN') / (games.count / 2).to_f )
    end.key(coach_game_results.values.max)
  end

  def worst_coach(season_id)
    coach_game_results = coach_game_results_by_game(game_ids_for_season(season_id))
    coach_game_results.each do |k, v|
      coach_game_results[k] = (v.count('WIN') / (games.count / 2).to_f )
    end.key(coach_game_results.values.min)
  end

  def most_accurate_team(season_id)
    team_accuracy = accuracy_by_team(game_ids_for_season(season_id))
    team_id = team_accuracy.key(team_accuracy.values.max)
    find_team_by_id[team_id].first[:teamname]
  end

  def least_accurate_team(season_id)
    team_accuracy = accuracy_by_team(game_ids_for_season(season_id))
    team_id = team_accuracy.key(team_accuracy.values.min)
    find_team_by_id[team_id].first[:teamname]
  end

  def most_tackles(season_id)
    tackles_hash = tackles_by_team_id(game_ids_for_season(season_id))
    tackles_hash.each do |k,v|
      tackles_hash[k] = v.sum
    end
    team_id = tackles_hash.key(tackles_hash.values.max)
    find_team_by_id[team_id].first[:teamname]
  end

  def fewest_tackles(season_id)
    tackles_hash = tackles_by_team_id(game_ids_for_season(season_id))
    tackles_hash.each do |k,v|
      tackles_hash[k] = v.sum
    end
    team_id = tackles_hash.key(tackles_hash.values.min)
    find_team_by_id[team_id].first[:teamname]
  end

###### TEAM STATS
  def team_info(team_id)
    team_hash = {
      'team_id' => nil,
      'franchise_id' => nil,
      'team_name' => nil,
      'abbreviation' => nil,
      'stadium' => nil,
      'link' => nil
    }

    find_team_by_id[team_id].each do |row|
      x = 0
      team_hash.each do |info, value|
        team_hash[info] = row[x]
        x += 1
      end
    end
    team_hash.delete('stadium')
    team_hash
  end

  def best_season(team_id)
    games_played_by_team = games_played_by_season.dup
    games_played_by_team.each do |season, games|
      games_list = []
      games.each do |game|
        games_list << game if game[:home_team_id] == team_id || game[:away_team_id] == team_id
      end
      games_won = 0
      games_list.each do |game|
        if game[:away_team_id] == team_id
          games_won += 1 if game[:away_goals] > game[:home_goals]
        elsif game[:home_team_id] == team_id
          games_won += 1 if game[:away_goals] < game[:home_goals]
        end
      end
      games_played_by_team[season] = (games_won.to_f / games_list.count).round(2)
    end
    games_played_by_team.each do |k, value|
      games_played_by_team[k] = 0 if value.nan?
    end
    games_played_by_team.key(games_played_by_team.values.max)
  end

  def worst_season(team_id)
    games_played_by_team = games_played_by_season.dup
    games_played_by_team.each do |season, games|
      games_list = []
      games.each do |game|
        games_list << game if game[:home_team_id] == team_id || game[:away_team_id] == team_id
      end
      games_won = 0
      games_list.each do |game|
        if game[:away_team_id] == team_id
          games_won += 1 if game[:away_goals] > game[:home_goals]
        elsif game[:home_team_id] == team_id
          games_won += 1 if game[:away_goals] < game[:home_goals]
        end
      end
      games_played_by_team[season] = (games_won.to_f / games_list.count).round(2)
    end
    # THIS CODE BLOCK IS ONLY FOR TESTING AGAINST SMALL DATA SET
    games_played_by_team.each do |k, value|
      games_played_by_team[k] = 0 if value.nan?
    end
    games_played_by_team.key(games_played_by_team.values.min)
  end

  def average_win_percentage(team_id)
    games_played = []
    games_won = []

    @game_teams.each do |row|
      if row[:team_id].to_i == team_id.to_i
        games_played << row[:game_id]
      end
    end
    @game_teams.map do |row|
      if row[:team_id].to_i == team_id.to_i && row[:result] == "WIN"
        games_won << row[:game_id]
      end
    end
    win_percentage = games_won.count.to_f / games_played.count
    win_percentage.round(2)
  end

  def most_goals_scored(team_id)
    all_game_scores_by_team[team_id.to_s].max
  end

  def fewest_goals_scored(team_id)
    all_game_scores_by_team[team_id.to_s].min
  end

  def rival(team_id)
    win_or_loss(team_id, 'WIN')
  end

  def favorite_opponent(team_id)
    win_or_loss(team_id, 'LOSS')
  end

###### HELPER METHODS
	def total_scores
		@games.map do |row|
			row[:away_goals].to_i + row[:home_goals].to_i
		end
	end

	def all_game_scores_by_team
		hash = Hash.new {|k, v| k[v] = []}
		@games.each do |row|
			hash[row[:home_team_id]] << row[:home_goals].to_i
			hash[row[:away_team_id]] << row[:away_goals].to_i
		end
		hash
	end

	def all_game_scores_by_season
		hash = Hash.new {|k, v| k[v] = []}
		@games.each do |row|
			hash[row[:season]] << row[:home_goals].to_i
			hash[row[:season]] << row[:away_goals].to_i
		end
		hash
	end

	def find_team_by_id
		@find_team_by_id ||= @teams.group_by do |row|
			row[:team_id]
		end
	end

	def tackles_by_team_id(array_of_game_id)
		tackles = Hash.new {|k, v| k[v] = []}
		array_of_game_id.each do |game_id|
			games_by_game_id[game_id].each do |game|
				tackles[game[:team_id]] << game[:tackles].to_i
			end
		end
		tackles
	end

	def game_ids_for_season(season_id)
		games = games_played_by_season[season_id.to_s]
		games.map do |row|
			row[:game_id]
		end
  end
  
	def games_played_by_season
		@games_played_by_season ||= @games.group_by do |row|
			row[:season]
		end
  end

	def coach_game_results_by_game(array_of_game_id)
		hash = Hash.new {|k, v| k[v] = []}
		array_of_game_id.each do |game_id|
			games_by_game_id[game_id].each do |game|
				hash[game[:head_coach]] << game[:result]
			end
		end
		hash
	end

	def games_by_game_id
		@games_by_game_id ||= @game_teams.group_by do |row|
			row[:game_id]
		end
	end

	def win_or_loss(team_id, win_loss_string)
		opponent_games = games_of_opposite_team(team_id)
		opponent_results = opponent_game_results(opponent_games)
		opponent_results.each do |k,v|
			opponent_results[k] = (v.count(win_loss_string).to_f / v.count).round(2)
		end
		team_id = opponent_results.key(opponent_results.values.max)
		find_team_by_id[team_id].first[:teamname]
	end

	def opponent_game_results(opponent_games)
		opponent_results = Hash.new {|k,v| k[v] = []}
		opponent_games.each do |game_id, game|
			opponent_results[game[:team_id]] << game[:result]
		end
		opponent_results
	end

	def games_of_opposite_team(team_id)
		all_games_by_team = games_by_team_id[team_id.to_s].find_all do |game|
			game[:team_id] == team_id.to_s
		end
		opponent_games = {}
		all_games_by_team.each do |game|
			game = games_by_game_id[game[:game_id]].find {|element| element[:team_id] != team_id.to_s}
			opponent_games[game[:game_id]] = game
		end
		opponent_games
	end

	def games_by_team_id
		@games_by_team_id ||= @game_teams.group_by do |row|
			row[:team_id] 
		end
	end

	def all_game_scores_by_away_team
		hash = Hash.new {|k, v| k[v] = []}
		@games.each do |row|
			hash[row[:away_team_id]] << row[:away_goals].to_i
		end
		hash.each do |team, goals|
      hash[team] = (goals.sum.to_f / goals.count).round(2)
		end
	end

  def all_game_scores_by_home_team
		hash = Hash.new {|k, v| k[v] = []}
		@games.each do |row|
			hash[row[:home_team_id]] << row[:home_goals].to_i
		end
		hash.each do |team, goals|
      hash[team] = (goals.sum.to_f / goals.count).round(2)
		end
	end

	def game_ids_for_season(season_id)
		games = games_played_by_season[season_id.to_s]
		games.map do |row|
			row[:game_id]
		end
  end

	def accuracy_by_team(array_of_game_id)
		hash = Hash.new {|k, v| k[v] = [0.0,0.0]}
		array_of_game_id.each do |game_id|
			games_by_game_id[game_id].each do |game|
				hash[game[:team_id]][0] += game[:goals].to_f
				hash[game[:team_id]][1] += game[:shots].to_f
			end
		end
		hash.each do |team_id, array|
			hash[team_id] = hash[team_id].reduce(&:/)
		end
	end

end