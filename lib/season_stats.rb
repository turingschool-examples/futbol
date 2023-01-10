require './lib/stats'
require './lib/seasonable'

class SeasonStats < Stats
  include Seasonable

  def initialize(locations)
    super(locations)
  end

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
    pull_gameids = games_in_season.map {|game| game.game_id} 

    pull_gameids.flat_map do |game_id|
      game_teams.find_all {|game_team| game_id == game_team.game_id}
    end
  end 

  def list_games_per_season(season)
    games.find_all {|game| game.season == season} 
  end

  def coach_victory_percentage_hash(games_in_season)
    coach= Hash.new{ |hash, key| hash[key] = [0,0] }

    games_in_season.each do |game_team|
      coach[game_team.head_coach][1] += 1
      if game_team.result == "WIN"
        coach[game_team.head_coach][0] += 1
      end
     end
    return coach
  end 

  def determine_sorted_ratio(hash)
    calculations = []
    hash.each {|key, value| calculations << [key, ((value[0].to_f)/(value[1].to_f))]}
    result = calculations.to_h.sort_by {|key, value| value}
  end

  #######

  def most_accurate_team(season)
    hash_game_id_and_goals_shots = team_goals_shots_by_season(season)
    team_id_ratio = team_ratios_by_season(hash_game_id_and_goals_shots)
    id = team_id_ratio.reverse.first.first
    team_name(id)
  end

  def least_accurate_team(season)
    hash_game_id_and_goals_shots = team_goals_shots_by_season(season)
    team_id_ratio = team_ratios_by_season(hash_game_id_and_goals_shots)
    id = team_id_ratio.first.first
    team_name(id)
  end

  def team_goals_shots_by_season(season)
    hash_team_id_gameteams = Hash.new{ |hash, key| hash[key] = [] }
    all_gameteams_by_game_id.each do |game_id, game_team_array|
      game_team_array.each do |game_team|
        all_games_by_season[season].each do |game|
         if game_id == game.game_id
          hash_team_id_gameteams[game_team.team_id].push(game_team)
          end
        end
      end
    end
    
    team_id_goals_shots = Hash.new { |hash, key| hash[key] = [0, 0] }
    hash_team_id_gameteams.each do |team_id, game_teams|
      game_teams.each do |game_team|
        team_id_goals_shots[team_id][0] += game_team.goals
        team_id_goals_shots[team_id][1] += game_team.shots
      end
    end
    return team_id_goals_shots
  end

  def team_ratios_by_season(hash_game_id_and_goals_shots)
    calculations = []
    hash_game_id_and_goals_shots.each do |team_id, goals_shots|
      calculations << [team_id, ((goals_shots[0].to_f)/(goals_shots[1].to_f))]
    end
    result = calculations.to_h.sort_by { |team_id, ratio| ratio } 
  end

  def all_gameteams_by_game_id
    @all_gameteams_by_game_id ||= @game_teams.group_by { |game_team| game_team.game_id }
  end

  #### BELOW : shared methods by most/least accurate & most/fewest tackles

  # def all_games_by_season
  #   @all_games_by_season ||= @games.group_by { |game| game.season } 
  # end


  # def team_name(id)
  #   @teams.each do |team|
  #       return team.team_name if team.team_id == id 
  #   end
  # end

  #####

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

  def gather_tackles_by_team(season)
    team_tackle_hash = Hash.new { |hash, key| hash[key] = 0 }
    @game_teams.each do |info_line|
      all_games_by_season[season].each do |info_line_2|
        if info_line_2.game_id == info_line.game_id
          team_tackle_hash[info_line.team_id] += info_line.tackles
        end
      end
    end
    return team_tackle_hash.sort_by {|key, value| value}
  end
end