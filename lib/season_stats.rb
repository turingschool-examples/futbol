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
end
