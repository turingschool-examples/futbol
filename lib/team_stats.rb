require_relative './stats'
require_relative './statistics_module'

class TeamStats < Stats
  include Statistacable

  def initialize(locations)
    super
  end

  def team_info(team_id)
    selected = @teams.select { |team| team.team_id == team_id } 
    team = selected[0]

    hash = {
      "team_id"=> team.team_id, 
      "franchise_id"=> team.franchise_id, 
      "team_name"=> team.team_name, 
      "abbreviation"=> team.abbreviation, 
      "link"=> team.link
    }
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
    results_by_season = group_by_season(relevant_game_teams) 
    season_array = order_list(results_by_season)
  end

  def group_by_season(relevant_game_teams)
    results_by_season = Hash.new{ |hash, key| hash[key] = [] }
    grouped = games.group_by { |game| game.season}
    grouped.each do |key, values|
      values.each do |value|
      relevant_game_teams.each do |game_team|
          if value.game_id == game_team.game_id
            results_by_season[key] << game_team.result
          end
        end
      end
    end
    return results_by_season 
  end 

  def order_list(hash_seasons)
    season_array = []
    hash_seasons.each do |key, value|
      season_array << [(value.count("WIN").to_f/value.count.to_f).round(4), key]
    end
    return season_array
  end

  def average_win_percentage(team_id)
    relevant_games = find_relevant_game_teams_by_teamid(team_id)
    victories = 0 
    relevant_games.each do |game|
      if game.result == "WIN"
        victories += 1 
      end
    end
    percent = ((victories.to_f)/((relevant_games.count).to_f)).round(2) 
  end

  def find_relevant_game_teams_by_teamid(team_id)
    game_teams.find_all { |game_team| game_team.team_id == team_id }
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
    relevant_games.each {|game| goals << game.goals}
    return goals 
  end

  def favorite_opponent(team_id)
    sorted_array = sorted_array_of_opponent_win_percentages(team_id)
    result_id = sorted_array.reverse.first[1]
    determine_team_name_based_on_team_id(result_id)
  end

  def rival(team_id)
    sorted_array = sorted_array_of_opponent_win_percentages(team_id)
    result_id = sorted_array.first[1]
    determine_team_name_based_on_team_id(result_id)
  end

  def sorted_array_of_opponent_win_percentages(team_id)
    relevant_game_teams = find_relevant_game_teams_by_teamid(team_id)
    relevant_games = find_relevant_games_based_on_game_teams(relevant_game_teams)
    hashed_info = hashed_info(relevant_games, relevant_game_teams, team_id)
    array = order_list(hashed_info)
    array.sort
  end

  def find_relevant_games_based_on_game_teams(relevant_game_teams)
    relevant_games = []
    games.each do |game|
      relevant_game_teams.each do |game_team|
        if game.game_id == game_team.game_id
          relevant_games << game 
        end
      end
    end
    return relevant_games
  end 

  def hashed_info(relevant_games, relevant_game_teams, team_id)
    new_hash = Hash.new { |hash, key| hash[key] = [] }
    relevant_games.each do |game|
      if game.away_team_id != team_id 
        new_hash[game.away_team_id] << determine_game_outcome(game, relevant_game_teams)
      elsif game.home_team_id != team_id
        new_hash[game.home_team_id] << determine_game_outcome(game, relevant_game_teams)
      end
    end
    return new_hash
  end


  # MOVE INTO MODULE POTENTIALLY
  def determine_game_outcome(game, relevant_game_teams) 
    relevant_game_teams.each do |game_team|
      if game_team.game_id == game.game_id
        return game_team.result 
      end
    end
  end

end