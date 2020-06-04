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
    @game_teams = GameTeamsCollection.all(info[:game_teams])
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
    teams.count
  end

  def best_offense
    teams_with_goals = Hash.new
    game_teams.each do |game_by_team|
      teams_with_goals[game_by_team.team_id] = game_by_team.goals if teams_with_goals[game_by_team.team_id].nil?
      teams_with_goals[game_by_team.team_id] += game_by_team.goals
    end
    duplicated_games = game_teams.count  {|game_by_team| game_by_team.game_id}
    game_number = (duplicated_games - (duplicated_games%2)) / 2
    average_goals = teams_with_goals.each_value do |score|
      score/game_number
    end

    best_team = average_goals.each_pair.reduce do |result, key_value|
      if key_value[1] > result[1]
        key_value
      else
        result
      end
    end

    teams.find do |team|
      team.id.to_i == best_team[0]
    end.name
  end

  def worst_offense
    teams_with_goals = Hash.new
    game_teams.each do |game_by_team|
      teams_with_goals[game_by_team.team_id] = game_by_team.goals if teams_with_goals[game_by_team.team_id].nil?
      teams_with_goals[game_by_team.team_id] += game_by_team.goals
    end
    duplicated_games = game_teams.count  {|game_by_team| game_by_team.game_id}
    game_number = (duplicated_games - (duplicated_games%2)) / 2
    average_goals = teams_with_goals.each_value do |score|
      score/game_number
    end

    worst_team = average_goals.each_pair.reduce do |result, key_value|
      if key_value[1] < result[1]
        key_value
      else
        result
      end
    end

    teams.find do |team|
      team.id.to_i == worst_team[0]
    end.name
  end

  def highest_scoring_visitor
    away_teams = game_teams.find_all do |game_by_team|
      game_by_team.hoa == "away"
    end
    # away_teams is an array of GameTeam objects
    teams_with_goals = {}
    away_teams.each do |game_team|
      teams_with_goals[game_team.team_id] = game_team.goals if teams_with_goals[game_team.team_id].nil?
      teams_with_goals[game_team.team_id] += game_team.goals
    end
    duplicated_games = game_teams.count  {|game_by_team| game_by_team.game_id}
    game_number = (duplicated_games - (duplicated_games%2)) / 2

    teams_with_goals.update(teams_with_goals) do |team, goals|
      goals.to_f / game_number
    end

    highest_visitor = teams_with_goals.each_pair.reduce do |result, key_value|
      if key_value[1] > result[1]
        key_value
      else
        result
      end
    end

    teams.find do |team|
      team.id.to_i == highest_visitor[0]
    end.name
  end

  def lowest_scoring_visitor
    away_teams = game_teams.find_all do |game_by_team|
      game_by_team.hoa == "away"
    end
    # away_teams is an array of GameTeam objects
    teams_with_goals = {}
    away_teams.each do |game_team|
      teams_with_goals[game_team.team_id] = game_team.goals if teams_with_goals[game_team.team_id].nil?
      teams_with_goals[game_team.team_id] += game_team.goals
    end
    duplicated_games = game_teams.count  {|game_by_team| game_by_team.game_id}
    game_number = (duplicated_games - (duplicated_games%2)) / 2

    teams_with_goals.update(teams_with_goals) do |team, goals|
      goals.to_f / game_number
    end

    lowest_visitor = teams_with_goals.each_pair.reduce do |result, key_value|
      if key_value[1] < result[1]
        key_value
      else
        result
      end
    end

    teams.find do |team|
      team.id.to_i == lowest_visitor[0]
    end.name
  end

  def highest_scoring_home_team
    home_teams = game_teams.find_all do |game_by_team|
      game_by_team.hoa == "home"
    end
    # away_teams is an array of GameTeam objects
    teams_with_goals = {}
    home_teams.each do |game_team|
      teams_with_goals[game_team.team_id] = game_team.goals if teams_with_goals[game_team.team_id].nil?
      teams_with_goals[game_team.team_id] += game_team.goals
    end
    duplicated_games = game_teams.count  {|game_by_team| game_by_team.game_id}
    game_number = (duplicated_games - (duplicated_games%2)) / 2

    teams_with_goals.update(teams_with_goals) do |team, goals|
      goals.to_f / game_number
    end

    highest_home = teams_with_goals.each_pair.reduce do |result, key_value|
      if key_value[1] > result[1]
        key_value
      else
        result
      end
    end

    teams.find do |team|
      team.id.to_i == highest_home[0]
    end.name
  end

  def lowest_scoring_home_team
    home_teams = game_teams.find_all do |game_by_team|
      game_by_team.hoa == "home"
    end
    # away_teams is an array of GameTeam objects
    teams_with_goals = {}
    home_teams.each do |game_team|
      teams_with_goals[game_team.team_id] = game_team.goals if teams_with_goals[game_team.team_id].nil?
      teams_with_goals[game_team.team_id] += game_team.goals
    end
    duplicated_games = game_teams.count  {|game_by_team| game_by_team.game_id}
    game_number = (duplicated_games - (duplicated_games%2)) / 2

    teams_with_goals.update(teams_with_goals) do |team, goals|
      goals.to_f / game_number
    end

    lowest_home = teams_with_goals.each_pair.reduce do |result, key_value|
      if key_value[1] > result[1]
        key_value
      else
        result
      end
    end

    teams.find do |team|
      team.id.to_i == lowest_home[0]
    end.name
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

  def season_games(season)
    game_array = []
    @games.select do |game|
      game.season == season
      game_array << game
    end
    @game_id_array = game_array.map {|game| game.id}
  end

  def coach_games(game_array)
    coach_hash = Hash.new(0)
    @game_teams.each do |gameteam|
      require "pry"
      binding.pry
      @game_id_array.include?(gameteam.game_id)
        coach_hash[gameteam.head_coach] += 1
    end
    coach_hash
  end

  def winningest_coach(season)
        season_game_array = season_games(season)
        require "pry"
        binding.pry
        win_percent = Hash.new(0)
        total_coach_games = coach_games(season_game_array)
        @game_teams.each do |gameteam|
              @game_id_array.include?(gameteam.game_id)
              if (gameteam.result == "WIN")
                logic = (1.to_f / (total_coach_games[gameteam.head_coach]))
                win_percent[gameteam.head_coach] += logic
              end
        end
        coach_winner = win_percent.max_by do |key, value|
        win_percent[key]
      end
      require "pry"
      binding.pry
      coach_winner.first
  end

  def worst_coach(season)
    win_loss = {}
    @games.each do |game|
      season == game.season
        @game_teams.each do |gameteam|
          game.id == gameteam.game_id
          win_loss[gameteam.head_coach] ||= { win: 0, tot: 0, pct: 0 }
          win_loss[gameteam.head_coach][:tot] += 1
          if gameteam.result == "WIN"
            win_loss[gameteam.head_coach][:win] += 1
          end
          win_loss[gameteam.head_coach][:pct] = ((win_loss[gameteam.head_coach][:win] / win_loss[gameteam.head_coach][:tot].to_f) * 100).round(2)
        end
      return win_loss.min_by { |k, v| v[:pct]  }[0]
    end
  end

  def most_accurate_team(season)
    # most_accurate_team. Name of team w/ best ratio of shots to goals for the season	String
    team_id_hash = {}
    @games.each do |game|
      season == game.season
        @game_teams.each do |gameteam|
          game.id == gameteam.game_id
          team_id_hash[gameteam.team_id] ||= { shots: 0, goals: 0 }
          team_id_hash[gameteam.team_id][:shots] += gameteam.shots
          team_id_hash[gameteam.team_id][:goals] += gameteam.goals
        end
        team_id_hash.map do |k, v|
          team_id_hash[k] = ( v[:goals].to_f / v[:shots].to_f )
      end
      return @teams[(team_id_hash.max_by { |k, v| v }[0])].name
    end
  end

  def least_accurate_team(season)
    # most_accurate_team. Name of team w/ best ratio of shots to goals for the season	String
    team_id_hash = {}
    @games.each do |game|
      season == game.season
        @game_teams.each do |gameteam|
          game.id == gameteam.game_id
          team_id_hash[gameteam.team_id] ||= { shots: 0, goals: 0 }
          team_id_hash[gameteam.team_id][:shots] += gameteam.shots
          team_id_hash[gameteam.team_id][:goals] += gameteam.goals
        end
        team_id_hash.map do |k, v|
          team_id_hash[k] = ( v[:goals].to_f / v[:shots].to_f )
      end
      return @teams[(team_id_hash.min_by { |k, v| v }[0])].name
    end
  end

  def most_tackles(season)
    team_id_hash = {}
    @games.each do |game|
      season == game.season
        @game_teams.each do |gameteam|
          game.id == gameteam.game_id
          team_id_hash[gameteam.team_id] ||= gameteam.tackles
        end
        return @teams[(team_id_hash.max_by { |k, v| v }[0])].name
      end
  end

  def least_tackles(season)
    team_id_hash = {}
    @games.each do |game|
      season == game.season
        @game_teams.each do |gameteam|
          game.id == gameteam.game_id
          team_id_hash[gameteam.team_id] ||= gameteam.tackles
        end
        return @teams[(team_id_hash.min_by { |k, v| v }[0])].name
      end
  end

end
