class StatTracker
  def initialize()
  end

  def self.from_csv(locations)
    StatTracker.create_items(locations[:games], Game)
    StatTracker.create_items(locations[:game_teams], GameTeam)
    StatTracker.create_items(locations[:teams], Team)
    StatTracker.new()
  end

  def self.create_items(file, item_class)
    csv_options = {
                    headers: true,
                    header_converters: :symbol,
                    converters: :all
                  }
      CSV.foreach(file, csv_options) { |row| item_class.add(item_class.new(row.to_hash)) }
  end

  def regular_season_win_percentage(season, team_id)
  game_in_season = Game.all.select do |game_id, game_data|
      game_data.season == season && game_data.type == "Regular Season"
    end
  games = game_in_season.select do |game_id, game_data|
      game_data.home_team_id == team_id || game_data.away_team_id == team_id
    end
    wins = 0
  games.each_value do |game_data|
    if team_id == game_data.home_team_id
      if game_data.home_goals > game_data.away_goals
        wins += 1
      end
    end
    if team_id == game_data.away_team_id
      if game_data.away_goals > game_data.home_goals
        wins += 1
      end
    end
  end
    percentage = wins.to_f/games.count
    percentage.round(3)
  end

  def post_season_win_percentage(season, team_id)
  game_in_season = Game.all.select do |game_id, game_data|
      game_data.season == season && game_data.type == "Postseason"
    end
  games = game_in_season.select do |game_id, game_data|
      game_data.home_team_id == team_id || game_data.away_team_id == team_id
    end
    wins = 0
  games.each_value do |game_data|
    if team_id == game_data.home_team_id
      if game_data.home_goals > game_data.away_goals
        wins += 1
      end
    end
    if team_id == game_data.away_team_id
      if game_data.away_goals > game_data.home_goals
        wins += 1
      end
    end
  end
    percentage = wins.to_f/games.count
    percentage.round(3)
  end

  def season_games(season)
    season_games = Game.all.select do |game_id, game_data|
      game_data.season == season
    end
  end

  def biggest_bust(season)
    rs_win_percentage_by_team = {}
    season_games(season).each_value do |game_data|
      if rs_win_percentage_by_team[game_data.home_team_id] == nil
        rs_win_percentage_by_team[game_data.home_team_id] = regular_season_win_percentage(season, game_data.home_team_id)
      end
    end
    season_games(season).each_value do |game_data|
      if rs_win_percentage_by_team[game_data.away_team_id] == nil
        rs_win_percentage_by_team[game_data.away_team_id] = regular_season_win_percentage(season, game_data.away_team_id)
      end
    end

    ps_win_percentage_by_team = {}
    season_games(season).each_value do |game_data|
      if ps_win_percentage_by_team[game_data.home_team_id] == nil
        ps_win_percentage_by_team[game_data.home_team_id] = post_season_win_percentage(season, game_data.home_team_id)
      end
    end
    season_games(season).each_value do |game_data|
      if ps_win_percentage_by_team[game_data.away_team_id] == nil
        ps_win_percentage_by_team[game_data.away_team_id] = post_season_win_percentage(season, game_data.away_team_id)
      end
    end
    bust_diff = {}
    ps_win_percentage_by_team.each_key do |team|
       bust_diff[team] = (rs_win_percentage_by_team[team] - ps_win_percentage_by_team[team])
    end

    bust_diff.delete_if { |team, win_percentage| win_percentage.nan? }

    biggest_bust_team = [bust_diff.min_by{|team, win_percentage| win_percentage}][0][0]
  end
end

    #Find name of team with corresponding team ID (will need to use Team Data!!!)
    #
