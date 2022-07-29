class Season
  attr_reader :season_id,
              :games_in_season

  def initialize(season_id, games_in_season)
    @season_id = season_id
    @games_in_season = games_in_season
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

  def shots_by_team_per_season_avg #helper method for most and least accurate
    shots_by_teams = Hash.new(1)

    @games_in_season.each do |game|
      shots_by_teams[game.teams_game_stats[:home_team][:team_name]] *= game.teams_game_stats[:home_team][:shots].to_f / game.teams_game_stats[:home_team][:goals]

      shots_by_teams[game.teams_game_stats[:away_team][:team_name]] *= game.teams_game_stats[:away_team][:shots].to_f / game.teams_game_stats[:away_team][:goals]
    end
    shots_by_teams
  end

  def most_accurate_team
    shots_by_team_per_season_avg.max.first
  end

  def least_accurate_team
    shots_by_team_per_season_avg.min.first
  end
end
