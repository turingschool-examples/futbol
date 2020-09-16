require_relative 'team_stat_helper'

class TeamStatistics < TeamStatHelper

  def team_info(team_id)
    team_info = {}
    team = @team.fetch(team_id)
    team.instance_variables.each do |instance_variable|
      team_info[instance_variable.to_s.delete(":@")] = team.instance_variable_get(instance_variable)
    end
    team_info.delete("stadium")
    team_info
  end

  def best_season(team_id)
    season_games = collect_seasons(team_id)
    season_wins_hash = collect_wins_per_season(team_id)
    winning_percentage_per_season = {}
    season_wins_hash.each do |season, wins|
      winning_percentage_per_season[season] = (wins.to_f/season_games.length).round(2)
    end
    winning_percentage_per_season.key(winning_percentage_per_season.values.max)
  end

  def worst_season(team_id)
    season_games = collect_seasons(team_id)
    season_losses_hash = collect_losses_per_season(team_id)
    losing_percentage_per_season = {}
    season_losses_hash.each do |season, losses|
      losing_percentage_per_season[season] = (losses.to_f/season_games[season].length).round(2)
    end
    losing_percentage_per_season.key(losing_percentage_per_season.values.max)
  end

  def average_win_percentage(team_id)
    total_average_win_percentage = 0
    total_games = 0
    collect_seasons(team_id).each do |season, games|
      total_games += games.length
    end
    collect_wins_per_season(team_id).each do |season, wins|
      total_average_win_percentage += wins
    end
    (total_average_win_percentage.to_f/total_games).round(2)
  end

  def most_goals_scored(team_id)
    most_goals = 0
    collect_seasons(team_id).each do |season, games|
      games.each do |game|
        if team_id.to_i == game.away_team_id
          most_goals = game.away_goals if game.away_goals > most_goals
        elsif team_id.to_i == game.home_team_id
          most_goals = game.home_goals if game.home_goals > most_goals
        end
      end
    end
    most_goals
  end

  def fewest_goals_scored(team_id)
    fewest_goals = 5
    collect_seasons(team_id).each do |season, games|
      games.each do |game|
        if team_id.to_i == game.away_team_id
          fewest_goals = game.away_goals if game.away_goals < fewest_goals
        elsif team_id.to_i == game.home_team_id
          fewest_goals = game.home_goals if game.home_goals < fewest_goals
        end
      end
    end
    fewest_goals
  end

  def favorite_opponent(team_id)
    opponents  = {}
    game_count = {}
    games_for_team_id(team_id).each do |game|
      if team_id.to_i != game.team_id && opponents[game.team_id].nil?
        game_count[game.team_id] = 1
        game.result == "WIN" ? opponents[game.team_id] = 1 : opponents[game.team_id] = 0
      elsif team_id.to_i != game.team_id
        opponents[game.team_id] += 1 if game.result == "WIN"
        game_count[game.team_id] += 1
      end
    end
    min_percentage_favorite_team_team_name(win_percentages_by_team(opponents, game_count))
  end

  def rival(team_id)
    opponents  = {}
    game_count = {}
    games_for_team_id(team_id).each do |game|
      if team_id.to_i != game.team_id && opponents[game.team_id].nil?
        game_count[game.team_id] = 1
        game.result == "WIN" ? opponents[game.team_id] = 1 : opponents[game.team_id] = 0
      elsif team_id.to_i != game.team_id
        opponents[game.team_id] += 1 if game.result == "WIN"
        game_count[game.team_id] += 1
      end
    end
    max_percentage_favorite_team_team_name(win_percentages_by_team(opponents, game_count))
  end

end
