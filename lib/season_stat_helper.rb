class SeasonStatHelper

  def initialize(game, team, game_team)
    @game ||= game
    @team ||= team
    @game_team ||= game_team
  end

  def find_all_seasons
    seasons = []
    @game.each do |game_id, game|
      if !seasons.include?(game.season)
        seasons << game.season
      end
    end
    seasons
  end

  def coaches_per_season(seasons)
    coaches_per_season = {}
    seasons.each do |season|
      @game_team.each do |game|
        if @game[(game.game_id).to_s].season == season
          if coaches_per_season[season].nil?
            coaches_per_season[season] = {game.head_coach => [game.result]}
          elsif coaches_per_season[season][game.head_coach]
            coaches_per_season[season][game.head_coach] << game.result
          else
            coaches_per_season[season][game.head_coach] = [game.result]
          end
        end
      end
    end
    coaches_per_season
  end

  def collects_season_with_games
   season_games = {}
   @game.each do |game_id, game|
      if season_games[game.season].nil?
       season_games[game.season] = [game]
      elsif
       season_games[game.season] << game
      end
    end
    season_games
  end

  def collect_shots_per_season(season)
    shots_per_team = {}
    collects_season_with_games[season].each do |game|
      games = @game_team.find_all do |game_info|
        game.game_id == game_info.game_id
      end
      games.each do |game|
        if shots_per_team[@team[game.team_id.to_s].team_name].nil?
          shots_per_team[@team[game.team_id.to_s].team_name] = game.shots
        else
          shots_per_team[@team[game.team_id.to_s].team_name] += game.shots
        end
      end
    end
    shots_per_team
  end

  def collect_goals_per_team(season)
    goals_per_team  = {}
    collects_season_with_games[season].each do |game|
      if goals_per_team[@team[game.away_team_id.to_s].team_name].nil? && season == game.season
        goals_per_team[@team[game.away_team_id.to_s].team_name] = game.away_goals
      elsif goals_per_team[@team[game.home_team_id.to_s].team_name].nil? && season == game.season
        goals_per_team[@team[game.home_team_id.to_s].team_name] = game.home_goals
      elsif season == game.season
        goals_per_team[@team[game.away_team_id.to_s].team_name] += game.away_goals
        goals_per_team[@team[game.home_team_id.to_s].team_name] += game.home_goals
      end
    end
    goals_per_team
  end

  def team_tackles_by_season(games)
    tackles = {}
    games.each do |game|
      game_teams_array = @game_team.find_all do |game_info|
        game.game_id == game_info.game_id
      end
      game_teams_array.each do |team|
        if tackles[team.team_id].nil?
          tackles[team.team_id] = team.tackles
        else
          tackles[team.team_id] += team.tackles
        end
      end
    end
    tackles
  end
end
