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

  def season_coach_win_percent(wins_hash, season_id)
    average_wins = {}
    wins_hash.each do |coach, tot_wins|
      if season_games_by_coach(season_id)[coach] == 0
        average_wins[coach] = nil
      else
        average_wins[coach] = (tot_wins.to_f / season_games_by_coach(season_id)[coach])
      end
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

  def win_or_loss(team_id, team_season)
    team_season.reduce(Hash.new(0)) do |hash, game|
      if game.home_team_id == team_id && game.home_goals > game.away_goals
        hash[team_id][:wins] += 1
      elsif game.away_team_id == team_id && game.away_goals > game.home_goals
        hash[team_id][:wins] += 1
      elsif game.home_goals == game.away_goals
        hash[team_id][:draw] += 1
      else
        hash[team_id][:losses] += 1
      end
      hash
    end
  end

  def combine_game_data
    @game_teams.collection.each do |game|
      team_game = @games.collection[game[1].game_id]
      if game[1].team_id == team_game.home_team_id
        team_game.home_coach = game[1].head_coach
        team_game.home_shots = game[1].shots
        team_game.home_tackles = game[1].tackles
      elsif game[1].team_id == team_game.away_team_id
        team_game.away_coach = game[1].head_coach
        team_game.away_shots = game[1].shots
        team_game.away_tackles = game[1].tackles
      end
    end
  end
end
