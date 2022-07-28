require 'csv'

class StatTracker
  attr_reader :locations, :data

  def initialize(game_path, team_path, game_teams_path)
    # @locations = locations
    # @data = {}
    # locations.each_key do |key|
    #   data[key] = CSV.read locations[key]
    # end
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
    # games = Games.new(locations[:games])
  end

  def self.from_csv(locations)
    StatTracker.new(
      locations[:games],
      locations[:teams],
      locations[:game_teams]
    )
  end

  def highest_total_score
    score_sum = 0
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      if score_sum < (away_goals + home_goals)
        score_sum = (away_goals + home_goals)
      end
    end
    score_sum
  end


  def lowest_total_score
    score_sum = 10000 #need to update for csv file with no data
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      if score_sum > (away_goals + home_goals)
        score_sum = (away_goals + home_goals)
      end
    end
    score_sum
  end


  def percentage_home_wins
    total_games = 0.0
    home_wins = 0.0
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      total_games += 1
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      if home_goals > away_goals
        home_wins += 1
      end
    end

    (home_wins / total_games).round(2)
  end

  def percentage_visitor_wins
    total_games = 0.0
    visitor_wins = 0.0
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      total_games += 1
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      if home_goals < away_goals
        visitor_wins += 1
      end
    end

    (visitor_wins / total_games).round(2)
  end

  def percentage_ties
    total_games = 0.0
    ties = 0.0
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      total_games += 1
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      if home_goals == away_goals
        ties += 1
      end
    end

    (ties / total_games).round(2)
  end

  def count_of_games_by_season
    season_games = Hash.new(0)
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      season_games[row[:season]] += 1
    end
    season_games
  end

  def average_goals_per_game
    total_goals = 0.0
    total_games = 0.0
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      total_games += 1
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      total_goals += (away_goals + home_goals)
    end
    (total_goals / total_games).round(2)
  end

  def total_goals_by_season
    total_season_goals = Hash.new(0.0)
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      away_goals = row[:away_goals].to_i
      home_goals = row[:home_goals].to_i
      total_season_goals[row[:season]] += away_goals + home_goals
    end
    total_season_goals
  end

  def average_goals_by_season
    total_goals = total_goals_by_season
    count = count_of_games_by_season
    avg_season_goals = Hash.new(0.0)
    total_goals.each do |season, goal|
      avg_season_goals[season] = (goal / count[season]).round(2)
    end
    avg_season_goals
  end

  #season stats
  def winningest_coach(season_id)
    #first 4 char of season_id
    games_id_year = season_id[0..3]

    #hash with "coach" key and [0,0] value. first element is total games. second is games won
    coach_stats = Hash.new { |coach, stats| coach[stats] = [0.0, 0.0] }
    contents = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)

    contents.each do |row|
      #iterates through every line checking to see if the game and season have the same 4 first chars
      if row[:game_id][0..3] == games_id_year
        coach_stats[row[:head_coach]][0] += 1
        coach_stats[row[:head_coach]][1] += 1 if row[:result] == "WIN"
      end
    end

    highest_win_percentage = 0.0
    highest_win_percentage_coach = ""
    #iterates through each coach and finding the highest win percentage
    coach_stats.each do |coach, stats|
      if highest_win_percentage < (stats[1] / stats[0])
        highest_win_percentage = stats[1] / stats[0]
        highest_win_percentage_coach = coach
      end
    end
    highest_win_percentage_coach
  end


  def worst_coach(season_id)
    #first 4 char of season_id
    games_id_year = season_id[0..3]

    #hash with "coach" key and [0,0] value. first element is total games. second is games won
    coach_stats = Hash.new { |coach, stats| coach[stats] = [0.0, 0.0] }
    contents = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)

    contents.each do |row|
      #iterates through every line checking to see if the game and season have the same 4 first chars
      if row[:game_id][0..3] == games_id_year
        coach_stats[row[:head_coach]][0] += 1
        coach_stats[row[:head_coach]][1] += 1 if row[:result] == "LOSS"
      end
    end

    lowest_win_percentage = 1.0
    lowest_win_percentage_coach = ""
    #iterates through each coach and finding the lowest win percentage
    coach_stats.each do |coach, stats|
      if lowest_win_percentage > (stats[1] / stats[0])
        lowest_win_percentage = stats[1] / stats[0]
        lowest_win_percentage_coach = coach
      end
    end
    lowest_win_percentage_coach
  end

  #*** returns hash {team_id => teamName}****
  def team_names
    id_to_names = {}
    contents = CSV.open(@teams_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      id_to_names[row[:team_id]] = row[:teamName]
    end
    id_to_names
  end

  def most_accurate_team(season_id)
    #first 4 char of season_id
    games_id_year = season_id[0..3]

    #hash with "team_id" key and [0,0] value. first element is total shots. second is total goals
    goal_stats = Hash.new { |team_id, stats| team_id[stats] = [0.0, 0.0] }
    contents = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)

    contents.each do |row|
      #iterates through every line checking to see if the game and season have the same 4 first chars
      if row[:game_id][0..3] == games_id_year
        #adding in the shots and goals into the hash into the array
        goal_stats[row[:team_id]][0] += row[:shots]
        goal_stats[row[:team_id]][1] += row[:goals]
      end
    end

    highest_goal_ratio = 0.0
    highest_goal_ratio_team = ""
    #iterates through each coach and finding the lowest win percentage
    goal_stats.each do |team_id, stats|
      #checking if the teams ratio is better than the last highest
      if highest_goal_ratio < (stats[1] / stats[0])
        highest_goal_ratio = stats[1] / stats[0]

        #setting new highest team        
        highest_goal_ratio_team = team_id
      end
    end
    team_names[highest_goal_ratio_team]
  end

end
