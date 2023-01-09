require 'csv'

class StatTracker 
    attr_reader :game_teams,
                :games,
                :teams

  def initialize(game_teams, games, teams)
    @game_teams = game_teams
    @games = games
    @teams = teams
    game_stats = GameStats.new(@games)
  end

  def self.from_csv(locations)
    game_teams = game_teams_from_csv(locations)
    games = games_from_csv(locations)
    teams = teams_from_csv(locations)
    StatTracker.new(game_teams, games, teams)
  end

  def self.game_teams_from_csv(locations)
    array = []
    game_teams_array = []
    CSV.foreach(locations[:game_teams], headers: true) do |info|
      new_info = {
        game_id: info["game_id"].to_i,
        team_id: info["team_id"], 
        hoa: info["HoA"], 
        result: info["result"], 
        settled_in: info["settled_in"],
        head_coach: info["head_coach"],
        goals: info["goals"].to_i,
        shots: info["shots"].to_i,
        tackles: info["tackles"].to_i,
        pim: info["pim"].to_i,
        powerplay_opportunities: info["powerPlayOpportunities"].to_i,
        powerplay_goals: info["powerPlayGoals"].to_i,
        faceoff_win_percentage: info["faceOffWinPercentage"].to_f,
        giveaways: info["giveaways"].to_i,
        takeaways: info["takeaways"].to_i
      }  
      array << new_info
    end
      array = array.uniq
      array.each {|array_item| game_teams_array << GameTeam.new(array_item)} 
    game_teams_array
  end

  def self.games_from_csv(locations)
    games_array = []
    CSV.foreach(locations[:games], headers: true) do |info|
      new_info = {
        game_id: info["game_id"].to_i, 
        season: info["season"], 
        type: info["type"], 
        date_time: info["date_time"],
        away_team_id: info["away_team_id"],
        home_team_id: info["home_team_id"],
        away_goals: info["away_goals"].to_i,
        home_goals: info["home_goals"].to_i,
        venue: info["venue"],
        venue_link: info["venue_link"]
      }  
      games_array << Game.new(new_info)
    end
    games_array
  end

  def self.teams_from_csv(locations)
    teams_array = []
    CSV.foreach(locations[:teams], headers: true) do |info|
      new_info = {
        team_id: info["team_id"],
        franchise_id: info["franchiseId"],
        team_name: info["teamName"],
        abbreviation: info["abbreviation"],
        stadium: info["Stadium"],
        link: info["link"]
      }
      teams_array << Team.new(new_info)
    end
    teams_array
  end

  def highest_total_score
    total_scores.last
  end

  def lowest_total_score
    total_scores.first
  end

  def total_scores
    game_sums = @games.map do |game|
      game[:away_goals] + game[:home_goals]
    end.sort
  end

  def percentage_home_wins
    total_of_home_games = 0
    wins_at_home = 0 
    @game_teams.each do | k, v |
      if k[:hoa] == "home"
        total_of_home_games += 1
      end
      if k[:hoa] == "home" && k[:result] == "WIN"
        wins_at_home += 1
      end
    end
    percent_win = ((wins_at_home / total_of_home_games.to_f)).round(2)
  end

  def percentage_visitor_wins
    total_of_home_games = 0
    losses_at_home = 0 
    @game_teams.each do | k, v |
      if k[:hoa] == "home"
        total_of_home_games += 1
      end
      if k[:hoa] == "home" && k[:result] == "LOSS"
        losses_at_home += 1
      end
    end
    percent_loss = ((losses_at_home / total_of_home_games.to_f)).round(2)
  end
 
  def percentage_ties
    ties = 0 
    total_of_games = @game_teams.count
    @game_teams.each do | k, v |
      if k[:result] == "TIE"
        ties += 1
      end
    end
    percent_ties = ((ties / total_of_games.to_f)).round(2)
  end

  def count_of_games_by_season
    new_hash = Hash.new(0) 
    games.each {|game| new_hash[game[:season]] += 1}
    return new_hash
  end

  def average_goals_per_game 
    goals = 0 
    games.each {|game| goals += (game[:away_goals] + game[:home_goals])}
    average = (goals.to_f/(games.count.to_f)).round(2)
    return average
  end
 
  def average_goals_by_season
    new_hash = Hash.new(0) 
    games.each {|game| new_hash[game[:season]]  = season_goals(game[:season])}
    return new_hash
  end

 def season_goals(season)
  number = 0
  goals = 0
  games.each do |game|
    if game[:season] == season
      number += 1 
      goals += (game[:away_goals] + game[:home_goals])
    end
  end
  average = (goals.to_f/number.to_f).round(2)
 end

  def count_of_teams
    @teams.count
  end

    def team_id_all_goals
      team_id_all_goals_hash = Hash.new { |hash, key| hash[key] = [] }
      @game_teams.each do |game_teams|
        team_id_all_goals_hash[game_teams[:team_id]] << game_teams[:goals]
      end
      return team_id_all_goals_hash
    end

    def team_goal_avg(team_all_goals_hash)
      team_goal_avg_hash = Hash.new { |hash, key| hash[key] = 0 }
      team_all_goals_hash.each do |team_id, all_goals|
        team_goal_avg_hash[team_id] = (all_goals.sum.to_f / all_goals.length.to_f).round(2)
      end
      return team_goal_avg_hash
    end

    def best_team_avg(id)
      @teams.find do |info_line|
        if info_line[:team_id] == id
          return info_line[:team_name] 
        end
      end
    end

  def best_offense
    team_all_goals_hash = team_id_all_goals
    team_avg = team_goal_avg(team_all_goals_hash)
    id = team_avg.key(team_avg.values.max)
    best_team_avg(id)
  end

  def worst_offense
    team_all_goals_hash = team_id_all_goals
    team_avg = team_goal_avg(team_all_goals_hash)
    id = team_avg.key(team_avg.values.min)
    best_team_avg(id)
  end

  def away_team_goals
    id_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do | k, v |
      if k[:hoa] == "away"
        id_goals[k[:team_id]] << k[:goals]
      end
    end
    return id_goals
  end

  def home_team_goals
    id_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do | k, v |
      if k[:hoa] == "home"
        id_goals[k[:team_id]] << k[:goals]
      end
    end
    return id_goals
  end

  def avg_team_goals(team_goals_hash)
    team_and_goals_avg = Hash.new { |hash, key| hash[key] = 0 }
    team_goals_hash.each do |team_id, goals_scored|
      team_and_goals_avg[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(6)
    end
    return team_and_goals_avg.sort_by { |key, value| value }
  end

  def team_name(id)
    @teams.each do |info_line|
      if info_line[:team_id] == id
        return info_line[:team_name] 
      end
    end
  end

  def highest_scoring_visitor
    team_goals_hash = away_team_goals
    avg_hash = avg_team_goals(team_goals_hash)
    id = avg_hash.reverse.first.first
    team_name(id)
  end
 
  def highest_scoring_home_team
    team_goals_hash = home_team_goals
    avg_hash = avg_team_goals(team_goals_hash)
    id = avg_hash.reverse.first.first
    team_name(id)
  end

  def lowest_scoring_visitor
    team_goals_hash = away_team_goals
    avg_hash = avg_team_goals(team_goals_hash)
    id = avg_hash.first.first
    team_name(id)
  end

  def lowest_scoring_home_team
    team_goals_hash = home_team_goals
    avg_hash = avg_team_goals(team_goals_hash)
    id = avg_hash.first.first
    team_name(id)
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

  def all_games_by_season
    @games.group_by { |game| game[:season] } 
  end

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

 ################## Team Statisics ##################
 
 def team_info(team_id)
  selected = teams.select do |team| 
    team[:team_id] == team_id 
  end 
  team = selected[0]
  
  hash = {
    "team_id"=> team[:team_id], 
    "franchise_id"=> team[:franchise_id], 
    "team_name"=> team[:team_name], 
    "abbreviation"=> team[:abbreviation], 
    "link"=> team[:link]
  }
  return hash
  end

  def best_season(team_id)
    season_array = ordered_season_array(team_id)
    season_array.sort.reverse[0][1]
  end 

  def worst_season(team_id)
    season_array = ordered_season_array(team_id)
    season_array.sort[0][1]
  end

  def ordered_season_array(team_id)
    relevant_game_teams = find_relevant_game_teams_by_teamid(team_id)
    relevant_games = find_corresponding_games_by_gameteam(relevant_game_teams)
    results_by_season = group_by_season(relevant_games, relevant_game_teams) 
    season_array = order_list(results_by_season)
  end

  def find_relevant_game_teams_by_teamid(team_id)
    game_teams.find_all { |game_team| game_team[:team_id] == team_id }
  end 

  def find_corresponding_games_by_gameteam(relevant_game_teams)
    games.find_all do |game|
      relevant_game_teams.each {|game_team| game_team[:game_id] == game[:game_id]} 
      end
  end
   
  def group_by_season(relevant_games, relevant_game_teams)
    results_by_season = Hash.new{ |hash, key| hash[key] = [] }
    grouped = relevant_games.group_by { |game| game[:season]}

    grouped.each do |key, values|
      values.each do |value|
      relevant_game_teams.each do |game_team|
          if value[:game_id] == game_team[:game_id]
            results_by_season[key] << game_team[:result]
          end
        end
      end
    end
    return results_by_season 
  end 

  def order_list(hash_seasons)
    season_array = []
    hash_seasons.each do |key, value|
      season_array << [(value.count("WIN").to_f/value.count.to_f), key]
    end
    return season_array
  end

  def average_win_percentage(team_id)
    relevant_games = find_relevant_game_teams_by_teamid(team_id)
    victories = 0 
    relevant_games.each do |game|
      if game[:result] == "WIN"
        victories += 1 
      end
    end
  
    percent = ((victories.to_f)/((relevant_games.count).to_f)).round(2) 
  end

  def most_goals_scored(team_id) 
    relevant_games = find_relevant_game_teams_by_teamid(team_id)
    goals = create_goals_array(relevant_games)
    return goals.max 
  end

  def fewest_goals_scored(team_id)
    relevant_games = find_relevant_game_teams_by_teamid(team_id)
    goals = create_goals_array(relevant_games)
    return goals.min 
  end 

  def create_goals_array(relevant_games)
    goals = []
    relevant_games.each {|game| goals << game[:goals]}
    return goals 
  end

  def favorite_opponent(team_id)
    sorted_array = sorted_array_of_opponent_win_percentages(team_id)
    result_id = sorted_array.reverse.first.first
    determine_team_name_based_on_team_id(result_id)
  end

  def rival(team_id)
    sorted_array = sorted_array_of_opponent_win_percentages(team_id)
    result_id = sorted_array.first.first
    determine_team_name_based_on_team_id(result_id)
  end

  def sorted_array_of_opponent_win_percentages(team_id)
    relevant_game_teams = find_relevant_game_teams_by_teamid(team_id)
    relevant_games = find_relevant_games_based_on_game_team_hashes(relevant_game_teams)
    hashed_info = hashed_info(relevant_games, relevant_game_teams, team_id)
    array = accumulate_hash(hashed_info)
    sorted = sort_based_on_value(array)
  end

  def find_relevant_games_based_on_game_team_hashes(relevant_game_teams)
    relevant_games = []
    games.each do |game|
      relevant_game_teams.each do |game_team|
        if game[:game_id] == game_team[:game_id]
          relevant_games << game 
        end
      end
    end
    return relevant_games
  end 

  def hashed_info(relevant_games, relevant_game_teams, team_id)
    new_hash = Hash.new { |hash, key| hash[key] = [] }
    relevant_games.each do |game|
      if game[:away_team_id] != team_id 
        new_hash[game[:away_team_id]] << determine_game_outcome(game, relevant_game_teams)
      elsif game[:home_team_id] != team_id
        new_hash[game[:home_team_id]] << determine_game_outcome(game, relevant_game_teams)
      end
    end
    return new_hash
  end

  def determine_game_outcome(game, relevant_game_teams) 
    relevant_game_teams.each do |game_team|
      if game_team[:game_id] == game[:game_id]
        return game_team[:result] 
      end
    end
  end

  def accumulate_hash(hash)
    percentage_data = []
    hash.each {|key, value|percentage_data << [key, ((value.count("WIN").to_f)/(value.count.to_f))]}
    return percentage_data
  end

  def sort_based_on_value(array)
    array.to_h.sort_by {|key, value| value}
  end

  def determine_team_name_based_on_team_id(result_id)
    selected = teams.select { |team| team[:team_id] == result_id }
    selected.first[:team_name]
  end 
end

