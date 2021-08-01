require_relative 'percentageable'

class SeasonsManager
  include Percentageable

  def coach_win_pct(season, games)
    coach_wins(season, games).each.reduce({}) do |acc, (coach, results)|
      acc[coach] = hash_avg(results)
      acc
    end
  end

  def coach_wins(season, games)
    games.reduce({}) do |acc, game|
      if game.game_id[0..3] == season[0..3]
        acc[game.coach] ||= {wins: 0, total: 0}
        process_game(acc[game.coach], game)
      end
      acc
    end
  end
end
