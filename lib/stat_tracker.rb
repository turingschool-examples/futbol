require 'CSV'
require "./lib/game"
require "./lib/team.rb"
require "./lib/game_team.rb"

class StatTracker
  attr_reader :games, :teams, :game_teams, :combined_objects

  def initialize(games_array, teams_array, game_teams_array, combined_array)
    @games = games_array
    @teams = teams_array
    @game_teams = game_teams_array
    @combined_objects = combined_array
  end

  @game_teams = []
  def self.from_csv(locations_hash)

    game_objects = []
    team_objects = []
    game_team_objects = []
    
    CSV.foreach(locations_hash[:games], headers: true, header_converters: :symbol) do |row|
      game_id = row[:game_id]
      season = row[:season]
      # type = row[:type]
      # date_time = row[:date_time]
      # away_team_id = row[:away_team_id]
      # home_team_id = row[:home_team_id]
      away_goals = row[:away_goals].to_i      
      home_goals = row[:home_goals].to_i
      # venue = row[:venue]
      # venue_link = [:venue_link]

      game = Game.new(game_id, season, away_goals, home_goals)

      game_objects << game
    end

    CSV.foreach(locations_hash[:teams], headers: true, header_converters: :symbol) do |row|
      team_id = row[:team_id]
      # franchise_id = row[:franchiseid]
      team_name = row[:teamname]
      # abbreviation = row[:abbreviation]
      # stadium = row[:stadium]
      # link = row[:link]

      team = Team.new(team_id, team_name)

      team_objects << team
    end

    CSV.foreach(locations_hash[:game_teams], headers: true, header_converters: :symbol) do |row|
      game_id = row[:game_id]
      team_id = row[:team_id]
      home_or_away = row[:HoA]
      result = row[:result]
      # settled_in = row[:settled_in]
      head_coach = row[:head_coach]
      goals = row[:goals].to_i
      shots = row[:shots].to_i
      tackles = row[:tackles].to_i
      # pim = row[:pim]
      # power_play_opportunities = row[:powerPlayOpportunities]
      # power_play_goals = row[:powerPlayGoals]
      # face_off_win_percentage = row[:faceOffWinPercentage]
      # giveaways = row[:giveaways]
      # takeaways = row[:takeaways]

      game_team = GameTeam.new(game_id, team_id, home_or_away, result, head_coach, goals, shots, tackles)

      game_team_objects << game_team
    end

    combined_objects = []
    combined_objects << game_objects
    combined_objects << team_objects
    combined_objects << game_team_objects

    StatTracker.new(game_objects, team_objects, game_team_objects, combined_objects)
  end

# information needed for each method

# games.csv 
  # highest_total_score - away_goals, home_goals # DYLAN

  # lowest_total_score - away_goals, home_goals # DYLAN

  # count_of_games_by_season - game_id, season # SAM

  def count_of_games_by_season
    games_by_season = Hash.new(0)
    @games.each do |game|
      season = game.season
      games_by_season[season] += 1
    end
    games_by_season
  end

  # average_goals_per_game - away_goals, home_goals # SAM

  def average_goals_per_game
    total_score = 0
    @games.each do |game|
      total_score += game.away_goals + game.home_goals
    end
    average_goals = total_score / @games.length.to_f
    average_goals.round(2)
  end

  # average_goals_by_season - season, away_goals, home_goals # SAM

  def average_goals_per_season
    season_goals = Hash.new(0)
    season_counts = Hash.new(0)
  
    @games.each do |game|
      season = game.season
      total_score = game.away_goals + game.home_goals
      season_goals[season] += total_score
      season_counts[season] += 1
    end
  
    average_goals_per_season = {}
  
    season_goals.each do |season, total_score|
      count = season_counts[season]
      if count > 0
        average = total_score.to_f / count
      else
        average = 0
      end
      average_goals_per_season[season] = average.round(2)
    end
  
    average_goals_per_season
  end

# game_teams.csv
  # percentage_home_wins - HoA, result # MARTIN

  # percentage_visitor_wins - HoA, result # MARTIN

  # percentage_ties - result # MARTIN

# teams.csv
  # count_of_teams - team_id # SAM

  def count_of_teams
    teams_total = []

    @teams.each do |team|
      teams_total << team.team_id
    end
    teams_total.count
  end

# Multiple csv required
  # best_offense # DYLAN
    # teams.csv - team_id, teamName
    # games.csv - home_team_id, away_team_id, goals 

  # worst_offense # DYLAN
    # teams.csv - team_id, teamName
    # games.csv - home_team_id, away_team_id, goals 

  # highest_scoring_visitor # MARTIN
    # teams.csv - team_id, teamName
    # games.csv - away_team_id, goals

  # highest_scoring_home_team # MARTIN
    # teams.csv - team_id, teamName
    # games.csv - home_team_id, goals

  # lowest_scoring_visitor # MARTIN
    # teams.csv - team_id, teamName
    # games.csv - away_team_id, goals

  # lowest_scoring_home_team # MARTIN
    # teams.csv - team_id, teamName
    # games.csv - home_team_id, goals

  # winningest_coach
    # game_teams.csv - game_id, team_id, result, head_coach # DYLAN
    # games.csv - game_id, season 

  # worst_coach
    # game_teams.csv - game_id, team_id, result, head_coach # DYLAN
    # games.csv - game_id, season 

  # most_accurate_team # SUNDAY
    # game_teams.csv - game_id, team_id, goals, shots
    # games.csv - game_id, season 
    # teams.csv - team_id, teamName

  def most_accurate_team
    season_data = {}
    
    @game_teams.each do |game_team|
      game = find_game_by_id(game_team.game_id)
      next unless game
    
      season = game.season
      team_id = game_team.team_id
      goals = game_team.goals.to_f
      shots = game_team.shots.to_f
        
      #initialize nested hash for each new season or team

      season_data[season] ||= {}
      season_data[season][game_team.team_id] ||= { total_goals: 0, total_shots: 0 }
    
      season_data[season][game_team.team_id][:total_goals] += goals
      season_data[season][game_team.team_id][:total_shots] += shots
    end
    
    most_accurate_teams_per_season = {}
    season_data.each do |season, teams|
      highest_accuracy = 0.0 #lowest possible accuracy
      most_accurate_team_id = nil

      teams.each do |team_id, data|
        if data[:total_shots] > 0
          accuracy = data[:total_goals] / data[:total_shots]
          if accuracy > highest_accuracy
            highest_accuracy = accuracy
            most_accurate_team_id = team_id
          end
        end
      end
      most_accurate_teams_per_season[season] = team_name(most_accurate_team_id)
    end
    most_accurate_teams_per_season
  end    

  # least_accurate_team # SUNDAY
    # game_teams.csv - game_id, team_id, goals, shots
    # games.csv - game_id, season 
    # teams.csv - team_id, teamName

  def least_accurate_team
    season_data = {}
        
    @game_teams.each do |game_team|
      game = find_game_by_id(game_team.game_id)
      next unless game
        
      season = game.season
      team_id = game_team.team_id
      goals = game_team.goals.to_f
      shots = game_team.shots.to_f
            
      # Initialize nested hash for each new season or team
      season_data[season] ||= {}
      season_data[season][team_id] ||= { total_goals: 0, total_shots: 0 }
        
      season_data[season][team_id][:total_goals] += goals
      season_data[season][team_id][:total_shots] += shots
    end
        
    least_accurate_teams_per_season = {}
    season_data.each do |season, teams|
      lowest_accuracy = 1.0 #perfect accuracy score
      least_accurate_team_id = nil
    
      teams.each do |team_id, data|
        if data[:total_shots] > 0
          accuracy = data[:total_goals] / data[:total_shots]
          if accuracy < lowest_accuracy
            lowest_accuracy = accuracy
            least_accurate_team_id = team_id
          end
        end
      end
      least_accurate_teams_per_season[season] = team_name(least_accurate_team_id) if least_accurate_team_id
    end
    least_accurate_teams_per_season
  end

  # most_tackles # SUNDAY
    # game_teams.csv - game_id, team_id, tackles
    # games.csv - game_id, season
    # teams.csv - team_id, teamName
  def most_tackles
    season_tackles = {}
    
    @game_teams.each do |game_team|
      game = find_game_by_id(game_team.game_id)
      next unless game
    
      season = game.season
      team_id = game_team.team_id
      tackles = game_team.tackles.to_i
        
      #initialize nested hash for each new season or team

      season_tackles[season] ||= {}
      season_tackles[season][game_team.team_id] ||= 0
    
      season_tackles[season][team_id] += tackles

    end
    
    teams_with_most_tackles_per_season = {}
    season_tackles.each do |season, teams|
      most_tackles = 0
      team_with_most_tackles = nil

      teams.each do |team_id, tackles|
        if tackles > most_tackles
          most_tackles = tackles
          team_with_most_tackles = team_id
        end
      end
      teams_with_most_tackles_per_season[season] = team_name(team_with_most_tackles)
    end
    teams_with_most_tackles_per_season
  end

  # least_tackles # SUNDAY
    # game_teams.csv - game_id, team_id, tackles
    # games.csv - game_id, season
    # teams.csv - team_id, teamName

  def least_tackles
    season_tackles = {}
    
    @game_teams.each do |game_team|
      game = find_game_by_id(game_team.game_id)
      next unless game
    
      season = game.season
      team_id = game_team.team_id
      tackles = game_team.tackles.to_i
        
      #initialize nested hash for each new season or team

      season_tackles[season] ||= {}
      season_tackles[season][game_team.team_id] ||= 0
      season_tackles[season][team_id] += tackles

    end
    
    teams_with_least_tackles_per_season = {}
    season_tackles.each do |season, teams|
      least_tackles = teams.values.min
      team_with_least_tackles = teams.key(least_tackles)
      teams_with_least_tackles_per_season[season] = team_name(team_with_least_tackles)
    end
    teams_with_least_tackles_per_season
  end

  # helper methods

  # team_name finder
  def team_name(team_id)
    found_team = @teams.find do |team|
      team.team_id == team_id
    end
    if found_team
      found_team.team_name
    else
      nil
    end
  end

  #find game by ID
  def find_game_by_id(game_id)
    @games.find { |game| game.game_id == game_id }
  end


end