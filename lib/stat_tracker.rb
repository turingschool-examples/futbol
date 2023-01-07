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

 ################## Game Statisics ##################

  # Highest sum of the winning and losing teams scores
  def highest_total_score
    total_scores.last
  end

  # Lowest sum of the winning and losing teams scores
  def lowest_total_score
    total_scores.first
  end

  # HELPER: for highest/lowest total score
  def total_scores
    game_sums = @games.map do |game|
      game[:away_goals] + game[:home_goals]
    end.sort
  end

 # Percentage of games that a home team has won (rounded to the nearest 100th)
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

  # Percentage of games that a visitor has won (rounded to the nearest 100th)
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
 
  # Percentage of games that has resulted in a tie (rounded to the nearest 100th)
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

  # Method count of games by season
  def count_of_games_by_season
    new_hash = Hash.new(0) 
    games.each do |game|
      new_hash[game[:season]] += 1
    end
    return new_hash
  end

  # Method of average goals per game  
  def average_goals_per_game 
    goals = 0 
    games.each do |game|
      goals += (game[:away_goals] + game[:home_goals]) 
    end
    average = (goals.to_f/(games.count.to_f)).round(2)
    return average
  end
 
  # Method average goals by season
  def average_goals_by_season
    new_hash = Hash.new(0) 
    games.each do |game|
      new_hash[game[:season]]  = season_goals(game[:season])
    end
    return new_hash
  end

  # HELPER: for average goals by season 
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

 ################## League Statisics ##################

  #Total number of teams in the data
  def count_of_teams
    @teams.count
  end

  #Team name w/ highest avg num of goals scored (per game across all seasons)
  def best_offense
    team_id_all_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do |info_line|
      team_id_all_goals[info_line[:team_id]] << info_line[:goals]
    end
    team_id_avg_goals = Hash.new { |hash, key| hash[key] = 0 }
    team_id_all_goals.each do |team_id, goals_scored|
      team_id_avg_goals[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(2)
    end
    # if 2 teams have the same avg this will return ONLY the FIRST one:
    @teams.find do |info_line|
      if info_line[:team_id] == team_id_avg_goals.key(team_id_avg_goals.values.max)
        return info_line[:team_name] 
      end
    end
  end

  #Team name w/ lowest avg num of goals scored (per game across all seasons)
  def worst_offense
    team_id_all_goals = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do |info_line|
      team_id_all_goals[info_line[:team_id]] << info_line[:goals]
    end

    team_id_avg_goals = Hash.new { |hash, key| hash[key] = 0 }
    team_id_all_goals.each do |team_id, goals_scored|
      team_id_avg_goals[team_id] = (goals_scored.sum.to_f / goals_scored.length.to_f).round(2)
    end

    # if 2 teams have the same avg this will return ONLY the FIRST one:
    @teams.find do |info_line|
      if info_line[:team_id] == team_id_avg_goals.key(team_id_avg_goals.values.min)
        return info_line[:team_name] 
      end
    end
  end

  # Name of the team with the highest average score per game across all seasons when they are away.	
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
  
  # Name of the team with the highest average score per game across all seasons when they are home. 
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

  # Name of the team with the lowest average score per game across all seasons when they are a visitor.
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

  # Name of the team with the lowest average score per game across all seasons when they are at home.
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

 ################## Season Statisics ##################

  #  WINNINGNEST/WORST COACH AND HELPER METHODS BELOW 
  def winningest_coach(season)
    raw_hash_values(season, "winning")
  end 

  def worst_coach(season)
    raw_hash_values(season, "worst")
  end

  def raw_hash_values(season, type)
    coach_games = Hash.new(0)
    coach_victories = Hash.new(0)
    total_games = determine_games(season)
    all_coaches = total_games.group_by do |game|
      game[:head_coach]
    end
    all_coaches.keys.each do |coach|
      coach_games[coach] = 0
      coach_victories[coach] = 0
  end
    games.each do |game|
      game_teams.each do |game_team|
        if game[:season] == season 
          if game_team[:game_id] == game[:game_id]
            if game_team[:result]== "LOSS"
              coach_games[game_team[:head_coach]] += 1
            elsif game_team[:result] == "TIE"
              coach_games[game_team[:head_coach]] += 1
            elsif game_team[:result] == "WIN"
              coach_victories[game_team[:head_coach]] += 1 
              coach_games[game_team[:head_coach]] += 1
            end
          end 
        end 
      end 
    end 
    sort_coach_percentages(coach_games, coach_victories, type)
  end

  def determine_games(season)
    games_in_season = games.find_all do |game| 
      game[:season] == season
    end 
    games_in_season_gameid = games_in_season.map do |game| 
      game[:game_id]
    end 
    total_relevant_games = []
    games_in_season_gameid.each do |game_id| 
      game_teams.each do |game_team|
        if game_team[:game_id] == game_id
          total_relevant_games << game_team
        end 
      end
    end
    return total_relevant_games
  end 

  def sort_coach_percentages(coach_games, coach_victories, type)
    additional_hash = {}
    coach_games.each do |key, value|
      coach_victories.each do |key_v, value_v|
        if key == key_v 
          percent = (value_v / value.to_f) 
        additional_hash[key] = percent
        end
      end
    end
    sorted_array = additional_hash.sort_by do |key, value|
      value
    end
    determine_coach(sorted_array, type)
  end 

  def determine_coach(sorted_array, type)
    if type == "winning"
      sorted_array = sorted_array.reverse
    elsif type == "worst"
      sorted_array = sorted_array
    end 
    result = sorted_array[0][0]
    return result 
  end 
  #  WINNINGNEST/WORST COACH AND HELPER METHODS ABOVE 

  #  MOST/LEAST ACCURATE TEAM METHODS BELOW
  # Name of the Team with the best ratio of shots to goals for the season
  def most_accurate_team
    #Not sure if I need this info?: 
    team_ids_array = @teams.map do |info_line|
      info_line[:team_id]
    end
    # This returns: [1, 4, 26, 14, 6, 3, 5, 17, 28, 18, 23, 16, 9, 8, 30, ... # these are team_id numbers

    game_ids_by_season = Hash.new {|hash, key| hash[key] = []}
    @games.group_by do |game| 
      game_ids_by_season[game[:season]] << game[:game_id]
    end
    # This returns: {season_id=>[game_id, 2016020207, 2016020663, 2016020917, 2016020956, 2016020598, 2016020874],
    # 20172018=>[2017020484, 2017020385, 2017020694, 2017020992, 2017020124, ...
    
    ########## NOT FINISHED!! JUST BRAINSTORMING HERE: ############
    # @game_ids_by_season.each do |game_id_array|
    #   game_id_array.each do |game_id|
    #     game_id[:game_id] 
    #     game_id[:team_id]
    #     game_id [[team_id, tackles], [team_id, tackles]]
    #   end
    # end

    # @games.each do |info_line|
    #   info_line[:game_id] == game_id
    # end

    # ratios_by_game_id = Hash.new {|hash, key| hash[key] = []}
    # @game_teams.group_by do |info_line|
    #   ratios_by_game_id[info_line[:game_id]] << (info_line[:goals].to_f / info_line[:shots]).round(2)
    # end

    # season_game_ids = games_in_season.map do |game| 
    #   game[:game_id]
    # end
      
    #PSEUDO CODE: 
    # team takes 10 shots - 9 make it, then ratio = 90% - Most accurate
    # team takes 10 shots - 2 make it, then ratio = 20% - Least accurate
    # find each game_id (with diff team_ids cuz 2 each in CSV file) in array divide goals/shots(float) 
    # take(sum) floats and divide by how many games(.count)
    # game_ids_by_season.each do |season_id|
    #   season_id.each do |game_id_array|
    # From Dani?? @game_teams.find_all {|game| season_game_ids.include?(game.game_id)}
  end

  # def least_accurate_team
  # end
  # MOST/LEAST ACCURATE TEAM METHODS ABOVE

  def most_tackles
  end

  def fewest_tackles
  end

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
# BEST AND WORST SEASON
  def best_season(team_id)
    relevant_game_teams = find_relevant_game_teams(team_id)
    relevant_games = find_relevant_games(relevant_game_teams)
    hash_seasons = group_by_season(relevant_games, relevant_game_teams) 
    season_array = order_list(hash_seasons)
    
    season_array.sort.reverse[0][1]


  end 

  def worst_season(team_id)
    relevant_game_teams = find_relevant_game_teams(team_id)
    relevant_games = find_relevant_games(relevant_game_teams)
    hash_seasons = group_by_season(relevant_games, relevant_game_teams) 
    season_array = order_list(hash_seasons)
    
    season_array.sort[0][1]

  end

  def find_relevant_game_teams(team_id)
    relevant_game_teams = game_teams.find_all do |game_team|
      game_team[:team_id] == team_id
    end
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
    return relevant_games
  end 

  def group_by_season(relevant_games, relevant_game_teams)

    new_hash = Hash.new{ |hash, key| hash[key] = [] }
    
    grouped = relevant_games.group_by do |game|
      game[:season]
    end 

    grouped.each do |key, values|
      values.each do |value|
      relevant_game_teams.each do |game_team|
          if value[:game_id] == game_team[:game_id]
            new_hash[key] << game_team[:result]
          end
        end
      end
    end
    return new_hash 
  end 

  def order_list(hash_seasons)
    season_array = []
    hash_seasons.each do |key, value|
      season_array << [(value.count("WIN").to_f/value.count.to_f), key]
    end
    return season_array

  end

  # AVERAGE WIN PERCENTAGE

  def average_win_percentage(team_id)
    relevant_games = find_relevant_game_teams(team_id)
    victories = 0 
    relevant_games.each do |game|
      if game[:result] == "WIN"
        victories += 1 
      end
    end
  
    percent = ((victories.to_f)/((relevant_games.count).to_f)).round(2) 
  end

  def most_goals_scored(team_id) 
    relevant_games = find_relevant_game_teams(team_id)
    goals = create_goals_array(relevant_games)
    return goals.max 
  end


  # MOST AND FEWEST GOALS SCORED 
  def fewest_goals_scored(team_id)
    relevant_games = find_relevant_game_teams(team_id)
    goals = create_goals_array(relevant_games)
    return goals.min 
  end 

  def create_goals_array(relevant_games)
    goals = []
    relevant_games.each do |game|
      goals << game[:goals]
    end 
    return goals 
  end

  # FAVORITE OPPONENTS

  def favorite_opponent(team_id)
    relevant_game_teams = find_relevant_game_teams(team_id)
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
    relevant_game_teams = find_relevant_game_teams(team_id)
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
