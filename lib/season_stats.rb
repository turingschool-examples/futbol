require './lib/stats'

class SeasonStats < Stats

  def winningest_coach(season)
    ratios = determine_coach_ratios(season)
    ratios.reverse.first.first
  end 

  def worst_coach(season)
    ratios = determine_coach_ratios(season)
    ratios.first.first
  end 

  def determine_coach_ratios(season)
    games_in_season = list_gameteams_from_particular_season(season)
    coach_hash = coach_victory_percentage_hash(games_in_season)
    ratios = determine_sorted_ratio(coach_hash)
  end 

  def list_gameteams_from_particular_season(season)
    games_in_season = list_games_per_season(season)
    pull_gameids = games_in_season.map {|game| game[:game_id]} 

    pull_gameids.flat_map do |game_id|
      game_teams.find_all {|game_team| game_id == game_team[:game_id]}
    end
  end 

  def list_games_per_season(season)
    games.find_all {|game| game[:season] == season} 
  end

  def coach_victory_percentage_hash(games_in_season)
    coach= Hash.new{ |hash, key| hash[key] = [0,0] }

    games_in_season.each do |game_team|
      coach[game_team[:head_coach]][1] += 1
      if game_team[:result] == "WIN"
        coach[game_team[:head_coach]][0] += 1
      end
     end
    return coach
  end 

  def determine_sorted_ratio(hash)
    calculations = []
    hash.each {|key, value| calculations << [key, ((value[0].to_f)/(value[1].to_f))]}
    result = calculations.to_h.sort_by {|key, value| value}
  end

  def most_accurate_team(season)
    hash = team_goals_shots_by_season(season)
    result_hash = team_ratios_by_season(hash)
    id = result_hash.reverse.first.first
    team_name(id)
  end

  def least_accurate_team(season)
    hash = team_goals_shots_by_season(season)
    result_hash = team_ratios_by_season(hash)
    id = result_hash.first.first
    team_name(id)
  end

  # def all_games_by_season
  #   @games.group_by { |game| game[:season] } 
  # end

  def team_goals_shots_by_season(season)
    team_goals_shots = Hash.new { |hash, key| hash[key] = [0, 0] }
    @game_teams.each do |game_team|
      all_games_by_season[season].each do |game|
        if game_team[:game_id] == game[:game_id]
          team_goals_shots[game_team[:team_id]][0] += game_team[:goals]
          team_goals_shots[game_team[:team_id]][1] += game_team[:shots]
        end
      end
    end
    return team_goals_shots
  end

  def team_ratios_by_season(hash)
    calculations = []
    hash.each do |key, value|
      calculations << [key, ((value[0].to_f)/(value[1].to_f))]
    end
    result = calculations.to_h.sort_by { |key, value| value } 
  end

  def team_name(id)
    @teams.each do |team|
        return team[:team_name] if team[:team_id] == id 
    end
  end

  def most_tackles(season)
    total_tackles_per_team = gather_tackles_by_team(season)
    id = total_tackles_per_team.reverse.first.first
    team_name(id)
  end

  def fewest_tackles(season)
    total_tackles_per_team = gather_tackles_by_team(season)
    id = total_tackles_per_team.first.first
    team_name(id)
  end

  def all_games_by_season
    @games.group_by { |game| game[:season] } 
  end

  def gather_tackles_by_team(season)
    team_tackle_hash = Hash.new { |hash, key| hash[key] = 0 }
    @game_teams.each do |info_line|
      all_games_by_season[season].each do |info_line_2|
        if info_line_2[:game_id] == info_line[:game_id]
          team_tackle_hash[info_line[:team_id]] += info_line[:tackles]
        end
      end
    end
    return team_tackle_hash.sort_by {|key, value| value}
  end

end











# CREATE FIRST AN OBJECT OF SEASON THAT IS FOR EACH SEASON, ALL OF THE STATISTICS 

# winningest_coach	Name of the Coach with the best win percentage for the season	String
# worst_coach	Name of the Coach with the worst win percentage for the season	String
# most_accurate_team	Name of the Team with the best ratio of shots to goals for the season	String
# least_accurate_team	Name of the Team with the worst ratio of shots to goals for the season	String
# most_tackles	Name of the Team with the most tackles in the season	String
# fewest_tackles	Name of the Team with the fewest tackles in the season	String

# STAGE 2: 

# FINDING COMMON METHODS BETWEEN SEASON AND TEAM, LEAGUE, GAME THAT WE CAN PUT INTO A MODULE. 