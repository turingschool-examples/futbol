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

  # count_of_games_by_season - game_id, season

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
  # count_of_teams - team_id

# Multiple csv required
  # best_offense
    # teams.csv - team_id, teamName
    # games.csv - home_team_id, away_team_id, goals

  # worst_offense
    # teams.csv - team_id, teamName
    # games.csv - home_team_id, away_team_id, goals

  # highest_scoring_visitor
    # teams.csv - team_id, teamName
    # games.csv - away_team_id, goals

  # highest_scoring_home_team
    # teams.csv - team_id, teamName
    # games.csv - home_team_id, goals

  # lowest_scoring_visitor
    # teams.csv - team_id, teamName
    # games.csv - away_team_id, goals

  # lowest_scoring_home_team
    # teams.csv - team_id, teamName
    # games.csv - home_team_id, goals

  # winningest_coach
    # game_teams.csv - game_id, team_id, result, head_coach
    # games.csv - game_id, season 

  # worst_coach
    # game_teams.csv - game_id, team_id, result, head_coach
    # games.csv - game_id, season 

  # most_accurate_team
    # game_teams.csv - game_id, team_id, goals, shots
    # games.csv - game_id, season 
    # teams.csv - team_id, teamName

  # least_accurate_team
    # game_teams.csv - game_id, team_id, goals, shots
    # games.csv - game_id, season 
    # teams.csv - team_id, teamName

  # most_tackles
    # game_teams.csv - game_id, team_id, tackles
    # games.csv - game_id, season
    # teams.csv - team_id, teamName

  # least_tackles
    # game_teams.csv - game_id, team_id, tackles
    # games.csv - game_id, season
    # teams.csv - team_id, teamName

end