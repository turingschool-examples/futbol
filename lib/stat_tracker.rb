require 'csv'

class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data
  def initialize(locations)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  
  end
  
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end.max
  end

  def lowest_total_score
    @games_data.map do |row| 
    row[:away_goals].to_i + row[:home_goals].to_i
    end.min
  end

  def percentage_home_wins
    wins =0
    @games_data.each do |row| 
      if row[:away_goals].to_i < row[:home_goals].to_i
        wins += 1
      end
    end
    (wins.to_f/games_data.count).round(2)
  end

  def percentage_visitor_wins
    wins =0
    @games_data.each do |row| 
      if row[:away_goals].to_i > row[:home_goals].to_i
        wins += 1
      end
    end
    (wins.to_f/games_data.count).round(2)
  end

  def percentage_ties
    ties =0 
    @games_data.each do |row| 
      if row[:away_goals].to_i == row[:home_goals].to_i
        ties += 1
      end
    end
    (ties.to_f/games_data.count).round(2)
  end











































#GameClass



































































































  #LeagueClass


































































































#end
  #SeasonClass


  #Method returns the name Coach with the best win percentage for the season in a string
  def winningest_coach(campaign)
    
    coached_games_in_season = Hash.new(0)
    coach_wins_in_season = Hash.new(0)
    game_results_percentage = Hash.new
    season = Set.new

    #collects all rows within the given campaign
    @game_teams_data.each do |row|      
      row.find_all do |game_id|
        if campaign.scan(/.{4}/).shift == row[:game_id].scan(/.{4}/).shift
          season << row
        end
      end
    end
    season
    
    #method returns hash: coach (key), count fo RESULT(WIN) (value)
    season.select do |row|
      if row[:result] == "WIN"
        coach_wins_in_season [row[:head_coach]] += 1
      end
    end
    coach_wins_in_season 


    #method return a hash: coach(key), count of games coached in a season (value)-if coach had a WIN
      season.find_all do |row|
        if coach_wins_in_season.has_key?(row[:head_coach])
          coached_games_in_season[row[:head_coach]] += 1
        end
      end
        coached_games_in_season 

    #method merges the wins and coached games hashes for comparison
        game_results_percentage.update(coached_games_in_season,coach_wins_in_season) do |coach, games_coached, games_won| 
            (games_won.fdiv(games_coached)).round(4)
        end
       winning_coach = game_results_percentage.max_by do |coach, percentage| 
          percentage 
        end
        winning_coach[0]
  end

  #Coach with the worst win percentage for the season
  def worst_coach(campaign)

    coached_games_in_season = Hash.new(0)
    coach_wins_in_season = Hash.new(0)
    game_results_percentage = Hash.new
    season = Set.new

    #collects all rows within the given campaign
    @game_teams_data.each do |row|      
      row.find_all do |game_id|
        if campaign.scan(/.{4}/).shift == row[:game_id].scan(/.{4}/).shift
          season << row
        end
      end
    end
    season
    
    #method returns hash: coach (key), count fo RESULT(WIN) (value)
    season.select do |row|
      if row[:result] != "WIN"
        coach_wins_in_season [row[:head_coach]] += 1
      end
    end
    coach_wins_in_season 


    #method return a hash: coach(key), count of games coached in a season (value)-if coach had a WIN
      season.find_all do |row|
        # if coach_wins_in_season.has_key?(row[:head_coach])
          coached_games_in_season[row[:head_coach]] += 1
        # end
      end
        coached_games_in_season 

    #method merges the wins and coached games hashes for comparison
        game_results_percentage.update(coached_games_in_season,coach_wins_in_season) do |coach, games_coached, games_won| 
            (games_won.fdiv(games_coached)).round(4)
        end
        worst_coach = game_results_percentage.max_by do |coach, percentage| 
          percentage 
          # require 'pry';binding.pry
        end
        worst_coach[0]
  end

  #Team with the best ratio of shots to goals for the season (goals/shots)
  def most_accurate_team(campaign)
    # campaign = "20142015"
    season = Set.new
    team_season_goals_count = Hash.new(0)
    team_season_shots_count = Hash.new(0)
    shot_efficiency = Hash.new

    #collects all rows within the given campaign
    @game_teams_data.each do |row|      
      row.find_all do |game_id|
        if campaign.scan(/.{4}/).shift == row[:game_id].scan(/.{4}/).shift
          season << row
        end
      end
    end
    season

    #hash with team (key) and goals (value) in given season
    season.each do |row|
      goals = row[:goals].to_i
      shots = row[:shots].to_i

      team_season_goals_count[row[:team_id]] += goals
      team_season_shots_count[row[:team_id]] += shots
    end
    team_season_goals_count
    team_season_shots_count

    #merge shots, goal hashes; calculate team efficiecy; return team neame
    shot_efficiency.update(team_season_goals_count,team_season_shots_count) do |team, goals_made, shots_taken|
      goals_made.fdiv(shots_taken).round(4)
    end
    team_efficiency = shot_efficiency.max_by do |coach, percentage| 
      percentage end

      team_name_from_id_average(team_efficiency)
  end

  def least_accurate_team	(campaign)
    # campaign = "20142015"
    season = Set.new
    team_season_goals_count = Hash.new(0)
    team_season_shots_count = Hash.new(0)
    shot_efficiency = Hash.new

    #collects all rows within the given campaign
    @game_teams_data.each do |row|      
      row.find_all do |game_id|
        if campaign.scan(/.{4}/).shift == row[:game_id].scan(/.{4}/).shift
          season << row
        end
      end
    end
    season

    #hash with team (key) and goals (value) in given season
    season.each do |row|
      goals = row[:goals].to_i
      shots = row[:shots].to_i

      team_season_goals_count[row[:team_id]] += goals
      team_season_shots_count[row[:team_id]] += shots
    end
    team_season_goals_count
    team_season_shots_count

    #merge shots, goal hashes; calculate team efficiecy; return team neame
    shot_efficiency.update(team_season_goals_count,team_season_shots_count) do |team, goals_made, shots_taken|
      goals_made.fdiv(shots_taken).round(4)
    end
    team_efficiency = shot_efficiency.min_by do |coach, percentage| 
      percentage end

      team_name_from_id_average(team_efficiency)
  end

  #helper method from Darby - team_id used to find team name
  def team_name_from_id_average(data)
    @teams_data.each do |row|
      if data[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end
    
  #method creates hash-season(key) and all games_id(values) in string
  def season_all_game_id
  season_games = {}
    @games_data.flat_map do |row|
        if season_games.include?(row[:season])
          season_games[row[:season]].push(row[:game_id])
        else #!season_games.include?(row[:season])
          season_games[row[:season]] = [row[:game_id]]
        end
    end
    season_games
  end

  #method returns a hash: game_id(key) = [team_id (away), team_id (home)]
  def game_match_up
    game_ids = {}
    @game_teams_data.each do |row|
      if game_ids.include?(row[:game_id])
        game_ids[row[:game_id]].push(row[:team_id])
      else #!game_ids.include?(row[:season])
        game_ids[row[:game_id]] = [row[:team_id]]
      end
    end
    game_ids
  end

  #method returns hash: game_id(key) coaches for those games(values)
  def coaches_for_each_game
    coach_games = Hash.new
    @game_teams_data.each do |row|
          if coach_games.include?(row[:game_id])
            coach_games[row[:game_id]].push(row[:head_coach])
          else# !coach_games.include?(row[:season])
            coach_games[row[:game_id]] = [row[:head_coach]]
          end
    end
        coach_games
  end
end