require 'csv'
require_relative 'game_teams'

class StatTracker
  attr_reader :game_path,
              :team_path,
              :game_teams_path

  def initialize(locations)
    @game_path = CSV.read(locations[:games], headers: true, skip_blanks: true, header_converters: :symbol)
    @team_path = CSV.read(locations[:teams], headers: true, skip_blanks: true, header_converters: :symbol)
    @game_teams_path = CSV.read(locations[:game_teams], headers: true, skip_blanks: true, header_converters: :symbol)
    @game_teams = GameTeams.new(@game_teams_path, @game_path, @team_path)
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

  def average_goals_by_team_hash #HELPER for best and worst offense methods #moved to gameteams
    @game_teams.average_goals_by_team_hash
  end

	def visitor_scores_hash #moved to gameteams
    @game_teams.visitor_scores_hash
	end

	def home_scores_hash # moved to gameteams
    @game_teams.home_scores_hash
	end

	def highest_scoring_visitor #moved to gameteams
    @game_teams.highest_scoring_visitor
	end

	def lowest_scoring_visitor #moved to gameteams
    @game_teams.lowest_scoring_visitor
	end

	def highest_scoring_home_team #moved to gameteams
    @game_teams.highest_scoring_home_team
	end

	def lowest_scoring_home_team #moved to gameteams
    @game_teams.lowest_scoring_home_team
	end

  def games_by_season
    @game_teams.games_by_season
  end

  def games_by_game_id #moved to gameteams
    #memoization this @games_by_game_id ||= [everything below]
    @game_teams.games_by_game_id
  end

  def game_ids_by_season(season_id)
    @game_teams.game_ids_by_season(season_id)
  end

  def wins_by_coach(game_id_array) #HELPER for winningest and worst coach #moved to gameteams
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

  def most_tackles(season_id)
    @game_teams.most_tackles(season_id)
  end

  def fewest_tackles(season_id) #moved to gameteams
    @game_teams.fewest_tackles(season_id)
  end

  def teams_with_tackles(games_array) #HELPER for most and fewest tackles
    @game_teams.teams_with_tackles(games_array)
  end

  def all_scores_by_team #HELPER for most and fewest goals scored by #moved to gameteams #moved to gameteams
    @game_teams.all_scores_by_team
  end

  def most_goals_scored(team_id)  #moved to gameteams
    @game_teams.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id) #moved to gameteams
    @game_teams.fewest_goals_scored(team_id)
  end

  def get_ratios_by_season_id(season_id) #moved to gameteams
    @game_teams.get_ratios_by_season_id(season_id)
  end

  def most_accurate_team(season_id) #moved to gameteams
    @game_teams.most_accurate_team(season_id)
  end

  def least_accurate_team(season_id) #moved to gameteams
    @game_teams.least_accurate_team(season_id)
  end

  def team_shots_by_season(season_id) #moved to gameteams
    @game_teams.team_shots_by_season(season_id)
  end

  def team_goals_by_season(season_id) #moved to gameteams
    @game_teams.team_goals_by_season(season_id)
  end

  def team_info(team_id)
    hash = Hash.new
    @team_path.map do |row|
      if team_id == row[:team_id]
     hash["team_id"] = row[:team_id]
     hash["franchise_id"] = row[:franchiseid]
     hash["team_name"] = row[:teamname]
     hash["abbreviation"] = row[:abbreviation]
     hash["link"] = row[:link]
    end
  end
  hash
  end
 
  def teams_by_id #moved to gameteams
    @game_teams.teams_by_id
  end
 
  def games_by_id_game_path
    @game_teams.games_by_game_id
  end
 
  def pair_teams_with_results(team_id) #moved to gameteams
    @game_teams.pair_teams_with_results(team_id)
  end
 
  def pair_season_with_results_by_team(team_id) #moved to gameteams
    @game_teams.pair_season_with_results_by_team(team_id)
  end
 
  def best_season(team_id) #moved to gameteams
    @game_teams.best_season(team_id)
  end

  def worst_season(team_id) #moved to gameteams
    @game_teams.worst_season(team_id)
  end

  def average_win_percentage(team_id) #moved to gameteams
    @game_teams.average_win_percentage(team_id)
  end
end