require_relative 'calculable'
require_relative 'hashable'
require_relative 'season_statistics'


module TeamStatistics
  include Calculable
  include Hashable

  def team_info(team_id)
    @teams.reduce({}) do |team_info, team|
      team_info["team_id"] = team.team_id if team.team_id == team_id
      team_info["franchise_id"] = team.franchise_id if team.team_id == team_id
      team_info["team_name"] = team.team_name if team.team_id == team_id
      team_info["abbreviation"] = team.abbreviation if team.team_id == team_id
      team_info["link"] = team.link if team.team_id == team_id
      team_info
    end
  end

  def all_seasons
    @games.map {|game| game.season }.uniq
  end

  def games_in_season_for_team(team_id, season_id)
    @game_teams.find_all do |game_team|
      game_team.team_id == team_id && season_id.to_s.slice(0..3).to_i == game_team.game_id.to_s.slice(0..3).to_i
    end
  end

  def find_season_wins(team_id, season_id)
    win_count = 0
    games_in_season_for_team(team_id, season_id).each do |game_team|
      if game_team.result == "WIN"
        win_count += 1
      end
    end
    season_wins = (win_count.to_f / games_in_season_for_team(team_id, season_id).length.to_f).round(2)
    if season_wins.nan?
      season_wins = 0
    else
      season_wins
    end
  end

  def find_win_average_in_seasons(team_id)
    all_seasons.reduce({}) do |hash_name, season|
      hash_name[season] = find_season_wins(team_id, season)
      hash_name
    end
  end

  def best_season(team_id)
    hash_key_max_by(find_win_average_in_seasons(team_id))
  end

  def worst_season(team_id)
    hash_key_min_by(find_win_average_in_seasons(team_id))
  end
end
