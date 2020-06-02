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
    @game_teams = GameTeamsCollection.new(info[:game_teams])
  end

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

  def average_win_percentage(team_id)
    total = 0
    games.all.each do |game|
      game.home_team_id || game.away_team_id == team_id
        total += 1
    end

    games_won = []
    games.all.find_all do |game|
      if team_id == game.away_team_id && game.away_goals > game.home_goals || team_id == game.home_team_id && game.home_goals > game.away_goals
        games_won << game
      end
    end

    average = games_won.count.to_f / total_games(team_id).to_f
    return average.round(2)
  end

  def most_goals_scored(id)
    home_goals_scored = games.all.map do |game|
      game.home_goals
    end
    away_goals_scored = games.all.map do |game|
      game.away_goals
    end
    home_goals_scored.max.to_i
    away_goals_scored.max.to_i
  end

  def fewest_goals_scored(id)
    goals_scored = games.all.map do |game|
      game.home_goals || game.away_goals
    end
    goals_scored.min.to_i
  end

  def favorite_opponent(team_id)
    games_won_against_opponent = Hash.new(0)
    games.all.map do |team|
      if team.home_team_id || team.away_team_id == team_id
        if team.home_team_id == team_id && team.home_goals > team.away_goals
          games_won_against_opponent[team.away_team_id] += 1
        else team.away_team_id == team_id && team.away_goals > team.home_goals
          games_won_against_opponent[team.home_team_id] += 1
        end
      end
    end
    favorite_id = games_won_against_opponent.key(games_won_against_opponent.values.max)

    favorite_team = teams.all.find do |team|
      if team.id == favorite_id
        return team.name
      end
    end

  end
end 
