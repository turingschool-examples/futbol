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

	def find_all_game_id
		@games.map do |row|
			row[:game_id]
		end
	end

	def total_scores
		@games.map do |row|
			row[:away_goals].to_i + row[:home_goals].to_i
		end
	end

	def highest_total_score
		total_scores.max
	end

	def lowest_total_score
		total_scores.min
	end

  def all_team_names
    teams = []
    @teams.map do |row|
      teams << row[:teamName]
    end
  end

  def count_of_teams
    all_team_names.count
  end

  def average_goals_per_game
    average_score = total_scores.sum.to_f / total_scores.count
    average_score.round(2)
  end

	# 
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
	# 

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

	def most_goals_scored(team_id)
		all_game_scores_by_team[team_id.to_s].max
	end
	
	def fewest_goals_scored(team_id)
		all_game_scores_by_team[team_id.to_s].min
	end

	def all_game_scores_by_team
		hash = Hash.new {|k, v| k[v] = []}
		@games.each do |row|
			hash[row[:home_team_id]] << row[:home_goals].to_i
			hash[row[:away_team_id]] << row[:away_goals].to_i
		end
		hash
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
			# require 'pry'; binding.pry
			hash[k] = (v.reduce(&:+) / (v.size.to_f) * 2).round(2)
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

	def tackles_by_team_id(array_of_game_id)
		hash = Hash.new {|k, v| k[v] = []}
		array_of_game_id.each do |game_id|
			games_by_game_id[game_id].each do |game|
				hash[game[:team_id]] << game[:tackles].to_i
			end
		end
		hash
	end

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

  def team_info(team_id)
    team_hash = {}
    find_team_by_id[team_id].each do |row|
      row.headers.each do |header|
        team_hash[header.to_s] = row[header] if header != :stadium
      end
    end
    team_hash
  end

  def best_season(team_id)

  end

  def worst_season(team_id)

  end

  def season_win_percentages(team_id)
    hash = Hash.new {|k, v| k[v] = []}
    array_of_game_id.each do |game_id|
      games_by_game_id[game_id].each do |game|
        hash[game[:head_coach]] << game[:result]
      end
    end
    hash
  end
end
