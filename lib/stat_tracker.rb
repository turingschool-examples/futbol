require_relative './game'
require_relative './team'
require_relative './game_teams'
require_relative './game_collection'
require_relative './team_collection'
require_relative './game_teams_collection'
require 'csv'
require 'pry'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(info)
    @games = GameCollection.new(info[:games])
    @teams = TeamCollection.new(info[:teams])
    @game_teams = info[:game_teams]
  end

  def self.from_csv(info)
    StatTracker.new(info)
  end

  # Game Statistics Methods
  def highest_total_score
    games.all.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end.max
  end

  def lowest_total_score
    games.all.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end.min
  end

  def percentage_home_wins
    home_wins = 0
    games.all.each do |game|
      home_wins += 1 if game.home_goals.to_i > game.away_goals.to_i
    end
    (home_wins.to_f / games.all.size).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    games.all.each do |game|
      visitor_wins += 1 if game.away_goals.to_i > game.home_goals.to_i
    end
    (visitor_wins.to_f / games.all.size).round(2)
  end

  def percentage_ties
    ties = 0
    games.all.each do |game|
      ties += 1 if game.away_goals.to_i == game.home_goals.to_i
    end
    (ties.to_f / games.all.size).round(2)
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)
    games.all.each do |game|
      games_by_season[game.season] += 1
    end
    games_by_season
  end

  def average_goals_per_game
    average_goals = 0
    games.all.each do |game|
      average_goals += game.away_goals.to_i
      average_goals += game.home_goals.to_i
    end
    (average_goals.to_f / games.all.count).round(2)
  end

  #TeamStatisticsTest

  def self.from_csv(info)
    StatTracker.new(info)
  end

  def team_info(id)
    all_teams = @teams.all
    found_team = all_teams.find do |team|
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
    games.all.count do |game|
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
      games.all.each do |game|
        team_games_by_season[game.season] += 1 if
         game.home_team_id == id || game.away_team_id == id
      end
      team_games_by_season
    end

    def count_wins(team_id, total_games)
      wins = 0
      games.all.each do |game|
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
    games.all.each do |game|
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
    games.all.each do |game|
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

  # def best_season(team_id)
  #   games_played = total_games(team_id) #4
  #
  #
  #   win_percentage_by_season = games_by_season.transform_values do |season|
  #     games_won = count_wins(team_id, season)
  #     (games_won/season.length.to_f).round(2)
  #   end
  #   win_percentage_by_season.max
  # end





end







    #hard code - for each team, per season, take percentage of wins / count of games per season
    #return season
  #   all_game_teams = GameTeamsCollection.new(@game_teams)
  #   win_team_id = []
  #   loss_team_id = []
  #   all_game_teams.all.each do |game_team|
  #     win_team_id << game_team.team_id if game_team.result == "WIN"
  #   win_team_id
  #     loss_team_id << game_team.team_id if game_team.result == "LOSS"
  #   end
  #   loss_team_id
  #
  #
  #   #wins = 0
  #   all_game_teams.all.map do |game_team|
  #     win_team_id.count
  #   binding.pry
