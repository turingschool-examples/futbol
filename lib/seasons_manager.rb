require_relative 'percentageable'

class SeasonsManager
  include Percentageable

  def coach_win_pct(season)
    coach_wins(season).each.each_with_object({}) do |(coach, results), acc|
      acc[coach] = hash_avg(results)
    end
  end

  def coach_wins(season)
    @game_teams.each_with_object({}) do |game, acc|
      if game.game_id[0..3] == season[0..3]
        acc[game.coach] ||= { wins: 0, total: 0 }
        process_game(acc[game.coach], game)
      end
    end
  end

  def accuracy_data(season)
    @game_teams.each_with_object({}) do |game, acc|
      next unless game.game_id[0..3] == season[0..3]

      acc[game.team_id] ||= { goals: 0, shots: 0 }
      acc[game.team_id][:goals] += game.goals
      acc[game.team_id][:shots] += game.shots
    end
  end

  def team_tackles(season)
    @game_teams.each_with_object({}) do |game, acc|
      if game.game_id[0..3] == season[0..3]
        acc[game.team_id] ||= 0
        acc[game.team_id] += game.tackles
      end
    end
  end

  def seasons_win_count(team_id)
    @game_teams.each_with_object({}) do |game, acc|
      if game.team_id == team_id
        acc[game.season] ||= { wins: 0, total: 0 }
        process_game(acc[game.season], game)
      end
    end
  end

  def get_season_game_count
    @games.each_with_object({}) do |game, acc|
      acc[game.season] ||= 0
      acc[game.season] += 1
    end
  end

  def get_goals_per_season
    @games.each_with_object({}) do |game, acc|
      acc[game.season] ||= 0
      acc[game.season] += game.total_goals
    end
  end

  def get_games_per_season(season)
    @games.count do |game|
      game.season == season
    end
  end
end
