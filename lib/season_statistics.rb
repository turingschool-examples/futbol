class SeasonStatistics
  attr_reader :stat_tracker

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  def games_teams_data(column)
    @stat_tracker[:game_teams][column]
  end

  def game_id_to_season_id
    games_teams_data("game_id").map do |game_id|
      last_year = game_id[0..3]
      (last_year.to_i - 1).to_s.concat(last_year)
    end
  end

  def head_coaches_and_result_data_set
    game_id_to_season_id.zip(games_teams_data("head_coach"),games_teams_data("result"))
  end

  def grouped_by_season(data_set)
    data_set.group_by(&:first)
  end

  def game_result_hash(season_id)
    game_results = {}
    grouped_by_season(head_coaches_and_result_data_set)[season_id].each do |array|
      result = array[2].downcase.to_sym
      if game_results[array[1]].nil?
        game_results[array[1]] = {:total => 1, result => 1}
      else
        if game_results.fetch(array[1])[result].nil?
          game_results.fetch(array[1])[result] = 1
          game_results.fetch(array[1])[:total] += 1
        else
          game_results.fetch(array[1])[result] += 1
          game_results.fetch(array[1])[:total] += 1
        end
      end
    end
    game_results
  end

  def winningest_coach(season_id)
    # winningest_coach 	Name of the Coach with the best win percentage for the season 	String
    compare = {}
    game_result_hash(season_id).each do |coach, data|
      compare[coach] = ((data[:win].to_f / data[:total])*100)
    end
    compare.max_by { |coach, percent| percent }[0]
  end

  def worst_coach(season_id)
    # worst_coach 	Name of the Coach with the worst win percentage for the season 	String
    compare = {}
    game_result_hash(season_id).each do |coach, data|
      compare[coach] = ((data[:win].to_f / data[:total])*100)
    end
    compare.min_by { |coach, percent| percent }[0]
  end

  def team_id_to_team_name(team_id)
    team_name_lookup = stat_tracker[:teams]["team_id"].zip(stat_tracker[:teams]["teamName"]).to_h
    team_name_lookup[team_id]
  end

  def team_important_data_set
    game_id_to_season_id.zip(games_teams_data("team_id"),games_teams_data("shots"),games_teams_data("goals"),games_teams_data("tackles"))
  end

  def shots_and_goals_hash(season_id)
    team_results = {}
    grouped_by_season(team_important_data_set)[season_id].each do |array|
      shots = array[2].to_i
      goals = array[3].to_i
      tackles = array[4].to_i
      if team_results[array[1]].nil?
        team_results[array[1]] = {goals: 0, shots: 0, tackles: 0}
        team_results.fetch(array[1])[:shots] = shots
        team_results.fetch(array[1])[:goals] = goals
        team_results.fetch(array[1])[:tackles] = tackles
      else
        team_results.fetch(array[1])[:shots] += shots
        team_results.fetch(array[1])[:goals] += goals
        team_results.fetch(array[1])[:tackles] += tackles
      end
    end
    team_results
  end

  def most_accurate_team(season_id)
    # most_accurate_team 	Name of the Team with the best ratio of shots to goals for the season 	String
    teams = {}
    shots_and_goals_hash(season_id).each do |team, data|
      teams[team] = ((data[:goals] / data[:shots].to_f) * 100)
    end
    team_id_to_team_name(teams.max_by { |team, percent| percent }[0])
  end

  def least_accurate_team(season_id)
    # least_accurate_team 	Name of the Team with the worst ratio of shots to goals for the season 	String
    teams = {}
    shots_and_goals_hash(season_id).each do |team, data|
      teams[team] = ((data[:goals] / data[:shots].to_f) * 100)
    end
    team_id_to_team_name(teams.min_by { |team, percent| percent }[0])
  end

  def most_tackles(season_id)
    # most_tackles 	Name of the Team with the most tackles in the season 	String
    team = shots_and_goals_hash(season_id).max_by do |team, data|
      data[:tackles]
    end
    team_id_to_team_name(team[0])

  end

  def fewest_tackles(season_id)
    # fewest_tackles 	Name of the Team with the fewest tackles in the season 	String
    team = shots_and_goals_hash(season_id).min_by do |team, data|
      data[:tackles]
    end
    team_id_to_team_name(team[0])
  end
end
