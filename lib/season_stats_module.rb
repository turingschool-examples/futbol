module SeasonStatistics
  require 'pry'

  def game_teams_data_for_season(season_id)
    @game_teams.find_all do |game|
      game.game_id[0..3] == season_id[0..3]
    end
  end

  def season_coaches(season_id)
    game_teams_data_for_season(season_id).map do |game|
      game.head_coach
    end.uniq
  end

  def coaches_by_win_percentage(season_id)
    coaches_hash = {}
    season_coaches(season_id).find_all do |coach|
      total_games = game_teams_data_for_season(season_id).count do |game|
        game.head_coach == coach
      end
      total_wins = game_teams_data_for_season(season_id).count do |game|
        game.head_coach == coach && game.result == 'WIN'
      end
      coaches_hash[coach] = ((total_wins.to_f / total_games.to_f) * 100).round(2)
    end
    coaches_hash
  end

  def winningest_coach(season_id)
    coaches_by_win_percentage(season_id).max_by do |_coach, win_percentage|
      win_percentage
    end[0]
  end

  def worst_coach(season_id)
    coaches_by_win_percentage(season_id).min_by do |_coach, win_percentage|
      win_percentage
    end[0]
  end

  def most_accurate_team(season_id)
    team_hash = {}
    season_teams(season_id).each do |team|
      total_shots = game_teams_data_for_season(season_id).sum do |game|
        if game.team_id == team
          game.shots
        else
          0
        end
      end

      total_goals = game_teams_data_for_season(season_id).sum do |game|
        if game.team_id == team
          game.goals
        else
          0
        end
      end
      team_hash[team] = (total_goals.to_f / total_shots.to_f)
    end

    accurate_team = team_hash.max_by do |_team, shot_percentage|
      shot_percentage
    end[0]

    @teams.find do |team|
      team.team_id == accurate_team
    end.team_name
  end

  def season_teams(season_id)
    game_teams_data_for_season(season_id).map do |game|
      game.team_id
    end.uniq
  end

  def least_accurate_team(season_id)
    team_hash = {}
    season_teams(season_id).each do |team|
      total_shots = game_teams_data_for_season(season_id).sum do |game|
        if game.team_id == team
          game.shots
        else
          0
        end
      end

      total_goals = game_teams_data_for_season(season_id).sum do |game|
        if game.team_id == team
          game.goals
        else
          0
        end
      end

      team_hash[team] = (total_goals.to_f / total_shots.to_f)
    end

    not_accurate_team = team_hash.min_by do |_team, shot_percentage|
      shot_percentage
    end[0]

    @teams.find do |team|
      team.team_id == not_accurate_team
    end.team_name
  end

  def total_tackles(season_id)
    tackles_hash = {}
    season_teams(season_id).each do |team|
      tackles_hash[team] = total_tackles_helper(season_id, team)
    end
    tackles_hash
  end

  def total_tackles_helper(season_id, team)
    total_tackles = game_teams_data_for_season(season_id).sum do |game|
      if game.team_id == team
        game.tackles
      else
        0
      end
    end
    total_tackles
  end

  def most_tackles(season_id)
    most_tackles_team = total_tackles(season_id).max_by do |_team, tackles|
      tackles
    end[0]
    @teams.find do |team|
      team.team_id == most_tackles_team
    end.team_name
  end
  # I may need to look into what to do if there is a tie
  # for most or fewest tackles

  def fewest_tackles(season_id)
    fewest_tackles_team = total_tackles(season_id).min_by do |_team, tackles|
      tackles
    end[0]
    @teams.find do |team|
      team.team_id == fewest_tackles_team
    end.team_name
  end
end
