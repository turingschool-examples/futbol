require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'


class StatTracker

  attr_reader :games,
              :team,
              :game_teams

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

###### GAME STATISTICS - Deannah

  def highest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals + game.home_goals}.min
  end

  def percentage_home_wins
    home_wins = []
    @games.each do |game|
      if game.home_goals > game.away_goals
        home_wins << game
      end
    end
    (home_wins.count / @games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = []
    @games.each do |game|
      if game.away_goals > game.home_goals
        visitor_wins << game
      end
    end
    (visitor_wins.count / @games.count.to_f).round(2)
  end

  def percentage_ties
    total_ties = []
    @games.each do |game|
      if game.away_goals == game.home_goals
        total_ties << game
      end
    end
    (total_ties.count / @games.count.to_f).round(2)
  end

  def count_of_games_by_season
    @games.group_by { |total| total.season }.transform_values do |values| values.count
    end
  end

  def count_of_goals_by_season
    goals_by_season = {}
    @games.each do |game|
      if goals_by_season[game.season].nil?
        goals_by_season[game.season] = game.home_goals + game.away_goals
      else
        goals_by_season[game.season] += game.home_goals + game.away_goals
      end
    end
    goals_by_season
  end

  def average_goals_per_game
    total_goals = @games.map {|game| game.away_goals + game.home_goals}
    average = total_goals.sum.to_f / @games.count
    average.round(2)
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
####### SEASON STATISTICS : All methods return Strings - Team Name || Head Coach

## Find season from games
  def games_in_season(season)
    @game_teams.find_all { |game| game.game_id[0..3] == season[0..3] }
  end

## Find teams from id
  def team_name_from_id(id)
    @teams.find { |team| team.team_id == id }.team_name
  end

## Helper method to check team tackles
  def teams_by_tackles(season)
    teams = Hash.new
    games_in_season(season).each do |game|
      if teams[game.team_id].nil?
        teams[game.team_id] = game.tackles.to_i
      else
        teams[game.team_id] += game.tackles.to_i
      end
    end
    teams.sort_by { |team, number| number }
  end

##  Helper method that checks shot accuracy of all teams by a given season
  def shot_accuracy(season)
    teams = Hash.new
    games_in_season(season).each do |game|
      if teams[game.team_id].nil?
        teams[game.team_id] = { goals: game.goals.to_f, shots: game.shots.to_f }
      else
        teams[game.team_id][:goals] += game.goals.to_f
        teams[game.team_id][:shots] += game.shots.to_f
      end
    end
    teams.map { |team, count| [team,  count[:goals] / count[:shots]] }.sort_by { |team| team[1] }
  end

  def coach_results(result, season)
    coaches = []
    win_loss_hash = games_in_season(season).group_by { |win_loss| win_loss.result[0..].to_s}
    win_loss_hash.each do |k, v|
      if k == result
        v.each do |coach|
          coaches << coach.head_coach
        end
      end
    end
    coach_by_percent = Hash.new
    coach_hash = coaches.group_by { |coach| coach[0..]}.transform_values { |v| v.count}
  end

  def winningest_coach(season)
# Name of the Coach with the best win percentage for the season
    coach_results("WIN", season).to_a.sort_by { |number| number[1] }.last[0]
  end

  def worst_coach(season)
# Name of the Coach with the worst win percentage for the season
    coach_results("LOSS", season).to_a.sort_by { |number| number[1] }.first[0]
  end

  def most_accurate_team(season)
# Name of the Team with the best ratio of shots to goals for the season
    team_name_from_id(shot_accuracy(season).last[0])
  end

  def least_accurate_team(season)
# Name of the Team with the worst ratio of shots to goals for the season
    team_name_from_id(shot_accuracy(season).first[0])
  end

  def most_tackles(season)
# Name of the Team with the most tackles in the season
    team_name_from_id(teams_by_tackles(season).last[0])
  end

  def fewest_tackles(season)
# Name of the Team with the fewest tackles in the season
    team_name_from_id(teams_by_tackles(season).first[0])
  end

########## LEAGUE STATISTICS - Jenn

##count_of_teams
  def count_of_teams
    @teams.count
  end

  def best_offense
    @teams.find { |team| team.team_id == average_score_by_team.sort_by{|k, v| v}.last[0] }.team_name
  end

  def worst_offense
    @teams.find { |team| team.team_id == average_score_by_team.sort_by{|k, v| v}.first[0] }.team_name
  end

  def highest_scoring_visitor
    @teams.find { |team| team.team_id == average_score_by_team("away").sort_by{|k, v| v}.last[0]}.team_name
  end

  def lowest_scoring_visitor
    @teams.find { |team| team.team_id == average_score_by_team("away").sort_by{|k, v| v}.first[0] }.team_name
  end

  def highest_scoring_home_team
    @teams.find { |team| team.team_id == average_score_by_team("home").sort_by{|k, v| v}.last[0] }.team_name
  end

  def lowest_scoring_home_team
    @teams.find { |team| team.team_id == average_score_by_team("home").sort_by{|k, v| v}.first[0] }.team_name
  end

  def average_goals_by_season
    average_goals = {}
    count_of_goals_by_season.each { |season, goals| average_goals[season] = (goals.to_f / count_of_games_by_season[season]).round(2) }
    average_goals
  end

##HELPER METHODS - LEAGUE STATISTICS 
  def games_by_team(home_or_away =nil)
    games_by_team_hash = {}
    @game_teams.each do |game|
      if home_or_away == nil
        if games_by_team_hash[game.team_id].nil?
          games_by_team_hash[game.team_id] = { goals: game.goals, number_of_games: 1 }
        else
          games_by_team_hash[game.team_id][:goals] += game.goals
          games_by_team_hash[game.team_id][:number_of_games] += 1
        end
      else
        if games_by_team_hash[game.team_id].nil? && game.hoa == home_or_away
          games_by_team_hash[game.team_id] = { goals: game.goals, number_of_games: 1 }
        elsif game.hoa == home_or_away
          games_by_team_hash[game.team_id][:goals] += game.goals
          games_by_team_hash[game.team_id][:number_of_games] += 1
        end
      end
    end
    games_by_team_hash
  end

  def average_score_by_team(home_or_away =nil)
    average_hash = {}
    if home_or_away == nil
      games_by_team.each { |key, value| average_hash[key] = value[:goals].to_f / value[:number_of_games] }
    else
      games_by_team(home_or_away).each { |key, value| average_hash[key] = value[:goals].to_f / value[:number_of_games] }
    end
    average_hash
  end

end
