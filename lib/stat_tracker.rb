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
      home_or_away = row[:hoa]
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
  
  def highest_total_score
    total_scores = []
    @games.map do |game|
      total_scores << (game.home_goals + game.away_goals)
    end
    total_scores.sort.last
  end

  # lowest_total_score - away_goals, home_goals # DYLAN

  def lowest_total_score
    total_scores = []
    @games.map do |game|
      total_scores << (game.home_goals + game.away_goals)
    end
    total_scores.sort.first
  end

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

  def team_name(team_id) # Sam's helper method for returning team names from team IDs
    found_team = @teams.find do |team|
      team.team_id == team_id
    end
    if found_team
      found_team.team_name
    else
      nil
    end
  end

  def find_game(game_id)
    found_game = @games.find do |game|
      game.game_id == game_id
    end
  end
  
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

    def best_offense
      team_ids = []
      @game_teams.map do |game_team|
        team_ids << game_team.team_id
        team_ids.uniq!
      end
      
      team_averages = []
      team_ids.map do |team_id|
        team_scores = []
        @game_teams.map do |game_team|
          if game_team.team_id == team_id
            team_scores << game_team.goals.to_f
          end
        end
        team_average_score = (team_scores.sum / team_scores.count)
        team_averages << {team: team_name(team_id), average_score: team_average_score}
      end
      team_averages_sorted = team_averages.sort_by { |team| team[:average_score] }
      team_averages_sorted.last[:team]
    end

  # worst_offense # DYLAN
    # teams.csv - team_id, teamName
    # games.csv - home_team_id, away_team_id, goals 

    def worst_offense
      team_ids = []
      @game_teams.map do |game_team|
        team_ids << game_team.team_id
        team_ids.uniq!
      end
      
      team_averages = []
      team_ids.map do |team_id|
        team_scores = []
        @game_teams.map do |game_team|
          if game_team.team_id == team_id
            team_scores << game_team.goals.to_f
          end
        end
        team_average_score = (team_scores.sum / team_scores.count)
        team_averages << {team: team_name(team_id), average_score: team_average_score}
      end
      team_averages_sorted = team_averages.sort_by { |team| team[:average_score] }
      team_averages_sorted.first[:team]
    end

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

    def winningest_coach(season)
      coaches = []
      @game_teams.map do |game_team|
        coaches << game_team.head_coach
        coaches.uniq!
      end
      
      coach_win_percents = []
      coaches.map do |coach|
        coach_wins = 0
        coach_games = 0
        @game_teams.map do |game_team|
          if game_team.head_coach == coach && find_game(game_team.game_id).season == season
            if game_team.result == "WIN"
              coach_wins += 1
            end
            coach_games += 1
          end
        end
        if coach_wins > 0 || coach_games > 0
          coach_win_percent = (coach_wins.to_f / coach_games.to_f)
          coach_win_percents << {coach: coach, win_percent: coach_win_percent}
        else
          return "Error: no game data for selected season."
        end
      end
      coach_win_percents_sorted = coach_win_percents.sort_by { |coach| coach[:win_percent] }
      winningest_coaches = []
      coach_win_percents_sorted.filter_map do |coach_hash|
        if coach_hash[:win_percent] == coach_win_percents_sorted.last[:win_percent]
          winningest_coaches << coach_hash[:coach]
        end
      end
      winningest_coaches.join(", ")
    end

  # worst_coach
    # game_teams.csv - game_id, team_id, result, head_coach # DYLAN
    # games.csv - game_id, season

    def worst_coach(season)
      coaches = []
      @game_teams.map do |game_team|
        coaches << game_team.head_coach
        coaches.uniq!
      end
      
      coach_win_percents = []
      coaches.map do |coach|
        coach_wins = 0
        coach_games = 0
        @game_teams.map do |game_team|
          if game_team.head_coach == coach && find_game(game_team.game_id).season == season
            if game_team.result == "WIN"
              coach_wins += 1
            end
            coach_games += 1
          end
        end
        if coach_wins > 0 || coach_games > 0
          coach_win_percent = (coach_wins.to_f / coach_games.to_f)
          coach_win_percents << {coach: coach, win_percent: coach_win_percent}
        else
          return "Error: no game data for selected season."
        end
      end
      coach_win_percents_sorted = coach_win_percents.sort_by { |coach| coach[:win_percent] }
      worst_coaches = []
      coach_win_percents_sorted.filter_map do |coach_hash|
        if coach_hash[:win_percent] == coach_win_percents_sorted.first[:win_percent]
          worst_coaches << coach_hash[:coach]
        end
      end
      worst_coaches.join(", ")
    end

  # most_accurate_team # SUNDAY
    # game_teams.csv - game_id, team_id, goals, shots
    # games.csv - game_id, season 
    # teams.csv - team_id, teamName

  # least_accurate_team # SUNDAY
    # game_teams.csv - game_id, team_id, goals, shots
    # games.csv - game_id, season 
    # teams.csv - team_id, teamName

  # most_tackles # SUNDAY
    # game_teams.csv - game_id, team_id, tackles
    # games.csv - game_id, season
    # teams.csv - team_id, teamName

  # least_tackles # SUNDAY
    # game_teams.csv - game_id, team_id, tackles
    # games.csv - game_id, season
    # teams.csv - team_id, teamName

end