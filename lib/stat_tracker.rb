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

#  
 def winningest_coach(season)


 end

 def worst_coach(season)
  
  new_hash_games = Hash.new(0)
  new_hash_victories = Hash.new(0)

  game_teams.each do |game_team|
    games.each do |game|
        if game[:season] == season && game_team[:game_id] == game[:game_id]
        new_hash_games[game_team[:head_coach]] += 1
          if game_team[:result] == "LOSS"
            new_hash_victories[game_team[:head_coach]] += 0
          elsif game_team[:result] == "TIE"
            new_hash_victories[game_team[:head_coach]] += 0.5
          elsif game_team[:result] == "WIN"
            new_hash_victories[game_team[:head_coach]] += 1 
          end
        end
      end
    end 
  sort_coach_percentages(new_hash_games, new_hash_victories)
  end 
  
  def sort_coach_percentages(new_hash_games, new_hash_victories)

  additional_hash = {}
    new_hash_games.each do |key, value|
      new_hash_victories.each do |key_v, value_v|
        if key == key_v 
          percent = (value_v / value.to_f) 
        additional_hash[key] = percent
        end
      end
    end
    sorted_array = additional_hash.sort_by do |key, value|
      value
    end
    determine_coach(sorted_array, "worst")
  end 

  def determine_coach(sorted_array, type)

    if type == "winning"
      sorted_array = sorted_array.reverse
    elsif type == "worst"
      sorted_array = sorted_array
    end 

    # winners = sorted_array[0][0]
      
    winners = []
      sorted_array.each do |array1|
        if array1[1] == sorted_array[0][1]
            winners << array1[0]
        end
      end 
        string = winners.join(", ")
    return string

  end 

  
 
 


end