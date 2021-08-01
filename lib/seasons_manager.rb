require_relative 'percentageable'

class SeasonsManager
  include Percentageable

  def coach_win_pct(season)
    coach_wins(season).each.reduce({}) do |acc, (coach, results)|
      acc[coach] = hash_avg(results)
      acc
    end
  end

  def coach_wins(season)
    @game_teams.reduce({}) do |acc, game|
      if game.game_id[0..3] == season[0..3]
        acc[game.coach] ||= {wins: 0, total: 0}
        process_game(acc[game.coach], game)
      end
      acc
    end
  end

  def accuracy_data(season)
    @game_teams.reduce({}) do |acc, game|
      if game.game_id[0..3] == season[0..3]
        acc[game.team_id] ||= {goals: 0, shots: 0}
        acc[game.team_id][:goals] += game.goals
        acc[game.team_id][:shots] += game.shots
      end
      acc
    end
  end

  def team_tackles(season)
    @game_teams.reduce({}) do |acc, game|
      if game.game_id[0..3] == season[0..3]
        acc[game.team_id] ||= 0
        acc[game.team_id] += game.tackles
      end
      acc
    end
  end

  def seasons_win_count(team_id)
    @game_teams.reduce({}) do |acc, game|
      if game.team_id == team_id
        acc[game.season] ||= {wins: 0, total: 0}
        process_game(acc[game.season], game)
      end
      acc
    end
  end

  def get_season_game_count
    @games.reduce({}) do |acc, game|
      acc[game.season] ||= 0
      acc[game.season] += 1
      acc
    end
  end

  def get_goals_per_season
    @games.reduce({}) do |acc, game|
      acc[game.season] ||= 0
      acc[game.season] += game.total_goals
      acc
    end
  end

  def get_games_per_season(season)
    @games.count do |game|
      game.season == season
    end
  end
end
