require 'csv'

class StatTracker 
    attr_reader :game_teams,
                :games,
                :teams

  def initialize(game_teams, games, teams)
    @game_teams = game_teams
    @games = games
    @teams = teams
  end

  def self.from_csv(locations)
    game_teams = game_teams_from_csv(locations)
    games = games_from_csv(locations)
    teams = teams_from_csv(locations)
    StatTracker.new(game_teams, games, teams)
  end

  def self.game_teams_from_csv(locations)
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
      game_teams_array << new_info
    end
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
      games_array << new_info
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
      teams_array << new_info
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

  def best_offense
    team_id_all_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do |info_line|
      team_id_all_goals[info_line[:team_id]] << info_line[:goals]
    end
    team_id_avg_goals = Hash.new { |hash, key| hash[key] = 0 }
    team_id_all_goals.each do |team_id, goals_scored|
      team_id_avg_goals[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(2)
    end
    @teams.find do |info_line|
      if info_line[:team_id] == team_id_avg_goals.key(team_id_avg_goals.values.max)
        return info_line[:team_name] 
      end
    end
  end

  def worst_offense
    team_id_all_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do |info_line|
      team_id_all_goals[info_line[:team_id]] << info_line[:goals]
    end

    team_id_avg_goals = Hash.new { |hash, key| hash[key] = 0 }
    team_id_all_goals.each do |team_id, goals_scored|
      team_id_avg_goals[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(2)
    end

    @teams.find do |info_line|
      if info_line[:team_id] == team_id_avg_goals.key(team_id_avg_goals.values.min)
        return info_line[:team_name] 
      end
    end
  end

  def highest_scoring_visitor
    id_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do | k, v |
      if k[:hoa] == "away"
        id_goals[k[:team_id]] << k[:goals]
      end
    end
    id_goals_avg = Hash.new { |hash, key| hash[key] = 0 }
    id_goals.each do |team_id, goals_scored|
      id_goals_avg[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(2)
    end
    @teams.find do |info_line|
      if info_line[:team_id] == id_goals_avg.key(id_goals_avg.values.max)
        return info_line[:team_name] 
      end
    end
  end
  

  def highest_scoring_home_team
    id_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do | k, v |
      if k[:hoa] == "home"
        id_goals[k[:team_id]] << k[:goals]
      end
    end
    id_goals_avg = Hash.new { |hash, key| hash[key] = 0 }
    id_goals.each do |team_id, goals_scored|
      id_goals_avg[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(2)
    end
    @teams.find do |info_line|
      if info_line[:team_id] == id_goals_avg.key(id_goals_avg.values.max)
        return info_line[:team_name] 
      end
    end
  end

  def lowest_scoring_visitor
    id_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do | k, v |
      if k[:hoa] == "away"
        id_goals[k[:team_id]] << k[:goals]
      end
    end
    id_goals_avg = Hash.new { |hash, key| hash[key] = 0 }
    id_goals.each do |team_id, goals_scored|
      id_goals_avg[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(2)
    end
    @teams.find do |info_line|
      if info_line[:team_id] == id_goals_avg.key(id_goals_avg.values.min)
        return info_line[:team_name] 
      end
    end
  end

  def lowest_scoring_home_team
    id_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do | k, v |
    if k[:hoa] == "home"
        id_goals[k[:team_id]] << k[:goals]
      end
    end
    id_goals_avg = Hash.new { |hash, key| hash[key] = 0 }
    id_goals.each do |team_id, goals_scored|
      id_goals_avg[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(2)
    end
    @teams.find do |info_line|
      if info_line[:team_id] == id_goals_avg.key(id_goals_avg.values.min)

        return info_line[:team_name] 
      end
    end
  end


  def winningest_coach(season)
    coach_hash = coach_victory_percentage_hash(season)
    ratios = determine_sorted_ratio(coach_hash)
    ratios.reverse.first.first
  end 

  def worst_coach(season)
    coach_hash = coach_victory_percentage_hash(season)
    ratios = determine_sorted_ratio(coach_hash)
    ratios.first.first
  end

  def list_gameteams_from_particular_season(season)
 
    games_in_season = list_games_per_season(season)
    pull_gameids = games_in_season.map {|game| game[:game_id]} 
    
    # answer = game_teams.find_all do |game_team|
    #   pull_gameids.each do |game_id|  
    #     game_id == game_team[:game_id] 
    #     end 
    #   end
    #   require 'pry'; binding.pry

    total_relevant_gameteams_from_season = []
    pull_gameids.each do |game_id| 
      game_teams.each do |game_team|
        if game_team[:game_id] == game_id
          total_relevant_gameteams_from_season << game_team
        end 
      end
    end
    require 'pry'; binding.pry
    return total_relevant_gameteams_from_season
  end 

  def list_games_per_season(season)
    games.find_all {|game| game[:season] == season} 
  end

  def coach_victory_percentage_hash(season)
    games_in_season = list_gameteams_from_particular_season(season)
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

  def most_tackles(season)
    games_ids_by_season = Hash.new { |hash, key| hash[key] = [] }
    @games.group_by do |game|
      games_ids_by_season[game[:season]] << game
    end

    hash_1 = Hash.new { |hash, key| hash[key] = 0 }
    @game_teams.each do |info_line|
      games_ids_by_season[season].each do |info_line_2|
        if info_line_2[:game_id] == info_line[:game_id]
          hash_1[info_line[:team_id]] += info_line[:tackles]
        end
      end
    end
    @teams.each do |info_line|
      if info_line[:team_id] == hash_1.key(hash_1.values.max)
        return info_line[:team_name] 
      end
    end
  end

  def fewest_tackles(season)
    games_ids_by_season = Hash.new { |hash, key| hash[key] = [] }
    @games.group_by do |game|
      games_ids_by_season[game[:season]] << game
    end

    hash_1 = Hash.new { |hash, key| hash[key] = 0 }
    @game_teams.each do |info_line|
      games_ids_by_season[season].each do |info_line_2|
        if info_line_2[:game_id] == info_line[:game_id]
          hash_1[info_line[:team_id]] += info_line[:tackles]
        end
      end
    end
    @teams.each do |info_line|
      if info_line[:team_id] == hash_1.key(hash_1.values.min)
        return info_line[:team_name] 
      end
    end
  end 


    def most_accurate_team(season)
          
      games_ids_by_season = Hash.new { |hash, key| hash[key] = [] }

      @games.group_by do |game|
        games_ids_by_season[game[:season]] << game
      end

      ratios = Hash.new { |hash, key| hash[key] = [0, 0] }

      @game_teams.each do |game_team|
        games_ids_by_season[season].each do |game|
          if game_team[:game_id] == game[:game_id]
            ratios[game_team[:team_id]][0] += game_team[:goals]
            ratios[game_team[:team_id]][1] += game_team[:shots]
            end
          end
        end 

      calculations = []
      ratios.each do |key, value|
        calculations << [key, ((value[0].to_f)/(value[1].to_f))]
      end
      result = calculations.to_h.sort_by {|key, value| value}.reverse.first.first

      @teams.each do |team|
        if team[:team_id] == result
          return team[:team_name]
        end
      end
    end

  # def least_accurate_team
  # end
  # MOST/LEAST ACCURATE TEAM METHODS ABOVE

 ################## Team Statisics ##################

 def team_info(team_id)
  selected = teams.select do |team|
    team[:team_id] == team_id
  end
  team = selected[0]
  
  hash = {
    team_id: team[:team_id], 
    franchise_id: team[:franchise_id], 
    team_name: team[:team_name], 
    abbreviation: team[:abbreviation], 
    link: team[:link]
  }
  return hash
end

  def best_season(team_id)
    relevant_game_teams = find_relevant_game_teams_by_teamid(team_id)
    relevant_games = find_corresponding_games_by_gameteam(relevant_game_teams)
    results_by_season = group_by_season(relevant_games, relevant_game_teams) 
    season_array = order_list(results_by_season)
    
    season_array.sort.reverse[0][1]


  end 

  def worst_season(team_id)
    relevant_game_teams = find_relevant_game_teams_by_teamid(team_id)
    relevant_games = find_corresponding_games_by_gameteam(relevant_game_teams)
    results_by_season = group_by_season(relevant_games, relevant_game_teams) 
    season_array = order_list(results_by_season)
    
    season_array.sort[0][1]

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

  # FAVORITE OPPONENTS

  def favorite_opponent(team_id)
    relevant_game_teams = find_relevant_game_teams_by_teamid(team_id)
    relevant_games = find_relevant_games(relevant_game_teams)
    hashed_info = hash(relevant_games, team_id)
    game_id_win_loss = winloss(team_id, relevant_game_teams)
    game_id_win = splitwin(game_id_win_loss)
    game_id_loss = splitloss(game_id_win_loss)
    game_id_ties = split_ties(game_id_win_loss)
    accumulate_hash = accumulate(game_id_win, game_id_loss, game_id_ties, hashed_info)


    sorted_calculations = accumulate_hash.reverse
    result_id = sorted_calculations.first.first

    selected = teams.select do |team|
      team[:team_id] == result_id
    end
    conclusion = selected.first[:team_name]

  end

  def rival(team_id)
    relevant_game_teams = find_relevant_game_teams_by_teamid(team_id)
    relevant_games = find_relevant_games(relevant_game_teams)
    hashed_info = hash(relevant_games, team_id)
    game_id_win_loss = winloss(team_id, relevant_game_teams)
    game_id_win = splitwin(game_id_win_loss)
    game_id_loss = splitloss(game_id_win_loss)
    game_id_ties = split_ties(game_id_win_loss)
    accumulate_hash = accumulate(game_id_win, game_id_loss, game_id_ties, hashed_info)

    sorted_calculations = accumulate_hash
    result_id = sorted_calculations.first.first

    selected = teams.select do |team|
      team[:team_id] == result_id
    end
    conclusion = selected.first[:team_name]


  end

  def find_relevant_games(relevant_game_teams)
    relevant_games = []
    games.each do |game|
      relevant_game_teams.each do |game_team|
        if game[:game_id] == game_team[:game_id]
          relevant_games << game 
        end
      end
    end
    require 'pry'; binding.pry
    return relevant_games
  end 

  def hash(relevant_games, team_id)
    new_hash = Hash.new { |hash, key| hash[key] = [] }
    relevant_games.each do |game|
      if game[:away_team_id] != team_id 
        new_hash[game[:away_team_id]] << game[:game_id]
      elsif game[:home_team_id] != team_id
        new_hash[game[:home_team_id]] << game[:game_id]
      end
    end
    return new_hash
  end

  def winloss(team_id, relevant_game_teams)
    hashed_win_lost = Hash.new 

    relevant_game_teams.each do |game_team|
      hashed_win_lost[game_team[:game_id]] = game_team[:result]
    end
    return hashed_win_lost
  end 

  def splitwin(game_id_win_loss)
    wins = []
    game_id_win_loss.each do |key, value|
      if value == "WIN"
        wins << key 
      end
    end
    return wins
  end

  def splitloss(game_id_win_loss)
    losses = []
    game_id_win_loss.each do |key, value|
      if value == "LOSS" 
        losses << key 
      end
    end
    return losses

  end

  def split_ties(game_id_win_loss)
    ties = []
    game_id_win_loss.each do |key, value|
      if value == "TIE" 
        ties << key 
      end
    end
    return ties

  end

  def accumulate(game_id_win, game_id_loss, game_id_ties, hashed_info)
    victories_over_team = Hash.new{ |hash, key| hash[key] = 0 }
    losses = Hash.new{ |hash, key| hash[key] = 0 }
    ties = Hash.new{ |hash, key| hash[key] = 0 }
    final_calculations = Hash.new
    
    game_id_win.each do |id|
      hashed_info.keys.each do |key|
        if hashed_info[key].include?(id)
          victories_over_team[key] += 1
          end
        end
      end
    
    game_id_loss.each do |id|
      hashed_info.keys.each do |key|
        if hashed_info[key].include?(id)
          losses[key] += 1
          end
        end
      end

      game_id_ties.each do |id|
        hashed_info.keys.each do |key|
          if hashed_info[key].include?(id)
            ties[key] += 1
            end
          end
        end

    hashed_info.keys.each do |key|
      final_calculations[key] = victories_over_team[key]/ ((victories_over_team[key].to_f) +(losses[key].to_f) +ties[key].to_f) 
    end 
    
      sorted_calculations = final_calculations.sort_by do |key, value|
        value
      end 

    end 





  


end


# all_coaches = total_games.group_by do |game|
#   game[:head_coach]
# end
