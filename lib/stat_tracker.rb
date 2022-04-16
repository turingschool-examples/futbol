require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'


class StatTracker

attr_reader :games, :team, :game_teams

  def initialize(locations)
    @games = read_and_create_games(locations[:games])
    @teams = read_and_create_teams(locations[:teams])
    @game_teams = read_and_create_game_teams(locations[:game_teams])
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end


  def read_and_create_games(games_csv)
    games_array = []
    CSV.foreach(games_csv, headers: true, header_converters: :symbol) do |row|
      games_array << Game.new(row)
    end
    games_array
  end

  def read_and_create_teams(teams_csv)
    teams_array = []
    CSV.foreach(teams_csv, headers: true, header_converters: :symbol) do |row|
      teams_array << Team.new(row)
    end
    teams_array
  end

  def read_and_create_game_teams(game_teams_csv)
    game_teams_array = []
    CSV.foreach(game_teams_csv, headers: true, header_converters: :symbol) do |row|
      game_teams_array << GameTeam.new(row)
    end
    game_teams_array
  end

  ## GAME STATISTICS

  def highest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.min
  end

  ## TEAM STATISTICS

  def team_info(id)
    info = Hash.new
    @teams.each do |team|
      if team.team_id == id
        info["team_id"] = team.team_id
        info["franchise_id"] = team.franchise_id
        info["team_name"] = team.team_name
        info["abbreviation"] = team.abbr
        info["link"] = team.link
      end
    end
    info
  end

  def most_goals_scored(id)
    game_team_arr = []
    @game_teams.each do |game_team|
      if game_team.team_id == id
        game_team_arr << game_team.goals.to_i
      end
    end
    game_team_arr.max
  end

  def fewest_goals_scored(id)
    game_team_arr = []
    @game_teams.each do |game_team|
      if game_team.team_id == id
        game_team_arr << game_team.goals.to_i
      end
    end
    game_team_arr.min
  end

  def best_season(id)
    grouped_by_season = @games.group_by { |game| game.season[0..].to_s}
    win_percentage_by_season = Hash.new
    grouped_by_season.each do |season, games|
      wins = 0.0
      losses = 0.0
      ties = 0.0
      games.each do |game|
        if (game.home_team_id || game.away_team_id) == id && game.home_goals == game.away_goals
          ties += 1.0
        elsif game.home_team_id == id && game.home_goals > game.away_goals
          wins += 1.0
        elsif game.away_team_id == id && game.away_goals > game.home_goals
          wins += 1.0
        elsif game.home_team_id == id && game.home_goals < game.away_goals
          losses += 1.0
        elsif game.away_team_id == id && game.away_goals < game.home_goals
          losses += 1.0
        else
        end
      end
      win_percentage_by_season[season] = ((wins * 1.0) + (losses * 0.0) + (ties * 0.5)) / (wins + losses + ties)
    end
    win_percentage_by_season.each{|k, v| win_percentage_by_season.delete(k) if !win_percentage_by_season[k].is_a?(Float)}
    win_percentage_by_season.sort_by{|k, v| v}.last[0]
  end

  def worst_season(id)
    grouped_by_season = @games.group_by { |game| game.season[0..].to_s}
    win_percentage_by_season = Hash.new
    grouped_by_season.each do |season, games|
      wins = 0.0
      losses = 0.0
      ties = 0.0
      games.each do |game|
        if (game.home_team_id || game.away_team_id) == id && game.home_goals == game.away_goals
          ties += 1.0
        elsif game.home_team_id == id && game.home_goals > game.away_goals
          wins += 1.0
        elsif game.away_team_id == id && game.away_goals > game.home_goals
          wins += 1.0
        elsif game.home_team_id == id && game.home_goals < game.away_goals
          losses += 1.0
        elsif game.away_team_id == id && game.away_goals < game.home_goals
          losses += 1.0
        else
        end
      end
      win_percentage_by_season[season] = ((wins * 1.0) + (losses * 0.0) + (ties * 0.5)) / (wins + losses + ties)
    end
    win_percentage_by_season.each{|k, v| win_percentage_by_season.delete(k) if !win_percentage_by_season[k].is_a?(Float)}
    win_percentage_by_season.sort_by{|k, v| v}.first[0]
  end

  def average_win_percentage(id)
    wins = 0.0
    total_games_played = @games.find_all{|game| (game.home_team_id || game.away_team_id) == id}
    @games.each do |game|
      if game.home_team_id == id && game.home_goals > game.away_goals
        wins += 1.0
      elsif game.away_team_id == id && game.away_goals > game.home_goals
        wins += 1.0
      else
      end
    end
    return ((wins * 1.0) / (total_games_played.count)).round(2) / 2
  end

  def favorite_opponent(id)
    opponents = Hash.new
    @teams.each do |team|
      if team.team_id != id
        opponents[team.team_name] = win_percentage_vs(team.team_id, id)
      end
    end
    opponents.each{|k, v| opponents.delete(k) if !opponents[k].is_a?(Float)}
    opponents.sort_by{|k, v| v}.first[0]
  end

  def rival(id)
    opponents = Hash.new
    @teams.each do |team|
      if team.team_id != id
        opponents[team.team_name] = win_percentage_vs(team.team_id, id)
      end
    end
    opponents.each{|k, v| opponents.delete(k) if !opponents[k].is_a?(Float)}
    opponents.sort_by{|k, v| v}.last[0]
  end

  def win_percentage_vs(id1, id2)
    wins = 0.0
    total_games_played = @games.find_all{|game| (game.home_team_id || game.away_team_id) == id1 && (game.home_team_id || game.away_team_id) == id2}
    @games.each do |game|
      if game.home_team_id == id1 && game.away_team_id == id2 && game.home_goals > game.away_goals
        wins += 1.0
      elsif game.away_team_id == id1 && game.home_team_id == id2 && game.away_goals > game.home_goals
        wins += 1.0
      else
      end
    end
    return (wins / total_games_played.count).round(2) / 2
  end

end
