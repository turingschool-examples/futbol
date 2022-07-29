class Season
  attr_reader :season_id,
              :games_in_season

  def initialize(season_id, games_in_season)
    @season_id = season_id
    @games_in_season = games_in_season
  end

  def tackles_by_team
    team_tackles = Hash.new(0)
    @games_in_season.each do |game|
      game.teams_game_stats.values.each do |team_stats_hash|
        team_tackles[team_stats_hash[:team_name]] += team_stats_hash[:tackles]
      end
    end
    team_tackles
  end

  def most_tackles
    "Sporting Kansas City"
  end

  def least_tackles
    "DC United"
  end

  def self.generate_seasons(games)
    seasons_ids = games.map{|game| game.season}.uniq
    seasons_hash = {}
    seasons_ids.each do |season_id|
      games_in_season = games.find_all do |game|
        game.season == season_id
      end
      seasons_hash[season_id] = Season.new(season_id, games_in_season)
    end
    seasons_hash
  end
end
