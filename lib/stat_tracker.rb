require 'csv'
require './lib/stats.rb'

class StatTracker 
  attr_reader :game_stats,
              :league_stats
  def initialize(locations)
    @game_stats = GameStats.new(locations)
    @league_stats = LeagueStats.new(locations)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end
 
  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season
  end

  def average_goals_per_game 
    @game_stats.average_goals_per_game
  end
 
  def average_goals_by_season
    @game_stats.average_goals_by_season
  end

  def count_of_teams
    @league_stats.count_of_teams
  end

  def best_offense
    @league_stats.best_offense
  end

  def worst_offense
    @league_stats.worst_offense
  end

  def away_team_goals
    @league_stats.away_team_goals
  end

  def home_team_goals
    @league_stats.home_team_goals
  end

  def highest_scoring_visitor
    @league_stats.highest_scoring_visitor
  end
 
  def highest_scoring_home_team
    @league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_stats.lowest_scoring_home_team
  end

  def winningest_coach(season)
    ratios = determine_coach_ratios(season)
    ratios.reverse.first.first
  end 

  def worst_coach(season)
    ratios = determine_coach_ratios(season)
    ratios.first.first
  end 

  def determine_coach_ratios(season)
    games_in_season = list_gameteams_from_particular_season(season)
    coach_hash = coach_victory_percentage_hash(games_in_season)
    ratios = determine_sorted_ratio(coach_hash)
  end 

  def list_gameteams_from_particular_season(season)
    games_in_season = list_games_per_season(season)
    pull_gameids = games_in_season.map {|game| game[:game_id]} 

    pull_gameids.flat_map do |game_id|
      game_teams.find_all {|game_team| game_id == game_team[:game_id]}
    end
  end 

  def list_games_per_season(season)
    games.find_all {|game| game[:season] == season} 
  end

  def coach_victory_percentage_hash(games_in_season)
    coach= Hash.new{ |hash, key| hash[key] = [0,0] }

    games_in_season.each do |game_team|
      coach[game_team[:head_coach]][1] += 1
      if game_team[:result] == "WIN"
        coach[game_team[:head_coach]][0] += 1
      end
     end
    return coach
  end 

  def determine_sorted_ratio(hash)
    calculations = []
    hash.each {|key, value| calculations << [key, ((value[0].to_f)/(value[1].to_f))]}
    result = calculations.to_h.sort_by {|key, value| value}
  end

  def all_games_by_season
    @games.group_by { |game| game[:season] } 
  end

  def team_goals_shots_by_season(season)
    team_goals_shots = Hash.new { |hash, key| hash[key] = [0, 0] }
    @game_teams.each do |game_team|
      all_games_by_season[season].each do |game|
        if game_team[:game_id] == game[:game_id]
          team_goals_shots[game_team[:team_id]][0] += game_team[:goals]
          team_goals_shots[game_team[:team_id]][1] += game_team[:shots]
        end
      end
    end
    return team_goals_shots
  end

  def team_ratios_by_season(hash)
    calculations = []
    hash.each do |key, value|
      calculations << [key, ((value[0].to_f)/(value[1].to_f))]
    end
    result = calculations.to_h.sort_by { |key, value| value } 
  end

  def team_name(id)
    @teams.each do |team|
        return team[:team_name] if team[:team_id] == id 
    end
  end

  def most_accurate_team(season)
    hash = team_goals_shots_by_season(season)
    result_hash = team_ratios_by_season(hash)
    id = result_hash.reverse.first.first
    team_name(id)
  end

  def least_accurate_team(season)
    hash = team_goals_shots_by_season(season)
    result_hash = team_ratios_by_season(hash)
    id = result_hash.first.first
    team_name(id)
  end


  def all_games_by_season
    @games.group_by { |game| game[:season] } 
  end

  def gather_tackles_by_team(season)
    team_tackle_hash = Hash.new { |hash, key| hash[key] = 0 }
    @game_teams.each do |info_line|
      all_games_by_season[season].each do |info_line_2|
        if info_line_2[:game_id] == info_line[:game_id]
          team_tackle_hash[info_line[:team_id]] += info_line[:tackles]
        end
      end
    end
    return team_tackle_hash.sort_by {|key, value| value}
  end

  def most_tackles(season)
    total_tackles_per_team = gather_tackles_by_team(season)
    id = total_tackles_per_team.reverse.first.first
    team_name(id)
  end

  def fewest_tackles(season)
    total_tackles_per_team = gather_tackles_by_team(season)
    id = total_tackles_per_team.first.first
    team_name(id)
  end

 ################## Team Statisics ##################
 
 def team_info(team_id)
  selected = teams.select do |team| 
    team[:team_id] == team_id 
  end 
  team = selected[0]
  
  hash = {
    "team_id"=> team[:team_id], 
    "franchise_id"=> team[:franchise_id], 
    "team_name"=> team[:team_name], 
    "abbreviation"=> team[:abbreviation], 
    "link"=> team[:link]
  }
  return hash
  end

  def best_season(team_id)
    season_array = ordered_season_array(team_id)
    season_array.sort.reverse[0][1]
  end 

  def worst_season(team_id)
    season_array = ordered_season_array(team_id)
    season_array.sort[0][1]
  end

  def ordered_season_array(team_id)
    relevant_game_teams = find_relevant_game_teams_by_teamid(team_id)
    relevant_games = find_corresponding_games_by_gameteam(relevant_game_teams)
    results_by_season = group_by_season(relevant_games, relevant_game_teams) 
    season_array = order_list(results_by_season)
  end

  def find_relevant_game_teams_by_teamid(team_id)
    game_teams.find_all { |game_team| game_team[:team_id] == team_id }
  end 

  def find_corresponding_games_by_gameteam(relevant_game_teams)
    games.find_all do |game|
      relevant_game_teams.each {|game_team| game_team[:game_id] == game[:game_id]} 
      end
  end
   
  def group_by_season(relevant_games, relevant_game_teams)
    results_by_season = Hash.new{ |hash, key| hash[key] = [] }
    grouped = relevant_games.group_by { |game| game[:season]}

    grouped.each do |key, values|
      values.each do |value|
      relevant_game_teams.each do |game_team|
          if value[:game_id] == game_team[:game_id]
            results_by_season[key] << game_team[:result]
          end
        end
      end
    end
    return results_by_season 
  end 

  def order_list(hash_seasons)
    season_array = []
    hash_seasons.each do |key, value|
      season_array << [(value.count("WIN").to_f/value.count.to_f), key]
    end
    return season_array
  end

  def average_win_percentage(team_id)
    relevant_games = find_relevant_game_teams_by_teamid(team_id)
    victories = 0 
    relevant_games.each do |game|
      if game[:result] == "WIN"
        victories += 1 
      end
    end
  
    percent = ((victories.to_f)/((relevant_games.count).to_f)).round(2) 
  end

  def most_goals_scored(team_id) 
    relevant_games = find_relevant_game_teams_by_teamid(team_id)
    goals = create_goals_array(relevant_games)
    return goals.max 
  end

  def fewest_goals_scored(team_id)
    relevant_games = find_relevant_game_teams_by_teamid(team_id)
    goals = create_goals_array(relevant_games)
    return goals.min 
  end 

  def create_goals_array(relevant_games)
    goals = []
    relevant_games.each {|game| goals << game[:goals]}
    return goals 
  end

  def favorite_opponent(team_id)
    sorted_array = sorted_array_of_opponent_win_percentages(team_id)
    result_id = sorted_array.reverse.first.first
    determine_team_name_based_on_team_id(result_id)
  end

  def rival(team_id)
    sorted_array = sorted_array_of_opponent_win_percentages(team_id)
    result_id = sorted_array.first.first
    determine_team_name_based_on_team_id(result_id)
  end

  def sorted_array_of_opponent_win_percentages(team_id)
    relevant_game_teams = find_relevant_game_teams_by_teamid(team_id)
    relevant_games = find_relevant_games_based_on_game_team_hashes(relevant_game_teams)
    hashed_info = hashed_info(relevant_games, relevant_game_teams, team_id)
    array = accumulate_hash(hashed_info)
    sorted = sort_based_on_value(array)
  end

  def find_relevant_games_based_on_game_team_hashes(relevant_game_teams)
    relevant_games = []
    games.each do |game|
      relevant_game_teams.each do |game_team|
        if game[:game_id] == game_team[:game_id]
          relevant_games << game 
        end
      end
    end
    return relevant_games
  end 

  def hashed_info(relevant_games, relevant_game_teams, team_id)
    new_hash = Hash.new { |hash, key| hash[key] = [] }
    relevant_games.each do |game|
      if game[:away_team_id] != team_id 
        new_hash[game[:away_team_id]] << determine_game_outcome(game, relevant_game_teams)
      elsif game[:home_team_id] != team_id
        new_hash[game[:home_team_id]] << determine_game_outcome(game, relevant_game_teams)
      end
    end
    return new_hash
  end

  def determine_game_outcome(game, relevant_game_teams) 
    relevant_game_teams.each do |game_team|
      if game_team[:game_id] == game[:game_id]
        return game_team[:result] 
      end
    end
  end

  def accumulate_hash(hash)
    percentage_data = []
    hash.each {|key, value|percentage_data << [key, ((value.count("WIN").to_f)/(value.count.to_f))]}
    return percentage_data
  end

  def sort_based_on_value(array)
    array.to_h.sort_by {|key, value| value}
  end

  def determine_team_name_based_on_team_id(result_id)
    selected = teams.select { |team| team[:team_id] == result_id }
    selected.first[:team_name]
  end 
end

