require 'CSV'

class StatTracker
  attr_reader :games,
              :teams, 
              :game_teams,
              :game_id
       
  def initialize(locations)
    @games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    # @total_score_array = total_score
    # @games_by_season = count_of_games_by_season
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
   
  def total_score
    total_score_array = []
    @games.each do |row|
      total_score_array << row[:away_goals].to_i + row[:home_goals].to_i
    end
    total_score_array
  end

  def highest_total_score
    total_score_array = total_score
    total_score_array.max
  end

  def lowest_total_score
    total_score_array = total_score
    total_score_array.min
  end

  def percentage_home_wins
    count = @games.count do |row|
      row[:home_goals].to_i > row[:away_goals].to_i
    end
    (count.to_f / @games.size).round(2)
  end

  def percentage_visitor_wins
    count = @games.count do |row|
      row[:away_goals].to_i > row[:home_goals].to_i
    end
    (count.to_f / @games.size).round(2)
  end

  def percentage_ties
    count = @games.count do |row|
      row[:away_goals].to_i == row[:home_goals].to_i
    end
    (count.to_f / @games.size).round(2)
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)
    @games.each do |row|
      games_by_season[row[:season]] += 1
    end
    games_by_season
  end

  def average_goals_per_game
    total_score_array = total_score
    (total_score_array.sum.to_f/@games.size).round(2)
  end

  def average_goals_by_season
    goals_by_season = Hash.new(0)
    @games.each do |row|
      numerator = (row[:away_goals].to_i + row[:home_goals].to_i)
      goals_by_season[row[:season]] += numerator
    end

    games_by_season = count_of_games_by_season
    games_by_season.each do |key, value|
      denominator = value
      numerator = goals_by_season[key]
      goals_by_season[key] = (numerator/denominator.to_f).round(2)
    end
    goals_by_season
  end
  
  def game_ids_for_season(season)
    season_game_ids = []
    @games.each do |row|
      season_game_ids << row[:game_id] if row[:season] == season
    end
    season_game_ids
  end

  def winningest_coach(season)
    season_game_ids = game_ids_for_season(season)
  
    season_team_wins = Hash.new(0)
    season_winners_games_played = Hash.new(0)
    @game_teams.each do |row|
      if season_game_ids.include?(row[:game_id]) && row[:result] == 'WIN'
        season_team_wins[row[:head_coach]] += 1
      end
      if season_game_ids.include?(row[:game_id])
        season_winners_games_played[row[:head_coach]] += 1
      end
    end

    season_record = Hash.new(0)
    season_team_wins.each do |head_coach, wins|
      season_record[head_coach] = (wins.to_f / season_winners_games_played[head_coach])
    end

    season_winningest_team = season_record.max_by {|k, v| v}

    winningest_coach = season_winningest_team[0]
  end  

  def worst_coach(season)
    season_game_ids = game_ids_for_season(season)
  
    season_team_losses = Hash.new(0)
    season_losers_games_played = Hash.new(0)
    @game_teams.each do |row|
      if season_game_ids.include?(row[:game_id]) && (row[:result] == 'LOSS' || row[:result] == 'TIE')
        season_team_losses[row[:head_coach]] += 1
      end
      if season_game_ids.include?(row[:game_id])
        season_losers_games_played[row[:head_coach]] += 1
      end
    end

    season_record = Hash.new(0)
    season_team_losses.each do |head_coach, losses|
      season_record[head_coach] = (losses.to_f / season_losers_games_played[head_coach])
    end

    season_worst_team = season_record.max_by {|k, v| v}

    worst_coach = season_worst_team[0]
  end  

  def season_total_tackles(season)
    season_game_ids = game_ids_for_season(season)
    season_tackles_by_team = Hash.new(0)
    @game_teams.each do |row|
      season_tackles_by_team[row[:team_id]] += row[:tackles].to_i if season_game_ids.include?(row[:game_id])
    end
    season_tackles_by_team
  end

  def most_tackles(season)
    season_tackles_by_team = season_total_tackles(season)
    
    most_tackles = season_tackles_by_team.max_by {|k, v| v}

    most_tackles_team = nil
    @teams.each do |row|
      most_tackles_team = row[:teamname] if row[:team_id] == most_tackles.first
    end
    most_tackles_team
  end

  def fewest_tackles(season)
    season_tackles_by_team = season_total_tackles(season)

    fewest_tackles = season_tackles_by_team.min_by {|k, v| v}

    fewest_tackles_team = nil
    @teams.each do |row|
      fewest_tackles_team = row[:teamname] if row[:team_id] == fewest_tackles.first
    end
    fewest_tackles_team
  end

  def most_accurate_team(season)
    #get game_ids for the season
    game_ids = []
    @games.each do |row|
      game_ids << row[:game_id] if row[:season] == season
    end
    
    #get team_id => season shots(numerator)
    team_shots_by_season = Hash.new(0)
    @game_teams.each do |row|
      if game_ids.include?(row[:game_id])
        team_shots_by_season[row[:team_id]] += row[:shots].to_i
      end
        team_shots_by_season
    end

    #get team_id => season goals (denominator)
    team_goals_by_season = Hash.new(0)
    @game_teams.each do |row|
      #season_team_goals.each_key do |key|
        if game_ids.include?(row[:game_id])
          team_goals_by_season[row[:team_id]] += row[:goals].to_i
        end
        team_goals_by_season
    end

    #calculate ratio and choose smallest ratio
    shots_to_goal_ratio_by_team = Hash.new(0)
      team_shots_by_season.each do |key1, value1|
        team_goals_by_season.each do |key2, value2|
          if key1 == key2
            shots_to_goal_ratio_by_team[key1] = (value1 / value2.to_f).round(2)
          end
        end
      end
      shots_to_goal_ratio_by_team
        
    best_shots_to_goal_ratio = shots_to_goal_ratio_by_team.min_by {|k, v| v}
    
    most_accurate_team = nil
    @teams.each do |row|
      most_accurate_team = row[:teamname] if row[:team_id] == best_shots_to_goal_ratio[0]
    end
    most_accurate_team
  end

  def least_accurate_team(season)
    #get game_ids for the season
    game_ids = []
    @games.each do |row|
      game_ids << row[:game_id] if row[:season] == season
    end
    
    #get team_id => season shots(numerator)
    team_shots_by_season = Hash.new(0)
    @game_teams.each do |row|
      if game_ids.include?(row[:game_id])
        team_shots_by_season[row[:team_id]] += row[:shots].to_i
      end
        team_shots_by_season
    end

    #get team_id => season goals (denominator)
    team_goals_by_season = Hash.new(0)
    @game_teams.each do |row|
      #season_team_goals.each_key do |key|
        if game_ids.include?(row[:game_id])
          team_goals_by_season[row[:team_id]] += row[:goals].to_i
        end
        team_goals_by_season
    end

    #calculate ratio and choose smallest ratio
    shots_to_goal_ratio_by_team = Hash.new(0)
      team_shots_by_season.each do |key1, value1|
        team_goals_by_season.each do |key2, value2|
          if key1 == key2
            shots_to_goal_ratio_by_team[key1] = (value1 / value2.to_f).round(3)
          end
        end
      end
    shots_to_goal_ratio_by_team
    
    highest_shots_to_goal_ratio = shots_to_goal_ratio_by_team.max_by {|k, v| v}
    
    least_accurate_team = nil
    @teams.each do |row|
      least_accurate_team = row[:teamname] if row[:team_id] == highest_shots_to_goal_ratio[0]
    end
    least_accurate_team
  end
end