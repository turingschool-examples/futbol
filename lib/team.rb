class Team
  def initialize(game_team_data, game_data, team_data)
    @game_team_data = game_team_data
    @game_data = game_data
    @team_data = team_data
  end

  def game_wins_per_season(team_id)
    season_wins = Hash.new(0)
    @game_data.each do |row|
      if row[:away_team_id] == team_id || row[:home_team_id] == team_id
        season_id = row[:season]
        game_season_id = row[:game_id]
        @game_team_data.each do |game|
          if game[:team_id] == team_id && game[:result] == "WIN" && game[:game_id] == game_season_id
          season_wins[season_id] += 1
          end
        end
      end
    end
    season_wins
  end

  def games_per_season(team_id)
    season_games = Hash.new(0)
    @game_data.each do |row|
      if row[:away_team_id] == team_id || row[:home_team_id] == team_id
        season_id = row[:season]
        game_season_id = row[:game_id]
        @game_team_data.each do |game|
          if game[:team_id] == team_id && game[:game_id] == game_season_id
          season_games[season_id] += 1
          end
        end
      end
    end
    season_games
  end

  def best_season(team_id)
    season_win_percentage = Hash.new(0)
    games_per_season(team_id).each do |season, games|
      wins = game_wins_per_season(team_id)[season]
      percentage = (wins / games.to_f) * 100
      season_win_percentage[season] = percentage
    end
    best_season = season_win_percentage.max_by { |season, percent| percent }
    best_season.first
  end
end