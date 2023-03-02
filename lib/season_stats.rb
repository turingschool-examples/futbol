require_relative './helper'

module SeasonStats
  include Helper

  def season_rspec_test
    true
  end

  def winningest_coach(input_season)
    season_game_teams = game_team_select_season(input_season)
    wins_by_coach = Hash.new(0)
    season_game_teams.each do |game|
      coach = game.head_coach
      result = game.result
      if result == "WIN"
        wins_by_coach[coach] += 1
      end
    end
    wins_by_coach.max_by { |coach, wins| wins }[0]
  end

  def worst_coach(input_season)
    season_game_teams = game_team_select_season(input_season)
    losses_by_coach = Hash.new(0)
    season_game_teams.each do |game|
      coach = game.head_coach
      result = game.result
      if result == "LOSS"
        losses_by_coach[coach] += 1
      end
    end
    losses_by_coach.max_by { |coach, losses| losses }[0]
  end

  def most_accurate_team(input_season)
    season_game_teams = game_team_select_season(input_season)
    teams_grouped = season_game_teams.group_by(&:team_id)
    teams_ave_accuracy = {}
    teams_grouped.each do |team, values|
      teams_ave_accuracy[team] = average_accuracy(values)
    end
    highest_accuracy = teams_ave_accuracy.max_by{|_, value| value}
    convert_to_team_name(highest_accuracy[0])
  end

  def least_accurate_team(input_season)
    season_game_teams = game_team_select_season(input_season)
    teams_grouped = season_game_teams.group_by(&:team_id)
    teams_ave_accuracy = {}
    teams_grouped.each do |team, values|
      teams_ave_accuracy[team] = average_accuracy(values)
    end
    lowest_accuracy = teams_ave_accuracy.min_by{|_, value| value}
    convert_to_team_name(lowest_accuracy[0])
  end

  def most_tackles

  end

  def fewest_tackles

  end
end