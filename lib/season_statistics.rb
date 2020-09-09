class SeasonStatistics
  attr_reader :stat_tracker

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  def game_id_to_season_id
    # first 4 characters in game_id is the last four in season
    # take those 4, change into an integer, duplicate and subtract one, then concatenate

  end

  #data set for coaches
  # games_teams join game_id, season conversion, head_coach, result
  #List of coaches (games_teams)
  #Find win percentage by counting number of games they had and dividing that
  # with the number of those that are wins
  # Dataset is hash with coach as key, value is another hash of season as key
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


  def winningest_coach
    # winningest_coach 	Name of the Coach with the best win percentage for the season 	String

  end

  def worst_coach
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

  def most_accurate_team
    # most_accurate_team 	Name of the Team with the best ratio of shots to goals for the season 	String

  end

  def least_accurate_team
    # least_accurate_team 	Name of the Team with the worst ratio of shots to goals for the season 	String

  end

  def most_tackles
    # most_tackles 	Name of the Team with the most tackles in the season 	String

  end

  def fewest_tackles
    # fewest_tackles 	Name of the Team with the fewest tackles in the season 	String

  end
end
