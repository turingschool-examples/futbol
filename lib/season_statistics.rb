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

  def coaches_results_by_season_data
    head_coaches_and_result_data_set[1..2]

    grouped_by_season = head_coaches_and_result_data_set.group_by(&:first)
    grouped_by_season.each do |season_id, data|
      require "pry"; binding.pry
      grouped_by_season[season_id] = data.map do |full_data|
        full_data.last(2).group_by 
      end
    end

  end

  #data set for coaches
  # games_teams join game_id, season conversion, head_coach, result
  #List of coaches (games_teams)
  #Find win percentage by counting number of games they had and dividing that
  # with the number of those that are wins
  # Dataset is hash with season as key, value is another hash of coach as key
  # values as hash of wins key, losses key, total games key
  # data_set = {
    # "20122013" => {
    #    "John Tortorella" => {wins: 22, losses: 27, ties: 11, total: 60},
    #    "Claude Julien" => {wins: 23, losses: 25, ties: 12, total: 60}
    #    }
    # "20132014" => {
    #    "John Tortorella" => {wins: 22, losses: 27, ties: 11, total: 60},
    #    "Claude Julien" => {wins: 23, losses: 25, ties: 12, total: 60}
    #    }
    #}


  def winningest_coach(season)
    # winningest_coach 	Name of the Coach with the best win percentage for the season 	String
    coaches_results_by_season_data[season]
  end

  def worst_coach(season)
    # worst_coach 	Name of the Coach with the worst win percentage for the season 	String

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
