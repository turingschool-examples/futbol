
require 'csv'
require_relative './game_teams_collection'
require_relative './game_collection'
require_relative './team_collection'

class StatTracker

  def self.from_csv(locations)
    raw_data = {}
    raw_data[:game_data] = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    raw_data[:team_data] = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    raw_data[:game_teams_data] = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

    StatTracker.new(raw_data)
  end

  attr_reader :game_collection, :team_collection, :gtc
  def initialize(raw_data)
    @game_data = raw_data[:game_data]
    @team_data = raw_data[:team_data]
    @game_teams_data = raw_data[:game_teams_data]
    @gtc = nil
    @game_collection = nil
    @team_collection = nil
    construct_collections
  end

  def construct_collections
    @gtc = GameTeamsCollection.new(@game_teams_data)
    @game_collection = GameCollection.new(@game_data)
    @team_collection = TeamCollection.new(@team_data)
  end

  ### Iteration 2 # - - - - - - - - - - - - - - - - - - -

  def highest_total_score
    game_collection.games.map do |game|
      game.home_goals + game.away_goals
    end.max
  end

  def lowest_total_score
    game_collection.games.map do |game|
      game.home_goals + game.away_goals
    end.min
  end

  def biggest_blowout
    game_collection.games.map do |game|
      Math.sqrt((game.home_goals - game.away_goals)**2).to_i
    end.max
  end

  def percentage_home_wins
    home_wins = game_collection.games.find_all do |game|
      game.home_goals > game.away_goals
    end
    (home_wins.length.to_f / game_collection.games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = game_collection.games.find_all do |game|
      game.away_goals > game.home_goals
    end
    (visitor_wins.length.to_f / game_collection.games.length).round(2)
  end

  def percentage_ties
    ties = game_collection.games.find_all do |game|
      game.home_goals == game.away_goals
    end.length
    (ties / game_collection.games.length.to_f).round(2)
  end

  def count_of_games_by_season
    games_per_season = Hash.new(0)
    game_collection.games.each do |game|
      games_per_season[game.season] += 1
    end
    games_per_season
  end

  def average_goals_per_game
    total_goals_per_game = game_collection.games.map do |game|
      game.home_goals + game.away_goals
    end
    (total_goals_per_game.sum.to_f / game_collection.games.length).round(2)
  end

  def average_goals_by_season
    games_grouped_by_season = game_collection.games.group_by do |game|
      game.season
    end
    games_grouped_by_season.each_pair do |season, games_by_season|
      total_goals = games_by_season.map do |single_game|
        single_game.home_goals + single_game.away_goals
      end
    average = (total_goals.sum.to_f / total_goals.length).round(2)
    games_grouped_by_season[season] = average
    end
  end

  ## Iteration 3 # - - - - - - - - - - - - - - - - - - - - -
  def count_of_teams
    @team_collection.teams.length
  end

  def best_offense
    game_teams_grouped_by_team_id = @gtc.game_teams.group_by do |game_team|
      game_team.team_id
    end
    x = game_teams_grouped_by_team_id.each_pair do |team_id, games_by_team|
      total_goals = games_by_team.map do |single_game|
        single_game.goals
      end
      game_team_averages = (total_goals.sum.to_f / total_goals.length).round(2)
      (game_teams_grouped_by_team_id[team_id] = game_team_averages)
    end
    team_name_by_id(x.key(x.values.max))
  end

  def worst_offense
    game_teams_grouped_by_team_id = @gtc.game_teams.group_by do |game_team|
      game_team.team_id
    end
    x = game_teams_grouped_by_team_id.each_pair do |team_id, games_by_team|
      total_goals = games_by_team.map do |single_game|
        single_game.goals
      end
      game_team_averages = (total_goals.sum.to_f / total_goals.length).round(2)
      (game_teams_grouped_by_team_id[team_id] = game_team_averages)
    end
    team_name_by_id(x.key(x.values.min))
  end

  def best_defense
    allowed = all_goals_allowed_by_team
    games = total_games_by_team
    average_goals_allowed = {}
    allowed.each do |team_id, goals_allowed|
      average_goals_allowed[team_id] = goals_allowed / total_games_by_team[team_id].to_f
    end
    team_name_by_id(average_goals_allowed.key(average_goals_allowed.values.min))
  end

  def worst_defense
    #Colin work in progress
  end

  def lowest_scoring_visitor
    #team with lowest totals when playing as visitor
    require "pry"; binding.pry
  end

  def worst_fans
    home_w = hoa_wins_by_team("home")
    away_w = hoa_wins_by_team("away")
    teams = away_w.select do |team, away_wins|
      home_w[team] < away_wins
    end.keys
    teams.map { |team_id| team_name_by_id(team_id) }
  end

  def lowest_scoring_home_team
    home_games = hoa_games_by_team("home")
    home_goals = hoa_goals_by_team("home")
    home_goals_per_game = {}
    home_goals.each do |team_id, total_home_goals|
      next if total_home_goals == 0
      home_goals_per_game[team_id] = total_home_goals / hoa_games_by_team("home")[team_id].to_f
    end
    team_name_by_id(home_goals_per_game.key(home_goals_per_game.values.min))
  end

  def winningest_team
    total_games_by_team
    total_wins_by_team
    winning_percentages = total_games_by_team.merge(total_games_by_team) do |team_id, total_games|
      total_wins_by_team[team_id] / total_games.to_f
    end
    team_name_by_id(winning_percentages.key(winning_percentages.values.max))
  end

  def highest_scoring_visitor
    away_games = hoa_games_by_team("away")
    away_goals = hoa_goals_by_team("away")
    away_goals_per_game = {}
    away_goals.each do |team_id, total_away_goals|
      next if total_away_goals == 0
      away_goals_per_game[team_id] = total_away_goals / hoa_games_by_team("away")[team_id].to_f
      end
    team_name_by_id(away_goals_per_game.key(away_goals_per_game.values.max))
  end

  def highest_scoring_home_team
    home_games = hoa_games_by_team("home")
    home_goals = hoa_goals_by_team("home")
    home_goals_per_game = {}
    home_goals.each do |team_id, total_home_goals|
      next if total_home_goals == 0
      home_goals_per_game[team_id] = total_home_goals / hoa_games_by_team("home")[team_id].to_f
    end
    team_name_by_id(home_goals_per_game.key(home_goals_per_game.values.max))
  end

  def best_fans
    #biggest diff between home win % and away win %
    home_games_played = hoa_games_by_team("home")
    home_games_won = hoa_wins_by_team("home")
    away_games_played = hoa_games_by_team("away")
    away_games_won = hoa_wins_by_team("away")
    home_percentage = home_games_played.merge(home_games_played) do |team, home_game|
      home_games_won[team] / home_game.to_f
    end
    away_percentage = away_games_played.merge(away_games_played) do |team, away_game|
      away_games_won[team] / away_game.to_f
    end
    differences = home_percentage.merge(home_percentage) do |team, percent|
      (percent - away_percentage[team])
    end
    team_and_difference = differences.max_by { |team, difference| difference}
    team_name_by_id(team_and_difference[0])
  end

  ###### Iterartion 2/3 Helpers - - - - - - - - - - - - - - - - - -
  def total_games_by_season
    games_in_season = Hash.new(0)
    game_collection.games.each do |game|
      games_in_season[game.season] += 1
    end
    games_in_season
  end

  def team_name_by_id(team_id)
    team_collection.teams.find do |team|
      team.team_id == team_id
    end.teamname
  end

  def total_games_by_team
    games_by_team = Hash.new(0)
    game_collection.games.each do |game|
      games_by_team[game.away_team_id] += 1
      games_by_team[game.home_team_id] += 1
    end
    games_by_team
  end

  def total_wins_by_team
    total_wins = Hash.new(0)
    gtc.game_teams.each do |game|
      if game.result == "WIN"
        total_wins[game.team_id] += 1
      elsif game.result == "LOSS"
        total_wins[game.team_id] =+ 0
      end
    end
    total_wins
  end

  def total_loss_by_team
    total_loss = Hash.new(0)
    gtc.game_teams.each do |game|
      if game.result == "LOSS"
        total_loss[game.team_id] += 1
      elsif game.result == "WIN"
        total_loss[game.team_id] =+ 0
      end
    end
    total_loss
  end

  def total_tie_by_team
    total_loss = Hash.new(0)
    gtc.game_teams.each do |game|
      if game.result == "TIE"
        total_loss[game.team_id] += 1
      elsif game.result == "WIN"
        total_loss[game.team_id] =+ 0
      elsif game.result == "LOSS"
        total_loss[game.team_id] += 0
      end
    end
    total_loss
  end

  def all_goals_scored_by_team
    goals_scored_by_team = Hash.new(0)
    game_collection.games.each do |game|
      goals_scored_by_team[game.away_team_id] += game.away_goals
      goals_scored_by_team[game.home_team_id] += game.home_goals
    end
    goals_scored_by_team
  end

  def all_goals_allowed_by_team
    goals_allowed_by_team = Hash.new(0)
    game_collection.games.each do |game|
      goals_allowed_by_team[game.away_team_id] += game.home_goals
      goals_allowed_by_team[game.home_team_id] += game.away_goals
    end
    goals_allowed_by_team
  end

  def hoa_games_by_team(hoa)
    hoa_games_by_team = Hash.new(0)
    gtc.game_teams.find_all do |game|
      hoa_games_by_team[game.team_id] += 1 if hoa.downcase == game.hoa
    end
    hoa_games_by_team
  end

  def hoa_goals_by_team(hoa)
    hoa_goals_by_team = Hash.new(0)
    gtc.game_teams.find_all do |game|
      if game.hoa == hoa.downcase
        hoa_goals_by_team[game.team_id] += game.goals
      else
        hoa_goals_by_team[game.team_id] += 0
      end
    end
    hoa_goals_by_team
  end

  def hoa_wins_by_team(hoa)
    hoa_wins_by_team = Hash.new(0)
    gtc.game_teams.find_all do |game|
      if hoa.downcase == game.hoa && game.result == "WIN"
        hoa_wins_by_team[game.team_id] += 1
      else
        hoa_wins_by_team[game.team_id] += 0
      end
    end
    hoa_wins_by_team
  end

  def hoa_loss_by_team(hoa)
    hoa_loss_by_team = Hash.new(0)
    gtc.game_teams.find_all do |game|
      if hoa.downcase == game.hoa && game.result == "LOSS"
        hoa_loss_by_team[game.team_id] += 1
      else
        hoa_loss_by_team[game.team_id] += 0
      end
    end
    hoa_loss_by_team
  end

  def hoa_tie_by_team(hoa)
    hoa_tie_by_team = Hash.new(0)
    gtc.game_teams.find_all do |game|
      if hoa.downcase == game.hoa && game.result == "TIE"
        hoa_tie_by_team[game.team_id] += 1
      else
        hoa_tie_by_team[game.team_id] += 0
      end
    end
    hoa_tie_by_team
  end



  ###### Iteration 4 Methods - - - - - - - - - -- -- - - - - - -

  def worst_coach(season)
    averages = {}
    wins_in_season(season).each do |team_id, wins|
      avg = wins.to_f / games_by_team_by_season(season)[team_id]
      averages[team_id] = avg
    end
    coach = head_coaches(season)[averages.key(averages.values.min)]
  end

  def most_tackles(season)
    #works in one but not both years on big test
    most = games_in_season(season).max_by do |game|
      game.tackles
    end.team_id
    team_name_by_id(most)
  end

  def fewest_tackles(season)
    #works in one but not both years on big test
    min = games_in_season(season).min_by do |game|
      game.tackles
    end.team_id
    team_name_by_id(min)
  end

  def most_accurate_team(season)
    games = games_in_season(season)
    averages = games.reduce({}) do |avg, game|
      avg[game.team_id] = (game.goals / game.shots.to_f)
      avg
    end
    team_name_by_id(averages.key(averages.values.max))
  # Name of the Team with the best ratio of shots
  # to goals for the season	String
  end

  def least_accurate_team(season)
    games = games_in_season(season)
    averages = games.reduce({}) do |avg, game|
      avg[game.team_id] = (game.goals / game.shots.to_f)
      avg
    end
    team_name_by_id(averages.key(averages.values.min))
  # Name of the Team with the worst ratio of shots
  # to goals for the season
  end

####### it4 season helper methods
  def game_ids_in_season(season)
    game_collection.games.find_all do |game|
      season == game.season
    end.map { |game| game.game_id.to_i }
  end

  def games_in_season(season)
    game_ids_in_season(season).flat_map do |id|
      gtc.game_teams.find_all do |game|
        id == game.game_id
      end
    end
  end

  def games_by_team_by_season(season)
    games_per_team = Hash.new(0)
    game_collection.games.each do |game|
      if season == game.season
        games_per_team[game.home_team_id] += 1
        games_per_team[game.away_team_id] += 1
      end
    end
    games_per_team
  end

  def head_coaches(season)
    season_id = season.to_s[0..3]
    coaches = gtc.game_teams.find_all do |game|
      game.game_id.to_s[0..3] == season_id
    end
    coaches.reduce({}) do |coaches_in_season, game|
      coaches_in_season[game.team_id] = game.head_coach
      coaches_in_season
    end
  end

  def wins_in_season(season)
    winners = Hash.new(0)
    games = game_ids_in_season(season).flat_map do |id|
      gtc.game_teams.find_all do |game|
        id == game.game_id
      end
    end
    games.each do |game|
      if game.result == "WIN"
        winners[game.team_id] += 1
      else
        winners[game.team_id] += 0
      end
    end
    winners
  end

  ######## it5 Methods - - - - - - - - - - -

  def team_info(team_num)
    #tested to harness
    info = {}
    team_obj = retrieve_team(team_num.to_i)
      info["team_id"] = team_obj.team_id.to_s
      info["franchise_id"] = team_obj.franchiseid.to_s
      info["team_name"] = team_obj.teamname
      info["abbreviation"] = team_obj.abbreviation
      info["link"] = team_obj.link
      info
  end

  def most_goals_scored(team_num)
    #tested to harness
    total_scores_by_team(team_num).max
  end

  def fewest_goals_scored(team_num)
    #tested to harness
    total_scores_by_team(team_num).min
  end


  ##### it5 Helpers
  def retrieve_team(team_num)
    team_collection.teams.find { |team_obj| team_obj.team_id == team_num }
  end

  def total_scores_by_team(team_num)
    game_collection.games.reduce([]) do |scores, game|
      if team_num.to_i == game.home_team_id
        scores << game.home_goals
      elsif team_num.to_i == game.away_team_id
        scores << game.away_goals
      end
      scores
    end
  end


end
