require_relative 'gatherable'

module Calculateable
  include Gatherable

  def team_average_goals(goals_hash)
    average_goals = {}
    goals_hash.each do |team, tot_score|
      average_goals[team] = (tot_score.to_f / games_by_team[team]).round(2)
    end

    average_goals
  end

  def team_win_percentage(wins_hash)
    average_wins = {}
    wins_hash.each do |team, tot_wins|
      average_wins[team] = (tot_wins.to_f / games_by_team[team])
    end

    average_wins
  end

  def season_win_percentage(wins_hash, season_id)
    average_wins = {}
    wins_hash.each do |coach, tot_wins|
      average_wins[coach] = (tot_wins.to_f / games_by_season(season_id)[coach])
    end
    average_wins
  end

  def team_postseason_win_percent(wins_hash)
    average_wins = {}
    wins_hash.each do |team, tot_wins|
      average_wins[team] = (tot_wins.to_f / postseason_games_by_team[team])
    end
    average_wins
  end

  def team_home_average_wins(wins_hash)
    average_wins = {}
    wins_hash.each do |team, tot_wins|
      average_wins[team] = (tot_wins.to_f / home_games_by_team[team])
    end
    average_wins
  end

  def team_away_average_wins(wins_hash)
    average_wins = {}
    wins_hash.each do |team, tot_wins|
      average_wins[team] = (tot_wins.to_f / away_games_by_team[team])
    end
    average_wins
  end

  def team_total_seasons(team_id)
    @team_season_collection.collection[team_id].size
  end

  def team_season_keys(team_id)
    { team_id => @team_season_collection.collection[team_id].keys }
  end
end
