require 'csv'

class StatTracker

  attr_reader :game_path, :team_path, :game_teams_path

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
    @game_csv = CSV.read(@game_path, headers: true, header_converters: :symbol)
    @team_csv = CSV.read(@team_path, headers: true, header_converters: :symbol)
    @game_teams_csv = CSV.read(@game_teams_path, headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    StatTracker.new(locations[:games], locations[:teams], locations[:game_teams])
  end

  def list_team_ids
    @team_csv.map { |row| row[:team_id] }
  end

  def list_team_names_by_id(id)
    @team_csv.each { |row| return row[:teamname] if id.to_s == row[:team_id] }
  end

  def highest_total_score
    @game_csv.map { |row| row[:away_goals].to_i + row[:home_goals].to_i }.max
  end

  def lowest_total_score
    @game_csv.map { |row| row[:away_goals].to_i + row[:home_goals].to_i }.min
  end

  def count_of_teams
    @team_csv.count { |row| row[:team_id] }
  end
     
  def percentage_home_wins
    home_wins = 0
    total_wins = 0
    @game_csv.each do |row|
      home_wins += 1 if row[:home_goals].to_f > row[:away_goals].to_f
      total_wins += 1
    end
    return (home_wins.to_f/total_wins.to_f).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    total_wins = 0
    @game_csv.each do |row|
      visitor_wins += 1 if row[:home_goals].to_f < row[:away_goals].to_f
      total_wins += 1
    end
    return (visitor_wins.to_f/total_wins.to_f).round(2)
  end

  def percentage_ties
    ties = 0
    total_wins = 0
    @game_csv.each do |row|
      ties += 1 if row[:home_goals].to_f == row[:away_goals].to_f
      total_wins += 1
    end
    return (ties.to_f/total_wins.to_f).round(2)
  end

  def count_of_games_by_season
    seasons_with_games = Hash.new(0)
    @game_csv.each do |row|
      seasons_with_games[row[:season]] += 1
    end
    seasons_with_games
  end

  def average_goals_per_game
    total_games = 0
    average = 0
    total_goals = 0
    @game_csv.each do |row|
     total_goals += row[:home_goals].to_i + row[:away_goals].to_i
      total_games += 1
      average = (total_goals.to_f/total_games.to_f).round(2)
    end
    average
  end

  def average_goals_by_season
    seasons_with_games = Hash.new(0)
    @game_csv.each do |row|
      seasons_with_games[row[:season]] += (row[:away_goals].to_f + row[:home_goals].to_f)
    end
    seasons_averages = Hash.new(0)
    seasons_with_games.map do |season_id, total_games|
      seasons_averages[season_id] = (total_games/self.count_of_games_by_season[season_id]).round(2)
    end
   p seasons_averages

  end  

  #Name of the team with the highest average number of goals scored per game across all seasons.
  def best_offense
    team_offense = Hash.new(0)
    games_played = Hash.new(0)
    @game_teams_csv.each do |row|
      team_offense[row[:team_id]] += row[:goals].to_f
      games_played[row[:team_id]] += 1
    end
    best_offense_team = Hash.new
    best_offense_team = team_offense.merge(games_played) { |team, goals, games_played| goals/games_played }
    teamid = best_offense_team.max_by { |team, percent| percent }.first
    @team_csv.each do |row|
      return row[:teamname] if row[:team_id] == teamid
     end
  end
  
#Name of the team with the lowest average number of goals scored per game across all seasons.
  def worst_offense
    team_offense = Hash.new(0)
    games_played = Hash.new(0)
    @game_teams_csv.each do |row|
      team_offense[row[:team_id]] += row[:goals].to_f
      games_played[row[:team_id]] += 1
    end
    worst_offense_team = Hash.new
    worst_offense_team = team_offense.merge(games_played) { |team, goals, games_played| goals/games_played }
    teamid = worst_offense_team.min_by { |_, percent| percent }.first
    @team_csv.each do |row|
      return row[:teamname] if row[:team_id] == teamid
     end
   end
   
  #Name of the team with the lowest average number of goals scored per game across all seasons. FC Dallas
   def highest_scoring_visitor
     team_offense = Hash.new(0)
     games = Hash.new(0)
     @game_csv.each do |row|
       team_offense[row[:away_team_id]] += row[:away_goals].to_f
       games[row[:away_team_id]] += 1
     end
     highest_scoring_visitor = Hash.new
     highest_scoring_visitor = team_offense.merge(games) { |team, away_goals, games| away_goals/games }
     teamid = highest_scoring_visitor.max_by { |_, percent| percent }.first
     @team_csv.each do |row|
       return row[:teamname] if row[:team_id] == teamid
      end
    end
    
    # returns the highest_scoring_home_team'
    def highest_scoring_home_team
      team_offense = Hash.new(0)
      games = Hash.new(0)
      @game_csv.each do |row|
        team_offense[row[:home_team_id]] += row[:home_goals].to_f
        games[row[:home_team_id]] += 1
      end
      highest_scoring_home_team = Hash.new
      highest_scoring_home_team = team_offense.merge(games) { |team,home_goals, games| home_goals/games }
      teamid = highest_scoring_home_team.max_by { |_, percent| percent }.first
      @team_csv.each do |row|
        return row[:teamname] if row[:team_id] == teamid
       end
     end
     
    #returns the lowest_scoring_visitor
    def lowest_scoring_visitor
      team_offense = Hash.new(0)
      games = Hash.new(0)
      @game_csv.each do |row|
        team_offense[row[:away_team_id]] += row[:away_goals].to_f
        games[row[:away_team_id]] += 1
      end
      lowest_scoring_visitor = Hash.new
      lowest_scoring_visitor = team_offense.merge(games) { |team, away_goals, games| away_goals/games }
      teamid = lowest_scoring_visitor.min_by { |_, percent| percent }.first
      @team_csv.each do |row|
        return row[:teamname] if row[:team_id] == teamid
       end
     end

    #returns the lowest_scoring_home_team
    def lowest_scoring_home_team
      team_offense = Hash.new(0)
      games = Hash.new(0)
      @game_csv.each do |row|
        team_offense[row[:home_team_id]] += row[:home_goals].to_f
        games[row[:home_team_id]] += 1
      end
      lowest_scoring_home_team = Hash.new
      lowest_scoring_home_team = team_offense.merge(games) { |team,home_goals, games| home_goals/games }
      teamid = lowest_scoring_home_team.min_by { |_, percent| percent }.first
      @team_csv.each do |row|
        return row[:teamname] if row[:team_id] == teamid
       end
     end

  def winningest_coach(season)
    coach_records = Hash.new { |coach, outcomes| coach[outcomes]=[] }
    @game_teams_csv.each do |row|
      if row[:game_id].start_with?(season[0..3])
        coach_records[row[:head_coach]].push(row[:result])
      end
    end
    winning_percent = Hash.new
    coach_records.each do |coach, outcomes|
      # winning_percent[coach] = ((outcomes.count("WIN").to_f+0.5*outcomes.count("TIE"))/(outcomes.count))
      # ties don't count in spec_harness??
      winning_percent[coach] = ((outcomes.count("WIN").to_f)/(outcomes.count))
    end
    winning_percent.max_by { |_, percent| percent }.first
  end

  def team_info(id)
    team_hash = Hash.new(0)

    @team_csv.each { |row| 
      if row[:team_id] == id
        team_hash['team_id'] = row[:team_id]
        team_hash['franchise_id'] = row[:franchiseid]
        team_hash['team_name'] = row[:teamname]
        team_hash['abbreviation'] = row[:abbreviation]
        team_hash['link'] = row[:link]
      end
    }
    
    return team_hash
  end

  def best_season(id)
    team_seasons = Hash.new(0)
    @game_teams_csv.each do |row| 
      if row[:team_id] == id
        if row[:result] == "WIN"
          season = @game_csv.find { |game| game[:game_id] == row[:game_id] }
          team_seasons[season[:season]] += 1
        end
      end
    end
    team_seasons.key(team_seasons.values.max)
  end

  def worst_season(id)
    team_seasons = Hash.new(0)
    @game_teams_csv.each do |row| 
      if row[:team_id] == id
        if row[:result] == "WIN" 
          season = @game_csv.find { |game| game[:game_id] == row[:game_id] }
          team_seasons[season[:season]] += 1
        end
      end
    end
    team_seasons.key(team_seasons.values.min)
  end

  def average_win_percentage(id)
    total_games = 0
    total_wins = 0 
    
    @game_teams_csv.each do |row|
      if row[:team_id] == id 
        total_wins += 1 if row[:result] == "WIN"
        total_games += 1
      end
    end
    
    return (total_wins.to_f / total_games.to_f).round(2)
  end

  def most_goals_scored(id)
    highest_score = 0 
    @game_teams_csv.each do |row|
      if row[:team_id] == id 
        highest_score = row[:goals].to_i if row[:goals].to_i > highest_score
      end
    end
    return highest_score
  end

  def fewest_goals_scored(id)
    lowest_score = self.most_goals_scored(id)
    @game_teams_csv.each do |row|
      if row[:team_id] == id 
        lowest_score = row[:goals].to_i if row[:goals].to_i < lowest_score
      end
    end
    return lowest_score
  end

  # this can be refactored alongside winningest_coach
  def worst_coach(season)
    coach_records = Hash.new { |coach, outcomes| coach[outcomes]=[] }
    @game_teams_csv.each do |row|
      if row[:game_id].start_with?(season[0..3])
        coach_records[row[:head_coach]].push(row[:result])
      end
    end
    winning_percent = Hash.new
    coach_records.each do |coach, outcomes|
      # winning_percent[coach] = ((outcomes.count("WIN").to_f+0.5*outcomes.count("TIE"))/(outcomes.count))
      # ties don't count in spec_harness??
      winning_percent[coach] = ((outcomes.count("WIN").to_f)/(outcomes.count))
    end
    winning_percent.min_by { |_, percent| percent }.first
  end

  def most_accurate_team(season)
    team_goals = Hash.new { |team, goals| team[goals]=[] }
    team_shots = Hash.new { |team, shots| team[shots]=[] }
    team_accuracy = Hash.new
    @game_teams_csv.each do |row|
      if row[:game_id].start_with?(season[0..3])
        team_goals[row[:team_id]].push(row[:goals].to_f)
        team_shots[row[:team_id]].push(row[:shots].to_f)
      end
    end
    goals_sum = team_goals.transform_values(&:sum)
    shot_sum = team_shots.transform_values(&:sum)
    team_accuracy = goals_sum.merge(shot_sum) { |team, goals, shots | goals/shots }
    teamid = team_accuracy.max_by { |_, percent| percent }.first
    @team_csv.each do |row|
      return row[:teamname] if row[:team_id] == teamid
    end
  end

  def least_accurate_team(season)
    team_goals = Hash.new { |team, goals| team[goals]=[] }
    team_shots = Hash.new { |team, shots| team[shots]=[] }
    team_accuracy = Hash.new
    @game_teams_csv.each do |row|
      if row[:game_id].start_with?(season[0..3])
        team_goals[row[:team_id]].push(row[:goals].to_f)
        team_shots[row[:team_id]].push(row[:shots].to_f)
      end
    end
    goals_sum = team_goals.transform_values(&:sum)
    shot_sum = team_shots.transform_values(&:sum)
    team_accuracy = goals_sum.merge(shot_sum) { |team, goals, shots | goals/shots }
    teamid = team_accuracy.min_by { |_, percent| percent }.first
    @team_csv.each do |row|
      return row[:teamname] if row[:team_id] == teamid
    end
  end 

  def most_tackles(season)
    tackle_records = Hash.new(0)
    @game_teams_csv.each do |row|
      if row[:game_id].start_with?(season[0..3])
        tackle_records[row[:team_id]] += row[:tackles].to_i
      end
    end
    teamid = tackle_records.max_by { |_, tackles| tackles }.first
    @team_csv.each do |row|
      return row[:teamname] if row[:team_id] == teamid
    end
  end

  def fewest_tackles(season)
    tackle_records = Hash.new(0)
    @game_teams_csv.each do |row|
      if row[:game_id].start_with?(season[0..3])
        tackle_records[row[:team_id]] += row[:tackles].to_i
      end
    end
    teamid = tackle_records.min_by { |_, tackles| tackles }.first
    @team_csv.each do |row|
      return row[:teamname] if row[:team_id] == teamid
    end
  end

  def favorite_opponent(id) 
    games_played = []
    @game_teams_csv.each do |row|
      if row[:team_id] == id 
        games_played << row[:game_id]
      end
    end

    opponent_history = Hash.new {|h, k| h[k] = {"wins"=>0, "losses"=>0, "ties"=>0, "total games played" => 0}}

    @game_teams_csv.each do |row| 

      if games_played.include?(row[:game_id])

        if row[:team_id] != id 
          
          if row[:result] == "WIN"
            opponent_history[row[:team_id]]["wins"] += 1
          end
      
          if row[:result] == "LOSS"
            opponent_history[row[:team_id]]["losses"] += 1
          end

          if row[:result] == "TIE"
            opponent_history[row[:team_id]]["ties"] += 1
          end

          opponent_history[row[:team_id]]["total games played"] += 1

        end
      end
    end

    winless_opponents = Hash.new {|h, k| h[k] = 0}

    win_ratios_against_opponents = Hash.new {|h, k| h[k] = 0.0}  

    opponent_history.each do |team_id, opponent_results| 
      if opponent_results["wins"] == 0 && opponent_results["losses"] > 0
        winless_opponents[team_id] += 1
      else 
        win_ratios_against_opponents[team_id] = opponent_results["losses"].to_f / opponent_results["wins"].to_f
      end
    end 
    
    opponent_history.each do |k, v| 
      print @team_csv.find {|row| row[:team_id] == k}[:teamname]
      v.each do |k2, v2| 
        print " #{k2} = #{v2} "
      end
      puts "\n\n"
    end

    puts "\n\n\n"

    win_ratios_against_opponents.each do |k, v| 
      print @team_csv.find {|row| row[:team_id] == k}[:teamname]
      print " : #{v}"
      puts "\n\n"
    end

    if winless_opponents.length > 0
      sorted_winless_opponents = winless_opponents.sort_by {|k, v| v}
      favorite_id = sorted_winless_opponents.first[0]
      return @team_csv.find {|row| row[:team_id] == favorite_id}[:teamname]
    else  
      sorted_opponents = win_ratios_against_opponents.sort_by {|k, v| v} 
      favorite_id = sorted_winless_opponents.first[0]
      return @team_csv.find {|row| row[:team_id] == favorite_id}[:teamname]
    end
  end


















  def rival(id) 
    games_played = []
    @game_teams_csv.each do |row|
      if row[:team_id] == id 
        games_played << row[:game_id]
      end
    end

    opponent_history = Hash.new {|h, k| h[k] = {"wins"=>0, "losses"=>0, "ties"=>0, "total games played" => 0}}

    @game_teams_csv.each do |row| 

      if games_played.include?(row[:game_id])

        if row[:team_id] != id 
          
          if row[:result] == "WIN"
            opponent_history[row[:team_id]]["wins"] += 1
          end
      
          if row[:result] == "LOSS"
            opponent_history[row[:team_id]]["losses"] += 1
          end

          if row[:result] == "TIE"
            opponent_history[row[:team_id]]["ties"] += 1
          end

          opponent_history[row[:team_id]]["total games played"] += 1

        end
      end
    end

    winless_opponents = Hash.new {|h, k| h[k] = 0}

    win_ratios_against_opponents = Hash.new {|h, k| h[k] = 0.0}  

    opponent_history.each do |team_id, opponent_results| 
      if opponent_results["losses"] == 0 && opponent_results["wins"] > 0
        winless_opponents[team_id] += 1
      else 
        win_ratios_against_opponents[team_id] = opponent_results["wins"].to_f / opponent_results["total games played"].to_f
      end
    end 
    
    opponent_history.each do |k, v| 
      print @team_csv.find {|row| row[:team_id] == k}[:teamname]
      v.each do |k2, v2| 
        print " #{k2} = #{v2} "
      end
      puts "\n\n"
    end

    puts "\n\n\n"

    win_ratios_against_opponents.each do |k, v| 
      print @team_csv.find {|row| row[:team_id] == k}[:teamname]
      print " : #{v}"
      puts "\n\n"
    end

    if winless_opponents.length > 0
      sorted_winless_opponents = winless_opponents.sort_by {|k, v| v}
      favorite_id = sorted_winless_opponents.last[0]
      return @team_csv.find {|row| row[:team_id] == favorite_id}[:teamname]
    else  
      sorted_opponents = win_ratios_against_opponents.sort_by {|k, v| v} 
      favorite_id = sorted_opponents.last[0]
      return @team_csv.find {|row| row[:team_id] == favorite_id}[:teamname]
    end
  end
end
