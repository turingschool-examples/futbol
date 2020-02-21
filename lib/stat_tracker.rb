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

  def win_percentage(season, team_id, type)
  game_in_season = Game.all.select do |game_id, game_data|
      game_data.season == season && game_data.type == type
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


  def biggest_bust(season)
    rs_win_percentage_by_team = {}
    season_games = Game.all.select do |game_id, game_data|
        game_data.season == season
    end
    season_games.each_value do |game_data|
      if rs_win_percentage_by_team[game_data.home_team_id] == nil
        rs_win_percentage_by_team[game_data.home_team_id] = win_percentage(season, game_data.home_team_id, "Regular Season")
      end
    end
    season_games.each_value do |game_data|
      if rs_win_percentage_by_team[game_data.away_team_id] == nil
        rs_win_percentage_by_team[game_data.away_team_id] = win_percentage(season, game_data.away_team_id, "Regular Season")
      end
    end

    ps_win_percentage_by_team = {}
    season_games.each_value do |game_data|
      if ps_win_percentage_by_team[game_data.home_team_id] == nil
        ps_win_percentage_by_team[game_data.home_team_id] = win_percentage(season, game_data.home_team_id, "Postseason")
      end
    end
    season_games.each_value do |game_data|
      if ps_win_percentage_by_team[game_data.away_team_id] == nil
        ps_win_percentage_by_team[game_data.away_team_id] = win_percentage(season, game_data.away_team_id, "Postseason")
      end
    end
    require "pry"; binding.pry
  end


    #Calculate team with biggest decrease between regular and post season win percentage
    #Find name of team with corresponding team ID (will need to use Team Data!!!)
    #
end
