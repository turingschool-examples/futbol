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
    coaches_hash = Hash.new
    season_coaches(season_id).find_all do |coach|
      total_games = game_teams_data_for_season(season_id).count do |game|
        game.head_coach == coach
      end
      total_wins = game_teams_data_for_season(season_id).count do |game|
        game.head_coach == coach && game.result == "WIN"
      end
      coaches_hash[coach] = ((total_wins.to_f/total_games.to_f) * 100).round(2)
    end
    coaches_hash
  end

  def winningest_coach(season_id)
    coaches_by_win_percentage(season_id).max_by do |coach, win_percentage|
      win_percentage
    end[0]
  end

  def worst_coach(season_id)
    coaches_by_win_percentage(season_id).min_by do |coach, win_percentage|
      win_percentage
    end[0]
  end

  def total_shots_by_team(season_id, team)
    total_shots = game_teams_data_for_season(season_id).sum do |game|
      if game.team_id == team
        game.shots
      else
        0
      end
    end
    total_shots
  end

  def total_goals_by_team(season_id, team)
    total_goals = game_teams_data_for_season(season_id).sum do |game|
      if game.team_id == team
        game.goals
      else
        0
      end
    end
    total_goals
  end

  def team_accuracy(season_id)
    team_hash = Hash.new
    season_teams(season_id).each do |team|
      ratio = total_goals_by_team(season_id, team).to_f/total_shots_by_team(season_id, team).to_f
      team_hash[team] = ratio.round(6)
    end
    team_hash
  end

  def most_accurate_team(season_id)
    most_accurate = team_accuracy(season_id).max_by do |team, accuracy|
      accuracy
    end[0]
    @teams.find do |team|
      team.team_id == most_accurate
    end.team_name
  end

  def season_teams(season_id)
    game_teams_data_for_season(season_id).map do |game|
      game.team_id
    end.uniq
  end

  def least_accurate_team(season_id)
    least_accurate = team_accuracy(season_id).min_by do |team, accuracy|
      accuracy
    end[0]
    @teams.find do |team|
      team.team_id == least_accurate
    end.team_name
  end

  def most_tackles(season_id)
    most_tackles_hash = Hash.new
    season_teams(season_id).each do |team|
      total_tackles = game_teams_data_for_season(season_id).sum do |game|
        if game.team_id == team
          game.tackles
        else
          0
        end
      end
      most_tackles_hash[team] = total_tackles
    end
    most_tackles_team = most_tackles_hash.max_by do |team, tackles|
      tackles
    end[0]

    @teams.find do |team|
      team.team_id == most_tackles_team
    end.team_name
  end
#I may need to look into what to do if there is a tie
#for most or fewest tackles

  def fewest_tackles(season_id)
    fewest_tackles_hash = Hash.new
    season_teams(season_id).each do |team|
      total_tackles = game_teams_data_for_season(season_id).sum do |game|
        if game.team_id == team
          game.tackles
        else
          0
        end
      end
      fewest_tackles_hash[team] = total_tackles
    end
    fewest_tackles_team = fewest_tackles_hash.min_by do |team, tackles|
      tackles
    end[0]

    @teams.find do |team|
      team.team_id == fewest_tackles_team
    end.team_name
  end
end
