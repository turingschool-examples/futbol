require_relative 'csv_reader'
require 'pry'

class SeasonStats < CSVReader

  def initialize(locations)
      super(locations)
  end

  def winningest_coach(season_id)
    game_id = season_id[0..3]
    games_by_season = @game_teams.group_by { |games| games.game_id[0..3]}
    games_by_id = games_by_season[game_id].group_by {|games| games.head_coach}

    team_hash = games_by_id.transform_values {
      |games| games.find_all{ |game| game.result == 'WIN'}.length }
    length_hash = games_by_id.transform_values {
        |games| games.length }
      return_hash = {}
      team_hash.map { |head_coach, game|  return_hash[head_coach] =
        (team_hash[head_coach] / length_hash[head_coach].to_f)}
      return_hash = return_hash.sort_by {
        |head_coach, win_avg| win_avg}.reverse.to_h
        return_hash.keys[0]

  end

  def worst_coach(season_id)
    game_id = season_id[0..3]
    games_by_season = @game_teams.group_by { |games| games.game_id[0..3]}
    games_by_id = games_by_season[game_id].group_by {|games| games.head_coach}

    team_hash = games_by_id.transform_values {
      |games| games.find_all{ |game| game.result == 'WIN'}.length }
    length_hash = games_by_id.transform_values {
        |games| games.length }
      return_hash = {}
      team_hash.map { |head_coach, game|  return_hash[head_coach] =
        (team_hash[head_coach] / length_hash[head_coach].to_f)}
      return_hash = return_hash.sort_by {
        |head_coach, win_avg| win_avg}.to_h
     return_hash.keys[0]
  end

  def most_accurate_team(season_id)
    game_id = season_id[0..3]
    games_by_season = @game_teams.group_by { |games| games.game_id[0..3]}
    games_by_id = games_by_season[game_id].group_by {|games| games.team_id}
    gameee = @games.group_by{|games| games.season}
    shot_hash = games_by_id.transform_values {
      |games| games.map{ |game| game.shots}.sum }
    goal_hash = games_by_id.transform_values {
      |games| games.map{ |game| game.goals}.sum }
      return_hash = {}
      shot_hash.map do |team_id, game|
        return_hash[team_id] = (goal_hash[team_id] / shot_hash[team_id].to_f)
      end
      return_hash = return_hash.sort_by {
        |team_id, ratio| ratio}.reverse.to_h
     team_name(return_hash.keys[0])
  end

  def least_accurate_team(season_id)
    game_id = season_id[0..3]
    games_by_season = @game_teams.group_by { |games| games.game_id[0..3]}
    games_by_id = games_by_season[game_id].group_by {|games| games.team_id}
    gameee = @games.group_by{|games| games.season}
    shot_hash = games_by_id.transform_values {
      |games| games.map{ |game| game.shots}.sum }
    goal_hash = games_by_id.transform_values {
      |games| games.map{ |game| game.goals}.sum }
      return_hash = {}
      shot_hash.map do |team_id, game|
        return_hash[team_id] = (goal_hash[team_id] / shot_hash[team_id].to_f)
      end
      return_hash = return_hash.sort_by {
        |team_id, ratio| ratio}.to_h
    team_name(return_hash.keys[0])
  end

  def most_tackles(season_id)
    game_id = season_id[0..3]
    games_by_season = @game_teams.group_by { |games| games.game_id[0..3]}
    games_by_id = games_by_season[game_id].group_by {|games| games.team_id}
    shot_hash = games_by_id.transform_values {
      |games| games.map{ |game| game.tackles}.sum }
    return_hash = shot_hash.sort_by {
      |team_id, tackles| tackles}.reverse.to_h
    team_name(return_hash.keys[0])
    # highest_tackles = total_tackles_by_season(season_id).max_by do |team_id, total_tackles|
    #   total_tackles
    # end
  end

  def fewest_tackles(season_id)
    game_id = season_id[0..3]
    games_by_season = @game_teams.group_by { |games| games.game_id[0..3]}
    games_by_id = games_by_season[game_id].group_by {|games| games.team_id}
    shot_hash = games_by_id.transform_values {
      |games| games.map{ |game| game.tackles}.sum }
    return_hash = shot_hash.sort_by {
      |team_id, tackles| tackles}.to_h
    team_name(return_hash.keys[0])
    # lowest_tackles = total_tackles_by_season(season_id).min_by do |team_id, total_tackles|
    #   total_tackles
    # end
  end

  def games_by_season(season) # Take in an argument that is year/season converts game_id to year, returns :year{[games]}
    @games.find_all do |game|
      game.season == season
      season
    end
  end

  def organize_teams(season) #organize by team_id returns :team_id{[games]}
    team_hash = games_by_season(season).group_by {|game| game.team_id}
  end

  # def team_winning_percentage_by_season(season_id) #calculates/returns winning percentage
  #   win_percentage_hash = {}
  #   organize_teams(season_id).each do |team_id,game_teams|
  #     number_of_wins = 0
  #     game_teams.each do |game_team|
  #       if game_team.result == "WIN"
  #         number_of_wins += 1
  #       end
  #     end
  #       total_games = game_teams.count
  #       win_percentage = number_of_wins.to_f / total_games.to_f
  #       win_percentage_hash[team_id] = win_percentage.round(2)
  #     end
  #     win_percentage_hash
  # end

  # def team_shot_percentage_by_season(season_id) #calculates/returns winning percentage
  #   shot_percentage_hash = {}
  #   organize_teams(season_id).each do |team_id,game_teams|
  #     number_of_goals = 0
  #     number_of_shots = 0
  #     game_teams.each do |game_team|
  #         number_of_goals += game_team.goals
  #         number_of_shots += game_team.shots
  #       end
  #       shot_percentage = number_of_goals.to_f / number_of_shots.to_f
  #       shot_percentage_hash[team_id] = shot_percentage.round(2)
  #     end
  #     shot_percentage_hash
  # end

  # def total_tackles_by_season(season_id)
  #   tackle_total_hash = {}
  #   organize_teams(season_id).each do |team_id,game_teams|
  #     number_of_tackles = 0
  #     game_teams.each do |game_team|
  #       number_of_tackles += game_team.tackles
  #     end
  #     tackle_total_hash[team_id] = number_of_tackles
  #   end
  #   tackle_total_hash
  # end

  def team_name(team_id)
    team_name_by_id = @teams.find do |team|
      team.team_id == team_id
    end
    team_name_by_id.team_name
  end
end
