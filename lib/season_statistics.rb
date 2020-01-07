require_relative 'game_team'
require_relative 'team'

class SeasonStatistics

  def self.all_games_all_seasons
    season_games = {}
    Game.all_games.each do |game|
      if season_games.keys.include?(game.season)
        game_ids = season_games[game.season]
        game_ids << game.game_id
      else
        season_games[game.season] = [game.game_id]
      end
    end
    season_games
  end

  def self.games_per_season(season)
    all_games_all_seasons[season]
  end

  def self.game_teams_per_season(season)
    all_games = games_per_season(season).map do |games|
      GameTeam.all_game_teams.find_all do |game_teams|
        games == game_teams.game_id
      end
    end
    all_games.flatten
  end

  def self.win_percent_by_team_id(season)
    total_team_wins = {}
    total_team_games = {}
    game_teams_per_season(season).each do |game_team|
      if total_team_wins.keys.include?(game_team.team_id) == false
        win_count = 0
        win_count += 1 if game_team.result == "WIN"
        game_count = 0
        game_count += 1
        total_team_wins[game_team.team_id] = win_count
        total_team_games[game_team.team_id] = game_count
      else
        total_team_wins[game_team.team_id] += 1 if game_team.result == "WIN"
        total_team_games[game_team.team_id] += 1
      end
      total_team_games
    end

    win_percent_by_team = {}
    total_team_games.keys.each do |key|
      avg_wins = total_team_wins[key]/total_team_games[key].to_f
      win_percent_by_team[key] = avg_wins
    end

    win_percent_by_team
  end

  def self.winningest_team_by_season(season)
    max_wins_team = win_percent_by_team_id(season).find_all do |team|
      team[0] if team[-1] == win_percent_by_team_id(season).values.max
    end
    max_wins_team.flatten.first
  end

  def self.coach_by_team_id(season)
    team_coaches = {}
    game_teams_per_season(season).each do |game_team|
      team_coaches[game_team.team_id] = game_team.head_coach
    end
    team_coaches
  end

  def self.winningest_coach(season)
    coach_by_team_id(season).find {|team| team[0] == winningest_team_by_season(season)}.last
  end

  def self.worst_team_by_season(season)
    min_wins_team = win_percent_by_team_id(season).find_all do |team|
      team[0] if team[-1] == win_percent_by_team_id(season).values.min
    end
    min_wins_team.flatten.first
  end

  def self.worst_coach(season)
    coach_by_team_id(season).find {|team| team[0] == worst_team_by_season(season)}.last
  end

  def self.post_season_games
    post_season_games = {}
    Game.all_games.each do |game|
      if game.type == "Postseason" && post_season_games.keys.include?(game.season)
        game_ids = post_season_games[game.season]
        game_ids << game.game_id
      elsif game.type == "Postseason" && post_season_games.keys.include?(game.season) == false
        post_season_games[game.season] = [game.game_id]
      end
    end
    post_season_games
  end

  def self.win_percent_post_season(season)
    post_season_games_per_season = post_season_games[season]

    all_post_season_games = post_season_games[season].map do |games|
      GameTeam.all_game_teams.find_all do |game_teams|
        games == game_teams.game_id
      end
    end.flatten

    total_team_wins = {}
    total_team_games = {}
    all_post_season_games.each do |game_team|
      if total_team_wins.keys.include?(game_team.team_id) == false
        win_count = 0
        win_count += 1 if game_team.result == "WIN"
        game_count = 0
        game_count += 1
        total_team_wins[game_team.team_id] = win_count
        total_team_games[game_team.team_id] = game_count
      else
        total_team_wins[game_team.team_id] += 1 if game_team.result == "WIN"
        total_team_games[game_team.team_id] += 1
      end
    end

    win_percent_by_team = {}
    total_team_games.keys.each do |key|
      avg_wins = total_team_wins[key]/total_team_games[key].to_f
      win_percent_by_team[key] = avg_wins
    end

    win_percent_by_team
  end

  def self.regular_games
    regular_games = {}
    Game.all_games.each do |game|
      if game.type == "Regular Season" && regular_games.keys.include?(game.season)
        game_ids = regular_games[game.season] #
        game_ids << game.game_id
      elsif game.type == "Regular Season" && regular_games.keys.include?(game.season) == false
        regular_games[game.season] = [game.game_id]
      end
    end
    regular_games
  end

  def self.win_percent_regular(season)
    all_regular_games = regular_games[season].map do |game_id|
      GameTeam.all_game_teams.find_all do |game_team|
        game_id == game_team.game_id
      end
    end.flatten

    total_team_wins = {}
    total_team_games = {}
    all_regular_games.each do |game_team|
      if total_team_wins.keys.include?(game_team.team_id) == false
        win_count = 0
        win_count += 1 if game_team.result == "WIN"
        game_count = 0
        game_count += 1
        total_team_wins[game_team.team_id] = win_count
        total_team_games[game_team.team_id] = game_count
      else
        total_team_wins[game_team.team_id] += 1 if game_team.result == "WIN"
        total_team_games[game_team.team_id] += 1
      end
    end

    win_percent_by_team = {}
    total_team_games.keys.each do |key|
      avg_wins = total_team_wins[key]/total_team_games[key].to_f
      win_percent_by_team[key] = avg_wins
    end

    win_percent_by_team
  end

  def self.difference_post_regular_season(season)
    diff_post_reg = {}
    win_percent_regular(season).map do |key|
      if win_percent_regular(season).keys.include?(key[0]) && win_percent_post_season(season).keys.include?(key[0])
      diff = win_percent_regular(season)[key[0]] - win_percent_post_season(season)[key[0]]
      diff_post_reg[key[0]] = diff
      end
    end
    diff_post_reg
  end

  def self.biggest_bust_team_id(season)
    difference_post_regular_season(season).min {|diff| diff.last}.first
  end

  def self.find_team_name_by_id(method)
    team_name = ""
    Team.all_teams.each do |team_param|
      team_name = team_param.team_name if method == team_param.team_id
    end
    team_name
  end

  def self.biggest_bust(season)
    find_team_name_by_id(biggest_bust_team_id(season))
  end

  def self.biggest_surprise_team_id(season)
    difference_post_regular_season(season).max {|diff| diff.last}.first
  end

  def self.biggest_surprise(season)
    find_team_name_by_id(biggest_surprise_team_id(season))
  end
end
