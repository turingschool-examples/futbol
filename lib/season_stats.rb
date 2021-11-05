class SeasonStats
  attr_reader :game_data,
              :team_data,
              :games_teams

  def initialize(current_stat_tracker)
    @game_data = current_stat_tracker.games
    @team_data = current_stat_tracker.teams
    @games_teams = current_stat_tracker.games_teams
  end

  def all_season
    seasons = []
    # This each can be refactors
    @game_data.each do |row|
      seasons << row['season']
    end
    seasons.uniq
  end

  def array_of_games(season)
    games_array = []
    @game_data.each do |row|
      if row["season"] == season
        games_array << row["game_id"]
      end
    end
    games_array
  end

  def coaches_in_season(season)
    coaches = []
    @games_teams.each do |row|
      if array_of_games(season).include?(row['game_id'])
        coaches << row["head_coach"]
      end
    end
    coaches.uniq
  end

  def coach_win_percentage(season, coach)
    result_array = []
    @games_teams.each do |row|
      if array_of_games(season).include?(row['game_id']) && row["head_coach"] == coach
          result_array << row["result"]
      end
    end
    win_percentage(result_array)
  end

  def winningest_coach(season)
    hash = Hash.new
    coaches = coaches_in_season(season)
    coaches.each do |coach|
      hash[coach] = coach_win_percentage(season, coach)
    end
    hash.key(hash.values.max)
  end

  def worst_coach(season)
    hash = Hash.new
    coaches = coaches_in_season(season)
    coaches.each do |coach|
      hash[coach] = coach_win_percentage(season, coach)
    end
    hash.key(hash.values.min)
  end

  def win_percentage(results)
    wins = 0
    tie = 0
    loss = 0
    results.each do |result|
      if result == "WIN"
        wins += 1
      elsif result == "TIE"
        tie += 1
      else result == "LOSS"
        loss += 1
      end
    end
    (wins.to_f / results.length).round(2)
  end

  def teams_in_season(season)
    team_ids = []
    @games_teams.each do |row|
      if array_of_games(season).include?(row['game_id'])
        team_ids << row["team_id"]
      end
    end
    team_ids.uniq
  end
end
