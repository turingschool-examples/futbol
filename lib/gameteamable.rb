module Gameteamable


  def find_by_team(team_id)
    all.find_all{|game| game.team_id == team_id}
  end

  def home_games
    (all.find_all {|gt| gt.hoa == "home" }).count
  end

  def coach_record(season_id)
    game_teams_in_season = all.find_all {|gt| gt.season_id == season_id.to_s[0..3]}
    hash_of_hashes(game_teams_in_season, :head_coach, :wins, :games_played, :gt_win?, 1)
  end

  def get_goal_shots_by_game_team(game_teams)
    hash_of_hashes(game_teams,:team_id,:goals,:shots,:goals,:shots)
  end

  def gets_team_shots_goals_count(season)
    season_games = Game.grouped_by_season(season)
    matches = []
    season_games.each {|game|matches.concat(GameTeam.find_by(game.game_id))}
    get_goal_shots_by_game_team(matches)
  end

  def games_by_team_name(season_id)
    game_id_first = season_id.to_s[0..3]
    all_games_by_id = all.find_all {|game| game.season_id == game_id_first}
    all_games_by_id.group_by { |game| game.team_id }
  end

  def tackles_by_team(season_id)
    tackles_by_team = {}
    games_by_team_name(season_id).each do |key, value|
      total_tackles = value.sum { |value| value.tackles}
      tackles_by_team[key] = total_tackles
    end
      tackles_by_team
  end

  def total_goals_per_team
    grouped_team = all.group_by{|game| game.team_id}
    grouped_team.keys.each_with_object({}) do |team_id , hash|
      hash[team_id] = (grouped_team[team_id].sum(&:goals) / grouped_team[team_id].length.to_f).round(2)
    end
  end

  def game_teams_with_opponent(team_id)
    game_ids = all.map {|gt| gt.game_id if gt.team_id == team_id }.compact
    game_teams_with_these_ids = all.find_all do |gt|
      game_ids.include?(gt.game_id) && gt.team_id != team_id
    end
    game_teams_with_these_ids
  end

  def opponents_records(team_id)
    hash_of_hashes(game_teams_with_opponent(team_id), :team_id, :wins, :games_played, :gt_win?, 1)
  end

end
