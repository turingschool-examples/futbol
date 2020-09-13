module Groupable
  #game_manager
  def hash_of_seasons
    @game_data.group_by {|game| game.season}
  end

  #game_teams_manager
  def group_by_coach(season)
    games_from_season(season).group_by {|game| game.head_coach}
  end

  def find_by_team_id(season)
    games_from_season(season).group_by {|team| team.team_id}
  end

  #team_manager
  def group_by_team_id
    @game_teams_data.group_by do |team|
      team.team_id
    end
  end

  def group_by_season(team_id)
    all_team_games(team_id).group_by do |game|
      game.game_id.to_s[0..3]
    end
  end
end
