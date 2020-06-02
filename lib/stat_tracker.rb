require_relative './game'
require_relative './team'
require_relative './game_teams'
require_relative './game_collection'
require_relative './team_collection'
require_relative './game_teams_collection'
require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(info)
    @games = GameCollection.all(info[:games])
    @teams = TeamCollection.all(info[:teams])
    @game_teams = GameTeamCollection.all(info[:game_teams])
  end

  def self.from_csv(info)
    StatTracker.new(info)
  end

  # Game Statistics Methods

  def highest_total_score
    games.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end.max
  end

  def lowest_total_score
    games.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end.min
  end

  def percentage_home_wins
    home_wins = 0
    games.each do |game|
      home_wins += 1 if game.home_goals.to_i > game.away_goals.to_i
    end
    (home_wins.to_f / games.size).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    games.each do |game|
      visitor_wins += 1 if game.away_goals.to_i > game.home_goals.to_i
    end
    (visitor_wins.to_f / games.size).round(2)
  end

  def percentage_ties
    ties = 0
    games.each do |game|
      ties += 1 if game.away_goals.to_i == game.home_goals.to_i
    end
    (ties.to_f / games.size).round(2)
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)
    games.each do |game|
      games_by_season[game.season] += 1
    end
    games_by_season
  end

  def average_goals_per_game
    average_goals = 0
    games.each do |game|
      average_goals += game.away_goals.to_i
      average_goals += game.home_goals.to_i
    end
    (average_goals.to_f / games.count).round(2)
  end

  def average_goals_by_season
    goals_by_season = Hash.new(0)
    games.each do |game|
      goals_by_season[game.season] += (game.away_goals.to_i.to_f + game.home_goals.to_i)
    end
    goals_by_season.each do |season, count|
      average_goals = (count / count_of_games_by_season[season])
      average_goals.round(2)
      goals_by_season[season] = average_goals.round(2)
    end
    goals_by_season
  end

  # League Statistics Methods

  def count_of_teams
    @teams.count
  end

  def best_offense
    each_game = @game_teams.map do |row|
      GameTeams.new(row)
    end

    each_team = @teams.map do |row|
      Team.new(row)
    end

    each_game = each_game.group_by do |game_team|
      game_team.team_id
    end

    average_goals_per_team = {}
    each_game = each_game.each_value do |game_teams_array|
      team_goals = game_teams_array.map do |game_team|
        game_team.goals
      end

      game_number = team_goals.count
      game_team = game_teams_array[0]
      team_id = game_team.team_id
      average_goals = (team_goals.sum.to_f)/game_number.to_f
      average_goals_per_team[team_id] = average_goals
    end

    worst_team = average_goals_per_team.each_pair.reduce do |memo, key_value|
      if key_value[1] > memo[1]
        key_value
      else
        memo
      end
    end

    correct_team = nil
    each_team.find do |team|
      if team.id.to_i == worst_team[0]
        correct_team = team.name
      end
    end
    correct_team
  end

  def worst_offense
    game_stats = CSV.read(@game_teams, headers: true, header_converters: :symbol)

    each_game = game_stats.map do |row|
      GameTeams.new(row)
    end

    teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    each_team = teams.map do |row|
      Team.new(row)
    end

    each_game = each_game.group_by do |game_team|
      game_team.team_id
    end

    average_goals_per_team = {}
    each_game = each_game.each_value do |game_teams_array|
      team_goals = game_teams_array.map do |game_team|
        game_team.goals
      end

      game_number = team_goals.count
      game_team = game_teams_array[0]
      team_id = game_team.team_id
      average_goals = (team_goals.sum.to_f)/game_number.to_f
      average_goals_per_team[team_id] = average_goals
    end

    worst_team = average_goals_per_team.each_pair.reduce do |memo, key_value|
      if key_value[1] < memo[1]
        key_value
      else
        memo
      end
    end

    correct_team = nil
    each_team.find do |team|
      if team.id.to_i == worst_team[0]
        correct_team = team.name
      end
    end

    correct_team
  end

  def highest_scoring_visitor
    game_stats = CSV.read(@game_teams, headers: true, header_converters: :symbol)

    each_game = game_stats.map do |row|
      GameTeams.new(row)
    end

    teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    each_team = teams.map do |row|
      Team.new(row)
    end

    each_game = each_game.group_by do |game_team|
      game_team.team_id
    end

    average_goals_per_team = {}
    each_game = each_game.each_value do |game_teams_array|
      team_goals = game_teams_array.map do |game_team|
        game_team.goals
      end

      game_number = team_goals.count
      game_team = game_teams_array[0]
      team_id = game_team.team_id
      average_goals = (team_goals.sum.to_f)/game_number.to_f
      average_goals_per_team[team_id] = average_goals
    end

    worst_team = average_goals_per_team.each_pair.reduce do |memo, key_value|
      if key_value[1] < memo[1]
        key_value
      else
        memo
      end
    end

    correct_team = nil
    each_team.find do |team|
      if team.id.to_i == worst_team[0]
        correct_team = team.name
      end
    end

    correct_team
  end


  def highest_scoring_visitor
    game_stats = CSV.read(@game_teams, headers: true, header_converters: :symbol)

    each_game = game_stats.map do |row|
      if row[:hoa] == "away"
        GameTeams.new(row)
      end
    end.reject { |element| element.nil?}

    teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    each_team = teams.map do |row|
      Team.new(row)
    end

    each_game = each_game.group_by do |game_team|
      game_team.team_id
    end

    average_goals_per_team = {}
    each_game = each_game.each_value do |game_teams_array|
      team_goals = game_teams_array.map do |game_team|
        game_team.goals
      end

      game_number = team_goals.count
      game_team = game_teams_array[0]
      team_id = game_team.team_id
      average_goals = (team_goals.sum.to_f)/game_number.to_f
      average_goals_per_team[team_id] = average_goals
    end

    best_team = average_goals_per_team.each_pair.reduce do |memo, key_value|
      if key_value[1] > memo[1]
        key_value
      else
        memo
      end
    end

    correct_team = nil
    each_team.find do |team|
      if team.id.to_i == best_team[0]
        correct_team = team.name
      end
    end

    correct_team
  end

  def lowest_scoring_visitor
    game_stats = CSV.read(@game_teams, headers: true, header_converters: :symbol)

    each_game = game_stats.map do |row|
      if row[:hoa] == "away"
        GameTeams.new(row)
      end
    end.reject { |element| element.nil?}

    teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    each_team = teams.map do |row|
      Team.new(row)
    end

    each_game = each_game.group_by do |game_team|
      game_team.team_id
    end

    average_goals_per_team = {}
    each_game = each_game.each_value do |game_teams_array|
      team_goals = game_teams_array.map do |game_team|
        game_team.goals
      end

      game_number = team_goals.count
      game_team = game_teams_array[0]
      team_id = game_team.team_id
      average_goals = (team_goals.sum.to_f)/game_number.to_f
      average_goals_per_team[team_id] = average_goals
    end

    worst_team = average_goals_per_team.each_pair.reduce do |memo, key_value|
      if key_value[1] < memo[1]
        key_value
      else
        memo
      end
    end

    correct_team = nil
    each_team.find do |team|
      if team.id.to_i == worst_team[0]
        correct_team = team.name
      end
    end

    correct_team
  end

  def highest_scoring_home_team
    game_stats = CSV.read(@game_teams, headers: true, header_converters: :symbol)

    each_game = game_stats.map do |row|
      if row[:hoa] == "home"
        GameTeams.new(row)
      end
    end.reject { |element| element.nil?}

    teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    each_team = teams.map do |row|
      Team.new(row)
    end

    each_game = each_game.group_by do |game_team|
      game_team.team_id
    end

    average_goals_per_team = {}
    each_game = each_game.each_value do |game_teams_array|
      team_goals = game_teams_array.map do |game_team|
        game_team.goals
      end

      game_number = team_goals.count
      game_team = game_teams_array[0]
      team_id = game_team.team_id
      average_goals = (team_goals.sum.to_f)/game_number.to_f
      average_goals_per_team[team_id] = average_goals
    end

    best_team = average_goals_per_team.each_pair.reduce do |memo, key_value|
      if key_value[1] > memo[1]
        key_value
      else
        memo
      end
    end

    correct_team = nil
    each_team.find do |team|
      if team.id.to_i == best_team[0]
        correct_team = team.name
      end
    end

    correct_team
  end

  def lowest_scoring_home_team
    game_stats = CSV.read(@game_teams, headers: true, header_converters: :symbol)

    each_game = game_stats.map do |row|
      if row[:hoa] == "home"
        GameTeams.new(row)
      end
    end.reject { |element| element.nil?}

    teams = CSV.read(@teams, headers: true, header_converters: :symbol)
    each_team = teams.map do |row|
      Team.new(row)
    end

    each_game = each_game.group_by do |game_team|
      game_team.team_id
    end

    average_goals_per_team = {}
    each_game = each_game.each_value do |game_teams_array|
      team_goals = game_teams_array.map do |game_team|
        game_team.goals
      end

      game_number = team_goals.count
      game_team = game_teams_array[0]
      team_id = game_team.team_id
      average_goals = (team_goals.sum.to_f)/game_number.to_f
      average_goals_per_team[team_id] = average_goals
    end

    worst_team = average_goals_per_team.each_pair.reduce do |memo, key_value|
      if key_value[1] < memo[1]
        key_value
      else
        memo
      end
    end

    correct_team = nil
    each_team.find do |team|
      if team.id.to_i == worst_team[0]
        correct_team = team.name
      end
    end
    correct_team
  end

  #TeamStatisticsTest

  def team_info(id)
    found_team = teams.find do |team|
      team.id == id
    end
    team_info_hash = {"team_id" => found_team.id,
      "franchise_id" => found_team.franchise_id,
      "team_name" => found_team.name,
      "abbreviation" => found_team.abbreviation,
      "link" => found_team.link
    }
    team_info_hash
  end

  def total_games(team_id)
    total_games = 0
    games.count do |game|
      is_home_team = game.home_team_id == team_id
      is_away_team = game.away_team_id == team_id
      if is_home_team || is_away_team
         total_games += 1
      else
        next
      end
    end
    total_games
  end


  def team_count_of_games_by_season(id)
    team_games_by_season = Hash.new(0)
    games.each do |game|
      team_games_by_season[game.season] += 1 if
       game.home_team_id == id || game.away_team_id == id
    end
    team_games_by_season
  end

  def count_wins(team_id, total_games)
    wins = 0
    games.each do |game|
      if team_id == game.away_team_id && game.away_goals > game.home_goals
        wins += 1
      elsif team_id == game.home_team_id && game.home_goals > game.away_goals
        wins += 1
      end
    end
    wins
  end

  def total_team_wins_per_season(id)
    wins_by_season = Hash.new(0)
    games.each do |game|
      if game.home_team_id == id
        wins_by_season[game.season] += 1 if game.home_goals > game.away_goals
      elsif game.away_team_id == id
        wins_by_season[game.season] += 1 if game.away_goals > game.home_goals
      else
        next
      end
    end
    wins_by_season
  end

  def percentage_wins_per_season(id)
    seasons = []
    games.each do |game|
      seasons << game.season
    end
    seasons.uniq!
    percent_wins = Hash.new(0)
    seasons.each do |season|
      if team_count_of_games_by_season(id)[season] != 0
        percent_wins[season] = (total_team_wins_per_season(id)[season].to_f / team_count_of_games_by_season(id)[season]).round(3)
      else
        next
      end
    end
    percent_wins
  end

  def best_season(id)
   highest_win_percent = percentage_wins_per_season(id).values.max
   percentage_wins_per_season(id).invert[highest_win_percent]
  end

  def worst_season(id)
    lowest_win_percent = percentage_wins_per_season(id).values.min
    percentage_wins_per_season(id).invert[lowest_win_percent]
  end

  def average_win_percentage(team_id)
    total = 0
    games.each do |game|
      game.home_team_id || game.away_team_id == team_id
        total += 1
    end

    games_won = []
    games.find_all do |game|
      if team_id == game.away_team_id && game.away_goals > game.home_goals || team_id == game.home_team_id && game.home_goals > game.away_goals
        games_won << game
      end
    end

    average = games_won.count.to_f / total_games(team_id).to_f
    return average.round(2)
  end

  def most_goals_scored(id)
    home_goals_scored = games.map do |game|
      game.home_goals
    end
    away_goals_scored = games.map do |game|
      game.away_goals
    end
    home_goals_scored.max.to_i
    away_goals_scored.max.to_i
  end

  def fewest_goals_scored(id)
    goals_scored = games.map do |game|
      game.home_goals || game.away_goals
    end
    goals_scored.min.to_i
  end

  def favorite_opponent(team_id)
    games_won_against_opponent = Hash.new(0)
    games.map do |team|
      if team.home_team_id || team.away_team_id == team_id
        if team.home_team_id == team_id && team.home_goals > team.away_goals
          games_won_against_opponent[team.away_team_id] += 1
        else team.away_team_id == team_id && team.away_goals > team.home_goals
          games_won_against_opponent[team.home_team_id] += 1
        end
      end
    end
    favorite_id = games_won_against_opponent.key(games_won_against_opponent.values.max)

    teams.find do |team|
      if team.id == favorite_id
        return team.name
      end
    end

  end


    def rival(team_id)
      games_won_against_opponent = Hash.new(0)
      games.map do |team|
        if team.home_team_id || team.away_team_id == team_id
          if team.home_team_id == team_id && team.home_goals > team.away_goals
            games_won_against_opponent[team.away_team_id] += 1
          else team.away_team_id == team_id && team.away_goals > team.home_goals
            games_won_against_opponent[team.home_team_id] += 1
          end
        end
      end
      rival_id = games_won_against_opponent.key(games_won_against_opponent.values.min)

      teams.find do |team|
        if team.id == rival_id
          return team.name
        end
      end
    end



end
