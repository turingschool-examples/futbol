require_relative './helper'

module SeasonStats
  include Helper

  def season_rspec_test
    true
  end

  def winningest_coach(input_season)
    season_game_teams = game_team_select_season(input_season)
    wins_by_coach = Hash.new(0)
    games_by_coach = Hash.new(0)
    season_game_teams.each do |game|
      coach = game.head_coach
      result = game.result
      if result == "WIN"
        wins_by_coach[coach] += 1
      end
      games_by_coach[coach] += 1
    end
    winning_percentages = {}
    wins_by_coach.each do |coach, wins|
      games = games_by_coach[coach]
      winning_percentages[coach] = wins.to_f / games.to_f
    end
    winning_percentages.max_by { |coach, wp| wp }[0]
  end

  def worst_coach(input_season)
    season_game_teams = game_team_select_season(input_season)
    losses_by_coach = Hash.new(0)
    ties_by_coach = Hash.new(0)
    games_by_coach = Hash.new(0)
    season_game_teams.each do |game|
      coach = game.head_coach
      result = game.result
      case result
      when "WIN"
        games_by_coach[coach] += 1
      when "LOSS"
        losses_by_coach[coach] += 1
        games_by_coach[coach] += 1
      when "TIE"
        ties_by_coach[coach] += 1
        games_by_coach[coach] += 1
      end
    end
    win_percentages = {}
    games_by_coach.each do |coach, games|
      wins = games - losses_by_coach[coach] - ties_by_coach[coach]
      win_percentages[coach] = wins.to_f / games.to_f
    end
    win_percentages.min_by { |coach, wp| wp }[0]
  end
  
  
  def most_accurate_team(input_season)
    season_game_teams = game_team_select_season(input_season)
    teams_grouped = season_game_teams.group_by(&:team_name)
    teams_ave_accuracy = {}
    teams_grouped.each do |team, values|
      teams_ave_accuracy[team] = average_accuracy(values)
    end
    highest_accuracy = teams_ave_accuracy.max_by{|_, value| value}
    highest_accuracy[0]
  end

  def least_accurate_team(input_season)
    season_game_teams = game_team_select_season(input_season)
    teams_grouped = season_game_teams.group_by(&:team_name)
    teams_ave_accuracy = {}
    teams_grouped.each do |team, values|
      teams_ave_accuracy[team] = average_accuracy(values)
    end
    lowest_accuracy = teams_ave_accuracy.min_by{|_, value| value}
    lowest_accuracy[0]
  end

  def most_tackles(input_season)
    season_game_teams = game_team_select_season(input_season)
    teams_info = season_game_teams.group_by(&:team_name)
    team_tackles = {}
    teams_info.map do |team, games|  
      team_tackles[team] = games.sum(&:tackles)
    end
    tackle_masters = team_tackles.max_by{|_, value| value}
    tackle_masters[0]
  end
  
  def fewest_tackles(input_season)
    season_game_teams = game_team_select_season(input_season)
    teams_info = season_game_teams.group_by(&:team_name)
    team_tackles = {}
    teams_info.map do |team, games|  
      team_tackles[team] = games.sum(&:tackles)
    end
    tackle_noobs = team_tackles.min_by{|_, value| value}
    tackle_noobs[0]
  end
end