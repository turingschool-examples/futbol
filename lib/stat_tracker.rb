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
        season: info["season"].to_i, 
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
 def percentage_home_wins


 end

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

    team_total_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do |info_line|
      team_total_goals[info_line[:team_id]] << info_line[:goals]
      # returns: {3=>[1, 3, 2], 8=>[2], 25=>[3], 18=>[3], 30=>[1], 17=>[1], 1=>[3], 19=>[4], 21=>[0], 5=>[1], 15=>[2, 1], 14=>[2]}
    end

    team_averages = Hash.new { |hash, key| hash[key] = 0 }
    team_total_goals.each do |id_of_team, goals_scored|
      team_averages[id_of_team] = (goals_scored.sum / goals_scored.length)
      # returns: {3=>2, 8=>2, 25=>3, 18=>2, 30=>1, 17=>2, 1=>3, 19=>3, 21=>1, 5=>1, 15=>1}
    end
    
    team_averages.sort_by {|id_of_team, avg_goals_scored| avg_goals_scored}
    # returns: [[0, 0], [20, 1], [21, 1], [5, 1], [15, 1], [30, 1]]
    # the id is still first, the values are second and IN ORDER...
    require 'pry'; binding.pry

    @teams.find do |info_line|
      if info_line[:game_id] == team_averages[-1][1] 
        return info_line[:team_name] 
      end
    end
    
  end

  #Team name w/ lowest avg num of goals scored (per game across all seasons)
  # def worst_offense
  #   #call helper method here? use <.first> #to get the lowest number?
  #   worst_offense_team = @teams.find do |info_line|
  #     info_line[:team_name] if info_line[:game_id] == <id_of_lowest_avg_goals> 
  #   end
  # end

  # HELPER: avg num of goals scored (per game across all seasons)
  # def name_goes_here
  # end

  #PSEUDO CODE:
    # @teams # has the team name & team ID
    # @game_teams # has the team ID & goals scored per game
    #helper method: 
    # group by team ID (hash key)
    # group all their total goals scored (per game) (array value)
    # find averages + sort by the averages(value)
    # best/worst offense methods: 
    # find highest/lowest average (call helper method) -> return that team's name (string)
  
end