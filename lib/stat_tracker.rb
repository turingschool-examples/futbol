require 'csv'

class StatTracker 
    attr_reader :game_teams,
                :games,
                :teams

  def initialize(game_teams, games, teams)
    @game_teams = game_teams
    @games = games
    @teams = teams
  end

  def self.from_csv(locations)
    game_teams = game_teams_from_csv(locations)
    games = games_from_csv(locations)
    teams = teams_from_csv(locations)
    StatTracker.new(game_teams, games, teams)
  end

  def self.game_teams_from_csv(locations)
    game_teams_array = []
    CSV.foreach(locations[:game_teams], headers: true) do |info|
  
      new_info = {
        game_id: info["game_id"].to_i,
        team_id: info["team_id"].to_i, 
        hoa: info["HoA"], 
        result: info["result"], 
        settled_in: info["settled_in"],
        head_coach: info["head_coach"],
        goals: info["goals"].to_i,
        shots: info["shots"].to_i,
        tackles: info["tackles"].to_i,
        pim: info["pim"].to_i,
        powerplay_opportunities: info["powerPlayOpportunities"].to_i,
        powerplay_goals: info["powerPlayGoals"].to_i,
        faceoff_win_percentage: info["faceOffWinPercentage"].to_f,
        giveaways: info["giveaways"].to_i,
        takeaways: info["takeaways"].to_i
      }  

      game_teams_array << new_info
    
    end
    game_teams_array
  end

  def self.games_from_csv(locations)
    games_array = []
    CSV.foreach(locations[:games], headers: true) do |info|
  
      new_info = {
        game_id: info["game_id"].to_i, 
        season: info["season"], 
        type: info["type"], 
        date_time: info["date_time"],
        away_team_id: info["away_team_id"].to_i,
        home_team_id: info["home_team_id"].to_i,
        away_goals: info["away_goals"].to_i,
        home_goals: info["home_goals"].to_i,
        venue: info["venue"],
        venue_link: info["venue_link"]
      }  

      games_array << new_info
    
    end
    games_array
  end

  def self.teams_from_csv(locations)
    teams_array = []
    CSV.foreach(locations[:teams], headers: true) do |info|

      new_info = {
        team_id: info["team_id"].to_i,
        franchise_id: info["franchiseId"].to_i,
        team_name: info["teamName"],
        abbreviation: info["abbreviation"],
        stadium: info["Stadium"],
        link: info["link"]
      }

      teams_array << new_info
    end
    teams_array
  end
 #DO NOT CHANGE ANYTHING ABOVE THIS POINT ^


  # Highest sum of the winning and losing teams’ scores
  def highest_total_score
    total_scores.last
  end

  # Lowest sum of the winning and losing teams’ scores
  def lowest_total_score
    total_scores.first
  end

  # HELPER: Array of the winning and losing teams’ scores
  def total_scores
    game_sums = @games.map do |game|
      game[:away_goals] + game[:home_goals]
    end.sort
  end

  #Total number of teams in the data
  def count_of_teams
    @teams.count
  end

  #Team name w/ highest avg num of goals scored (per game across all seasons)
  def best_offense
    team_id_all_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do |info_line|
      team_id_all_goals[info_line[:team_id]] << info_line[:goals]
    end
  
    team_id_avg_goals = Hash.new { |hash, key| hash[key] = 0 }
    team_id_all_goals.each do |team_id, goals_scored|
      team_id_avg_goals[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(2)
    end

    # if 2 teams have the same avg this will return ONLY the FIRST one:
    @teams.first do |info_line|
      if info_line[:team_id] == team_id_avg_goals.key(team_id_avg_goals.values.max)
        return info_line[:team_name] 
      end
    end
  end

  #Team name w/ lowest avg num of goals scored (per game across all seasons)
  def worst_offense
    team_id_all_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do |info_line|
      team_id_all_goals[info_line[:team_id]] << info_line[:goals]
    end
  
    team_id_avg_goals = Hash.new { |hash, key| hash[key] = 0 }
    team_id_all_goals.each do |team_id, goals_scored|
      team_id_avg_goals[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(2)
    end

    # if 2 teams have the same avg this will return ONLY the FIRST one:
    @teams.first do |info_line|
      if info_line[:team_id] == team_id_avg_goals.key(team_id_avg_goals.values.min)


 #Percentage of games that a home team has won (rounded to the nearest 100th)

#  Method count of games by season
 def count_of_games_by_season
  new_hash = Hash.new(0) 

  games.each do |game|
    new_hash[game[:season]] += 1
  end
  return new_hash
 end

# Method of average goals per game  
 def average_goals_per_game 
  goals = 0 
  games.each do |game|
    goals += (game[:away_goals] + game[:home_goals]) 
  end
  average = (goals.to_f/(games.count.to_f)).round(2)
  return average
 end
# Method average goals by season
 def average_goals_by_season
  new_hash = Hash.new(0) 

  games.each do |game|
    new_hash[game[:season]]  = season_goals(game[:season])
  end
  return new_hash
 end

# Helper method to average goals by season 
 def season_goals(season)
  number = 0
  goals = 0
  games.each do |game|
    if game[:season] == season
      number += 1 
      goals += (game[:away_goals] + game[:home_goals])
    end
  end
  average = (goals.to_f/number.to_f).round(2)
 end

#  WINNINGNEST COACH AND HELPER METHODS BELOW 

  def winningest_coach(season)

    raw_hash_values(season, "winning")

  end 

  def worst_coach(season)

    raw_hash_values(season, "worst")

  end

  def raw_hash_values(season, type)
    coach_games = Hash.new(0)
    coach_victories = Hash.new(0)

    total_games = determine_games(season)
    all_coaches = total_games.group_by do |game|
      game[:head_coach]
    end
    
    all_coaches.keys.each do |coach|
      coach_games[coach] = 0
      coach_victories[coach] = 0
  end

    games.each do |game|
      game_teams.each do |game_team|
        if game[:season] == season 
          if game_team[:game_id] == game[:game_id]
            if game_team[:result]== "LOSS"
              coach_games[game_team[:head_coach]] += 1
            elsif game_team[:result] == "TIE"
              coach_games[game_team[:head_coach]] += 1
            elsif game_team[:result] == "WIN"
              coach_victories[game_team[:head_coach]] += 1 
              coach_games[game_team[:head_coach]] += 1
            end
          end 
        end 
      end 
    end 
    sort_coach_percentages(coach_games, coach_victories, type)
  end

  def determine_games(season)
    games_in_season = games.find_all do |game| 
      game[:season] == season
    end 
  
    games_in_season_gameid = games_in_season.map do |game| 
      game[:game_id]
    end 
    
    total_relevant_games = []
    games_in_season_gameid.each do |game_id| 
      game_teams.each do |game_team|
        if game_team[:game_id] == game_id
          total_relevant_games << game_team
        end 
      end
    end
    return total_relevant_games
  end 

  def sort_coach_percentages(coach_games, coach_victories, type)

    additional_hash = {}
    
    coach_games.each do |key, value|
    coach_victories.each do |key_v, value_v|
      if key == key_v 
        percent = (value_v / value.to_f) 
      additional_hash[key] = percent
      end
    end
    end
    sorted_array = additional_hash.sort_by do |key, value|
    value
    end
    determine_coach(sorted_array, type)
  end 
  
  def determine_coach(sorted_array, type)
    if type == "winning"
      sorted_array = sorted_array.reverse
    elsif type == "worst"
    sorted_array = sorted_array
  
    end 
  
    result = sorted_array[0][0]
    return result 
  end 

end

 
 # Percentage of games that a home team has won (rounded to the nearest 100th)
  def percentage_home_wins
    total_of_home_games = 0
    wins_at_home = 0 
    @game_teams.each do | k, v |
      if k[:hoa] == "home"
        total_of_home_games += 1
      end
      if k[:hoa] == "home" && k[:result] == "WIN"
        wins_at_home += 1
      end
    end
    percent_win = ((wins_at_home / total_of_home_games.to_f)).round(2)
  end
  # Percentage of games that a visitor has won (rounded to the nearest 100th)
  def percentage_visitor_wins
    total_of_home_games = 0
    losses_at_home = 0 
    @game_teams.each do | k, v |
      if k[:hoa] == "home"
        total_of_home_games += 1
      end
      if k[:hoa] == "home" && k[:result] == "LOSS"
        losses_at_home += 1
      end
    end
    percent_loss = ((losses_at_home / total_of_home_games.to_f)).round(2)
  end
   #  Percentage of games that has resulted in a tie (rounded to the nearest 100th)
  def percentage_ties
    ties = 0 
    total_of_games = @game_teams.count
    @game_teams.each do | k, v |
      if k[:result] == "TIE"
        ties += 1
      end
    end
    percent_ties = ((ties / total_of_games.to_f)).round(2)
  end

  # Name of the team with the highest average score per game across all seasons when they are away.	
  def highest_scoring_visitor
    id_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do | k, v |
      if k[:hoa] == "away"
        id_goals[k[:team_id]] << k[:goals]
      end
    end

    id_goals_avg = Hash.new { |hash, key| hash[key] = 0 }
    id_goals.each do |team_id, goals_scored|
      id_goals_avg[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(2)
    end

    @teams.find do |info_line|
      if info_line[:team_id] == id_goals_avg.key(id_goals_avg.values.max)
        return info_line[:team_name] 
      end
    end
  end
  
  # Name of the team with the highest average score per game across all seasons when they are home. 
  def highest_scoring_home_team
    id_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do | k, v |
      if k[:hoa] == "home"
        id_goals[k[:team_id]] << k[:goals]
      end
    end

    id_goals_avg = Hash.new { |hash, key| hash[key] = 0 }
    id_goals.each do |team_id, goals_scored|
      id_goals_avg[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(2)
    end

    @teams.find do |info_line|
      if info_line[:team_id] == id_goals_avg.key(id_goals_avg.values.max)
        return info_line[:team_name] 
      end
    end
  end

  # Name of the team with the lowest average score per game across all seasons when they are a visitor.
  def lowest_scoring_visitor
    id_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do | k, v |
      if k[:hoa] == "away"
        id_goals[k[:team_id]] << k[:goals]
      end
    end
  
    id_goals_avg = Hash.new { |hash, key| hash[key] = 0 }
    id_goals.each do |team_id, goals_scored|
      id_goals_avg[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(2)
    end
  
    @teams.find do |info_line|
      if info_line[:team_id] == id_goals_avg.key(id_goals_avg.values.min)
        return info_line[:team_name] 
      end
    end
  end
  # Name of the team with the lowest average score per game across all seasons when they are at home.
  def lowest_scoring_home_team
    id_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do | k, v |
    if k[:hoa] == "home"
        id_goals[k[:team_id]] << k[:goals]
      end
    end

    id_goals_avg = Hash.new { |hash, key| hash[key] = 0 }
    id_goals.each do |team_id, goals_scored|
      id_goals_avg[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(2)
    end

    @teams.find do |info_line|
      if info_line[:team_id] == id_goals_avg.key(id_goals_avg.values.min)

        return info_line[:team_name] 
      end
    end
  end

end

