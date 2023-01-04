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
    average_score.round(3)
  end

  def average_win_percentage(team_id)
    games_played = []
    games_won = []

    @game_teams.each do |row|
      if row[:team_id].to_i == team_id
        games_played << row[:game_id]
      end
    end
    @game_teams.map do |row|
      if row[:team_id].to_i == team_id && row[:result] == "WIN"
        games_won << row[:game_id]
      end
    end
    win_percentage = games_won.count.to_f / games_played.count
    win_percentage.round(3)
  end

	def percentage_home_wins
		h_wins = @game_teams.count do |row|
			row if row[:hoa] == "home" && row[:result] == "WIN"
		end
		(h_wins/@game_teams.count.to_f).round(2)
	end

	def percentage_visitor_wins
		v_wins = @game_teams.count do |row|
			row if row[:hoa] == "away" && row[:result] == "WIN"
		end
		(v_wins/@game_teams.count.to_f).round(2)
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
		@games.map do |row|
			row[:season]
		end.tally
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

	def winingest_coach(season_id)
		games = games_played_by_season(season_id)
		require 'pry'; binding.pry
		games.each do |row|
			coach_game_info_by_game(row[:game_id])
		end
	end
  
	def games_played_by_season(season_id)
		@games.find_all do |row|
			row[:season] == season_id.to_s
		end
	end

	def coach_game_info_by_game(game_id)
		hash = Hash.new {|k, v| k[v] = []}
		@game_teams.each do |row|
			if row[:game_id] == game_id
				require 'pry'; binding.pry
				hash[row[:head_coach]] << row[:result]
			end
		end
		require 'pry'; binding.pry
		hash
	end
end
