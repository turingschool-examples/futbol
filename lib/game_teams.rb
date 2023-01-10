require 'csv'

class GameTeams
  attr_reader :game_teams_path, :game_id

  
  def initialize(file_path)
    # @game_teams_path = file_path
    # @game_teams_path = CSV.read(locations[:game_teams], headers: true, skip_blanks: true, header_converters: :symbol)
    @game_id = file_path[:game_id]
    # @team_id = row[:team_id]
    # @HoA = row[:HoA]
    # @result = row[:result]
    # @head_coach = row[:head_coach]
    # @goals = row[:goals]
    # @shots = row[:shots]
    # @tackles = row[:tackles]
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

  def games_by_game_id
    #memoization this @games_by_game_id ||= [everything below]
    @games_by_game_id ||= @game_teams_path.group_by do |row| 
      row[:game_id]
    end
  end

  def all_scores_by_team #HELPER for most and fewest goals scored by
    hash = Hash.new{|k,v| k[v] = []}
    @game_teams_path.each do |row| 
      hash[row[:team_id]] << row[:goals].to_i
    end
    hash
  end

  def teams_by_id
    @game_teams_path.group_by do |row|
      row[:team_id]
    end
  end

  def pair_teams_with_results(team_id)
    hash = Hash.new{|k,v| k[v] = []}
    teams_by_id[team_id].each do |game|
      hash[team_id] << game[:result]
      hash[team_id] << game[:game_id]
    end
    hash.each do |team_id, value|
      hash[team_id] = value.each_slice(2).to_a
    end
    hash
   end

   def pair_season_with_results_by_team(team_id)
    hash = Hash.new{|k,v| k[v] = []}
    pair_teams_with_results(team_id).each do |team, results|
      results.each do |result|
      data = games_by_id_game_path[result[1]][0]
        hash[data[:season]] << result[0]
      end
    end
    hash
  end

  def best_season(team_id)
    best_season_hash = {}
    best = pair_season_with_results_by_team(team_id)
  
    best.each do |season, results|
      best_season_hash[season] = results.count("WIN") / results.count.to_f
    end
    best_season_for_team = best_season_hash.max_by {|k,v| v}
    best_season_for_team[0]
  end
 
  def worst_season(team_id)
    worst_season_hash = {}
    worst = pair_season_with_results_by_team(team_id)
  
    worst.each do |season, results|
      worst_season_hash[season] = results.count("WIN") / results.count.to_f
    end
    worst_season_for_team = worst_season_hash.min_by {|k,v| v}
    worst_season_for_team[0]
  end

  def average_win_percentage(team_id)
    average_hash = Hash.new{|k,v| k[v] = []}
    team_games = teams_by_id[team_id]
    team_games.each do |game|
      average_hash[team_id] << game[:result] if game[:result] == 'WIN'
    end
    average_win_percent = (average_hash.values[0].count('WIN') / team_games.count.to_f).round(2)
  end
end