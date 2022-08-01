require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

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

  def games
    games_csv = CSV.open(@game_path, headers: true, header_converters: :symbol)
    @games ||= games_csv.map do |row|
      Game.new(row)
    end
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

  def count_of_teams
    team_count = 0
    contents = CSV.open(@team_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      teams = row[:team_id].to_i
      if teams != 0
        team_count += 1
      end
    end
    team_count
  end

  def best_offense
    game_teams_csv = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    goals_by_team_id = Hash.new(0)
    game_count_by_team_id = Hash.new(0)
    game_teams_csv.each do |row|
      goals_by_team_id[row[:team_id].to_i] += row[:goals].to_i
      game_count_by_team_id[row[:team_id].to_i] += 1
    end
    average_teamid_score = goals_by_team_id.map{|team_id, goals| [team_id, goals.to_f / game_count_by_team_id[team_id]] }.to_h
    best_offense_team_id = average_teamid_score.max_by { |team_id, average_goals| average_goals  }[0]
    teams_csv = CSV.open(@team_path, headers: true, header_converters: :symbol)
    team_row = teams_csv.find do |row|
      row[:team_id].to_i == best_offense_team_id
    end
    team_row[:teamname]
  end

  def worst_offense
    game_teams_csv = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    goals_by_team_id = Hash.new(0)
    game_count_by_team_id = Hash.new(0)
    game_teams_csv.each do |row|
      goals_by_team_id[row[:team_id].to_i] += row[:goals].to_i
      game_count_by_team_id[row[:team_id].to_i] += 1
    end
    average_teamid_score = goals_by_team_id.map{|team_id, goals| [team_id, goals.to_f / game_count_by_team_id[team_id]] }.to_h
    #in the method below we are checking the lowest scoring team by accessing the key at the end "[0]"
    best_offense_team_id = average_teamid_score.min_by { |team_id, average_goals| average_goals }[0]
    teams_csv = CSV.open(@team_path, headers: true, header_converters: :symbol)
    team_row = teams_csv.find do |row|
      row[:team_id].to_i == best_offense_team_id
    end
    team_row[:teamname]
  end

  def highest_scoring_visitor
    games_csv = CSV.open(@game_path, headers: true, header_converters: :symbol)
    away_goals_by_team_id = Hash.new(0)
    game_count_by_team_id = Hash.new(0)
    games_csv.each do |row|
      away_goals_by_team_id[row[:away_team_id].to_i] += row[:away_goals].to_i
      game_count_by_team_id[row[:away_team_id].to_i] += 1
    end
    average_teamid_score = away_goals_by_team_id.map { |team_id, goals| [team_id, goals.to_f / game_count_by_team_id[team_id]] }.to_h
    best_away_team_id = average_teamid_score.max_by { |away_team_id, average_goals| average_goals }[0]
    teams_csv = CSV.open(@team_path, headers: true, header_converters: :symbol)
    visitor_team_row = teams_csv.find do |row|
      row[:team_id].to_i == best_away_team_id
    end
    visitor_team_row[:teamname]
  end

  def highest_scoring_home_team
    games_csv = CSV.open(@game_path, headers: true, header_converters: :symbol)
    home_goals_by_team_id = Hash.new(0)
    game_count_by_team_id = Hash.new(0)
    games_csv.each do |row|
      home_goals_by_team_id[row[:home_team_id].to_i] += row[:home_goals].to_i
      game_count_by_team_id[row[:home_team_id].to_i] += 1
    end
    average_teamid_score = home_goals_by_team_id.map { |team_id, goals| [team_id, goals.to_f / game_count_by_team_id[team_id]] }.to_h
    best_home_team_id = average_teamid_score.max_by { |home_team_id, average_goals| average_goals }[0]
    teams_csv = CSV.open(@team_path, headers: true, header_converters: :symbol)
    visitor_team_row = teams_csv.find do |row|
      row[:team_id].to_i == best_home_team_id
    end
    visitor_team_row[:teamname]
  end

  def lowest_scoring_visitor
    games_csv = CSV.open(@game_path, headers: true, header_converters: :symbol)
    away_goals_by_team_id = Hash.new(0)
    game_count_by_team_id = Hash.new(0)
    games_csv.each do |row|
      away_goals_by_team_id[row[:away_team_id].to_i] += row[:away_goals].to_i
      game_count_by_team_id[row[:away_team_id].to_i] += 1
    end
    average_teamid_score = away_goals_by_team_id.map { |team_id, goals| [team_id, goals.to_f / game_count_by_team_id[team_id]] }.to_h
    worst_away_team_id = average_teamid_score.min_by { |away_team_id, average_goals| average_goals }[0]
    teams_csv = CSV.open(@team_path, headers: true, header_converters: :symbol)
    visitor_team_row = teams_csv.find do |row|
      row[:team_id].to_i == worst_away_team_id
    end
    visitor_team_row[:teamname]
  end

  def lowest_scoring_home_team
    games_csv = CSV.open(@game_path, headers: true, header_converters: :symbol)
    home_goals_by_team_id = Hash.new(0)
    game_count_by_team_id = Hash.new(0)
    games_csv.each do |row|
      home_goals_by_team_id[row[:home_team_id].to_i] += row[:home_goals].to_i
      game_count_by_team_id[row[:home_team_id].to_i] += 1
    end
    average_teamid_score = home_goals_by_team_id.map { |team_id, goals| [team_id, goals.to_f / game_count_by_team_id[team_id]] }.to_h
    worst_home_team_id = average_teamid_score.min_by { |home_team_id, average_goals| average_goals }[0]
    teams_csv = CSV.open(@team_path, headers: true, header_converters: :symbol)
    visitor_team_row = teams_csv.find do |row|
      row[:team_id].to_i == worst_home_team_id
    end
    visitor_team_row[:teamname]
  end

  def total_games_by_team(team_id)
    total_games = 0
    contents = CSV.open(@game_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      if row[:away_team_id] == team_id || row[:home_team_id] == team_id
        total_games += 1
      end
    end
    total_games
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
        coach_stats[row[:head_coach]][1] += 1 if row[:result] == "WIN"
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
    contents = CSV.open(@team_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      id_to_names[row[:team_id]] = row[:teamname]
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
        goal_stats[row[:team_id]][0] += row[:shots].to_i
        goal_stats[row[:team_id]][1] += row[:goals].to_i
      end
    end
    highest_goal_ratio = 0.0
    highest_goal_ratio_team = ""
    #iterates through each coach and finding the goal ratio
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

  def least_accurate_team(season_id)
    #first 4 char of season_id
    games_id_year = season_id[0..3]

    #hash with "team_id" key and [0,0] value. first element is total shots. second is total goals
    goal_stats = Hash.new { |team_id, stats| team_id[stats] = [0.0, 0.0] }
    contents = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      #iterates through every line checking to see if the game and season have the same 4 first chars
      if row[:game_id][0..3] == games_id_year
        #adding in the shots and goals into the hash into the array
        goal_stats[row[:team_id]][0] += row[:shots].to_i
        goal_stats[row[:team_id]][1] += row[:goals].to_i
      end
    end
    lowest_goal_ratio = 1.0
    lowest_goal_ratio_team = ""
    #iterates through each coach and finding the lowest goal ratio
    goal_stats.each do |team_id, stats|
      #checking if the teams ratio is worse than the last lowest
      if lowest_goal_ratio > (stats[1] / stats[0])
        lowest_goal_ratio = stats[1] / stats[0]

        #setting new worst ratio team
        lowest_goal_ratio_team = team_id
      end
    end
    team_names[lowest_goal_ratio_team]
  end

  def most_tackles(season_id)
    #first 4 char of season_id
    games_id_year = season_id[0..3]

    #hash with "team_id" key and tackle int values.
    tackle_stats = Hash.new(0)
    contents = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      #iterates through every line checking to see if the game and season have the same 4 first chars
      if row[:game_id][0..3] == games_id_year
        #adding in the shots and goals into the hash into the array
        tackle_stats[row[:team_id]] += row[:tackles].to_i
      end
    end

    #finds key with the max value and uses that same key for the team_names hash
    team_names[tackle_stats.key(tackle_stats.values.max)]
  end

  def most_tackles(season_id)
    #first 4 char of season_id
    games_id_year = season_id[0..3]

    #hash with "team_id" key and tackle int values.
    tackle_stats = Hash.new(0)
    contents = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      #iterates through every line checking to see if the game and season have the same 4 first chars
      if row[:game_id][0..3] == games_id_year
        #adding in the shots and goals into the hash into the array
        tackle_stats[row[:team_id]] += row[:tackles].to_i
      end
    end

    #finds key with the max value and uses that same key for the team_names hash
    team_names[tackle_stats.key(tackle_stats.values.max)]
  end

  def fewest_tackles(season_id)
    #first 4 char of season_id
    games_id_year = season_id[0..3]

    #hash with "team_id" key and tackle int values.
    tackle_stats = Hash.new(0)
    contents = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    contents.each do |row|
      #iterates through every line checking to see if the game and season have the same 4 first chars
      if row[:game_id][0..3] == games_id_year
        #adding in the shots and goals into the hash into the array
        tackle_stats[row[:team_id]] += row[:tackles].to_i
      end
    end

    #finds key with the max value and uses that same key for the team_names hash
    team_names[tackle_stats.key(tackle_stats.values.min)]
  end

  def team_info(team_id)
    teams = CSV.open(@team_path, headers: true, header_converters: :symbol)
    team_hash = Hash.new()
    teams.each do |row|
      if row[:team_id] == team_id
        team_hash['team_name'] = row[:teamname]
        team_hash['team_id'] = row[:team_id]
        team_hash['franchise_id'] = row[:franchiseid]
        team_hash['abbreviation'] = row[:abbreviation]
        team_hash['link'] = row[:link]
      end
    end
    team_hash
  end

  def best_season(team_id)
    team_seasons = Hash.new { |season_id, games_won| season_id[games_won] = [0.0, 0.0] }
    season = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    season.each do |row|
      if row[:team_id] == team_id
        team_seasons[row[:game_id][0..3]][0] += 1
        if row[:result] == 'WIN'
          team_seasons[row[:game_id][0..3]][1] += 1
        end
      end
    end
    highest_win_percentage = 0.0
    winningest_season = ''
      team_seasons.each do |season, wins_games|
        if highest_win_percentage < wins_games[1] / wins_games[0]
          highest_win_percentage = wins_games[1] / wins_games[0]
          winningest_season = season
        end
      end

      return "#{winningest_season}#{winningest_season.next}"
  end

  def worst_season(team_id)
    team_seasons = Hash.new { |season_id, games_won| season_id[games_won] = [0.0, 0.0] }
    season = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    season.each do |row|
      if row[:team_id] == team_id
        team_seasons[row[:game_id][0..3]][0] += 1
        if row[:result] == 'WIN'
          team_seasons[row[:game_id][0..3]][1] += 1
        end
      end
    end
    highest_win_percentage = 1.0
    losingest_season = ''
    team_seasons.each do |season, wins_games|
      if highest_win_percentage > wins_games[1] / wins_games[0]
        highest_win_percentage = wins_games[1] / wins_games[0]
        losingest_season = season
      end
    end
    return "#{losingest_season}#{losingest_season.next}"
  end

  def average_win_percentage(team_id)
    games_played = 0.0
    games_won = 0.0
    game_teams = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    game_teams.each do |row|
      if row[:team_id] == team_id
        games_played += 1
        if row[:result] == "WIN"
          games_won += 1
        end
      end
    end
    (games_won / games_played).round(2)
  end

  def most_goals_scored(team_id)
    highest_goal = 0
    game_teams_csv = CSV.open(@game_teams_path, headers: true, header_converters: :symbol)
    game_teams_csv.each do |row|
      if row[:team_id] == team_id
        if row[:goals].to_i > highest_goal
          highest_goal = row[:goals].to_i
        end
      end
    end
    highest_goal
  end

end
