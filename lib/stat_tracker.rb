require 'csv'
require_relative 'game'

require_relative 'team'

class StatTracker
  attr_reader :game_path,
              :team_path,
              :game_teams_path
              :game

              
  def initialize(locations)
    @game_path = CSV.read(locations[:games], headers: true, skip_blanks: true, header_converters: :symbol)
    @team_path = CSV.read(locations[:teams], headers: true, skip_blanks: true, header_converters: :symbol)
    @game_teams_path = CSV.read(locations[:game_teams], headers: true, skip_blanks: true, header_converters: :symbol)
    @game = Game.new(@game_path)
  @team = Team.new(@team_path, @game_teams_path, @game_path)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end


  def highest_total_score #move to game class
    @game.highest_total_score
  end

  def lowest_total_score #move to game class
    @game.lowest_total_score
  end

  def percentage_home_wins #move to game class
    @game.percentage_home_wins
  end

  def percentage_visitor_wins #move to game class
    @game.percentage_visitor_wins
  end

	def percentage_ties #move to game class
    @game.percentage_ties
	end

	def count_of_games_by_season #move to game class
    @game.count_of_games_by_season
	end
   
  def average_goals_per_game #move to game class
    @game.average_goals_per_game
  end

  def average_goals_by_season #move to game class
    @game.average_goals_by_season
  end
  #-------------------------------------------------------

  def count_of_teams 
    @team.count_of_teams
  end

  def best_offense 
    @team.best_offense
  end

  def worst_offense 
    @team.worst_offense
  end

	def highest_scoring_visitor 
		@team.highest_scoring_visitor
	end

	def lowest_scoring_visitor 
		@team.lowest_scoring_visitor
	end

	def highest_scoring_home_team 
		@team.highest_scoring_home_team
	end

	def lowest_scoring_home_team 
		@team.lowest_scoring_home_team
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

  def most_tackles(season_id) 
    @team.most_tackles(season_id)
  end

  def fewest_tackles(season_id)  
    @team.fewest_tackles(season_id)
  end

  def all_scores_by_team 
    hash = Hash.new{|k,v| k[v] = []}
    @game_teams_path.each do |row| 
      hash[row[:team_id]] << row[:goals].to_i
    end
    hash
  end

  def most_goals_scored(team_id)
    all_scores_by_team[team_id.to_s].max
  end

  def fewest_goals_scored(team_id)
    all_scores_by_team[team_id.to_s].min
  end


  def most_accurate_team(season_id) 
    @team.most_accurate_team(season_id)
  end

  def least_accurate_team(season_id) 
    @team.least_accurate_team(season_id)
  end

  def team_info(team_id) #moved to teams path
    @team.team_info(team_id)
  end
 
 def teams_by_id
   @game_teams_path.group_by do |row|
     row[:team_id]
   end
 end
 
 def games_by_id_game_path
   @games_by_id_game_path ||= @game_path.group_by do |row|
     row[:game_id]
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

  def games_by_game_id 
    @games_by_game_id ||= @game_teams_path.group_by do |row|
      row[:game_id]
    end
  end

  def games_by_team_id 
    @games_by_team_id ||= @game_teams_path.group_by do |row|
      row[:team_id]
    end
  end

  def win_average_helper(team_id)
    
    opponents_games = games_by_team_id[team_id].flat_map do |game|
      games_by_game_id[game[:game_id]].select { |element| element[:team_id]!= team_id }
    end
    results_hash = opponents_games.group_by {|game| game[:team_id]}
      results_hash.map do |team, games|
        game_result =  games.find_all {|game| game[:result] == 'WIN'}
        
        [((game_result.count.to_f / games.count) * 100).round(2), team]
      end
  end

  def favorite_opponent(team_id)
   opponent_id = win_average_helper(team_id).min.last
   @team.team_name_by_team_id(opponent_id)
  end

  def rival(team_id)
    rival_id = win_average_helper(team_id).max.last
    @team.team_name_by_team_id(rival_id)
  end

  def team_name_by_team_id(team_id)
    @team.team_name_by_team_id(team_id)
  end

end