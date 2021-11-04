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
    seasons_uniq = []
    # This each can be refactors
    @game_data.each do |row|
      seasons_uniq << row['season']
    end
    seasons_uniq.uniq
  end

  # example hash
  # def hash_ex
  #   x = {}
  #   all_season.each do |season|
  #   x[season] = helpermethod(season)
  # end

  def array_of_games(season)
    games_array = []
    @game_data.each do |row|
      if row["season"] == season
        games_array << row["game_id"]
      end
    end
    games_array
  end

  # def all_season
  #   seasons_uniq = []
  #   @game_data.each do |row|
  #     seasons_uniq << row['season']
  #   end
  #   seasons_uniq.uniq
  # end

  def coaches_in_season(season)
    coaches_uniq = []
    @games_teams.each do |row|
      array_of_games(season).each do |game|
        if row["game_id"] == game
          coaches_uniq << row["head_coach"]
        end
      end
    end
    coaches_uniq.uniq
  end

  # def games_played_by_coach(season)
  #   hash = Hash.new
  #   @games_teams.each do |row|
  #       coaches_in_season(season).each do |coach|
  #     end
  #   end
  # end

  def coach_win_percentage(season, coach)
    array = []
    @games_teams.each do |row|
      if array_of_games(season).include?(row['game_id']) && row["head_coach"] == coach
          array << row["result"]
      end
    end

    win_percentage(array)
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

end
