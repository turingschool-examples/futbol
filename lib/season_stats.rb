class SeasonStatistics
  attr_reader :game_data,
              :game_teams_data,
              :teams_data

  def initialize(array_game_data, array_game_teams_data, array_teams_data)
    @game_data = array_game_data
    @game_teams_data = array_game_teams_data
    @teams_data = array_teams_data
  end

  def hash_of_seasons(season) #refactor: move to module
    @game_teams_data.find_all do |game_team|
      game_team[:game_id].to_s.split('')[0..3].join.to_i == season.split('')[0..3].join.to_i
    end
  end

  def group_by_coach(season)
    hash_of_seasons(season).group_by do |game|
      game[:head_coach]
    end
  end

  def coach_wins(season)
    hash = {}
    group_by_coach(season).map do |coach, games|
      total_wins = 0
      total_games = 0
      games.each do |game|
        total_wins += 1 if game[:result] == 'WIN'
        total_games += 1
      end
      hash[coach] = (total_wins.to_f / total_games).round(3) * 100
    end
    hash
  end

  def winningest_coach(season)
   best_coach =  coach_wins(season).max_by do |coach, win|
      win
    end
    best_coach[0]
  end
end
