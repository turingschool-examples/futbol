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

  def game_result_hash(data_set,season_id)
    game_results = {}
    grouped_by_season(data_set)[season_id].each do |array|
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
    game_result_hash(head_coaches_and_result_data_set,season_id).each do |coach, data|
      compare[coach] = ((data[:win].to_f / data[:total])*100)
    end
    compare.max_by { |coach, percent| percent }[0]
  end

  def worst_coach(season_id)
    # worst_coach 	Name of the Coach with the worst win percentage for the season 	String
    compare = {}
    game_result_hash(head_coaches_and_result_data_set,season_id).each do |coach, data|
      compare[coach] = ((data[:win].to_f / data[:total])*100)
    end
    compare.min_by { |coach, percent| percent }[0]
  end

  #data set for teams
  # games_teams join game_id, season conversion, team_id, shots, goals, tackles
  # list of shots by team by season (games_teams)
  # list of goals by team by season (games_teams)
  # list of tackles by team by season (games_teams)
  # data_set = {
    # "20122013" => {
    #    "4" => {shots: 22, goals: 27, tackles: 11},
    #    "25" => {shots: 23, goals: 25, tackles: 60}
    #    }
    # "20132014" => {
    #    "4" => {shots: 22, goals: 27, tackles: 11},
    #    "25" => {shots: 23, goals: 25, tackles: 60}
    #    }
    #}

  # def team_id_to_team_name
  #   stat_tracker[:teams][data_string_to_name_id]["teamName"]
  # end

  def most_accurate_team(season)
    # most_accurate_team 	Name of the Team with the best ratio of shots to goals for the season 	String

  end

  def least_accurate_team(season)
    # least_accurate_team 	Name of the Team with the worst ratio of shots to goals for the season 	String

  end

  def most_tackles(season)
    # most_tackles 	Name of the Team with the most tackles in the season 	String

  end

  def fewest_tackles(season)
    # fewest_tackles 	Name of the Team with the fewest tackles in the season 	String

  end
end
