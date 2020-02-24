require 'csv'
require_relative 'game'
require_relative 'game_team'
require_relative 'team'

class StatTracker
  def initialize()
  end

  def self.from_csv(locations)
    StatTracker.create_items(locations[:games], Game)
    StatTracker.create_items(locations[:game_teams], GameTeam)
    StatTracker.create_items(locations[:teams], Team)
    StatTracker.new()
  end

  def self.create_items(file, item_class)
    csv_options = {
                    headers: true,
                    header_converters: :symbol,
                    converters: :all
                  }
      CSV.foreach(file, csv_options) { |row| item_class.add(item_class.new(row.to_hash)) }
  end

  def find_games_in_regular_season(season)
    season = season.to_i
    Game.all.select do |game_id, game_data|
      game_data.season == season && game_data.type == "Regular Season"
    end
  end

  def find_games_in_post_season(season)
    season = season.to_i
    Game.all.select do |game_id, game_data|
      game_data.season == season && game_data.type == "Postseason"
    end
  end

  def find_regular_season_teams(season)
    season = season.to_i
    teams = []
    find_games_in_regular_season(season).select do |game_id, game_object|
      if !teams.include?(game_object.home_team_id)
        teams << game_object.home_team_id
      end
      if !teams.include?(game_object.away_team_id)
        teams << game_object.away_team_id
      end
    end
    teams
  end

  def find_post_season_teams(season)
    season = season.to_i
    teams = []
    find_games_in_post_season(season).select do |game_id, game_object|
      if !teams.include?(game_object.home_team_id)
        teams << game_object.home_team_id
      end
      if !teams.include?(game_object.away_team_id)
        teams << game_object.away_team_id
      end
    end
    teams
  end

  def find_bust_eligible_teams(season)
    season = season.to_i
    find_post_season_teams(season) & find_regular_season_teams(season)
  end

  def win_percentage(season, team_id, type)
    season = season.to_i
    games_in_post_season = Game.all.select do |game_id, game_data|
        game_data.season == season && game_data.type == type
    end
    team_games = games_in_post_season.select do |game_id, game_data|
      if find_bust_eligible_teams(season).include?(team_id)
        game_data.home_team_id == team_id || game_data.away_team_id == team_id
      end
    end
    wins = 0
    team_games.each_value do |game_data|
      if team_id == game_data.home_team_id
        if game_data.home_goals > game_data.away_goals
          wins += 1
        end
      end
      if team_id == game_data.away_team_id
        if game_data.away_goals > game_data.home_goals
          wins += 1
        end
      end
    end
      percentage = wins.to_f/team_games.count
      percentage.round(3)
  end

  def bust_differential(season)
    season = season.to_i
    teams = {}
    find_bust_eligible_teams(season).each do |team_id|
      teams[team_id] = win_percentage(season, team_id, "Regular Season") - win_percentage(season, team_id, "Postseason")
    end
    teams
    require "pry"; binding.pry
    end

  def biggest_bust(season)
    season = season.to_i
    biggest_bust = bust_differential(season).min_by{|team, win_percentage| win_percentage}
    end
  end





    #Iterate over each team. Include the team if they played at least one regular season
    #and one post season game.
