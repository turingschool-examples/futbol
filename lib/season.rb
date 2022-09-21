require 'csv'

class Season
  attr_reader :team_data,:game_teams_data
             
  def initialize(teams_data,game_teams_data)
    @teams_data = teams_data
    @game_teams_data = game_teams_data
  end

  #Method returns the name Coach with the best win percentage for the season in a string
  def winningest_coach(campaign)
    coached_games = Hash.new(0)
    coach_wins = Hash.new(0)
    
    # method returns hash: coach (key),count fo RESULT(WIN) (value)
    season_data(campaign).select do |row|
      coach_wins [row[:head_coach]] += 1 if row[:result] == "WIN"
    end
    coach_wins 

    # method return a hash: coach(key),count of games coached in a season (value)-if coach had a WIN
    season_data(campaign).select do |row|
      coached_games[row[:head_coach]] += 1 if coach_wins.has_key?(row[:head_coach])
    end
    coached_games 

    winning_coach = 
    merge_hashes_and_divide(coach_wins,coached_games).max_by do |coach,percentage| 
        percentage 
      end
      winning_coach[0]
  end

  #Coach with the worst win percentage for the season
  def worst_coach(campaign)
    coached_games = Hash.new(0)
    coach_loss_tie = Hash.new(0)
    
    # method returns 2 hash: coach (key),count fo RESULT(WIN) (value) and total games in season
    season_data(campaign).select do |row|
      coached_games[row[:head_coach]] += 1
        if row[:result] != "WIN"
          coach_loss_tie [row[:head_coach]] += 1
        end
    end
    coach_loss_tie
    coached_games 

    worst_coach =
    merge_hashes_and_divide(coach_loss_tie, coached_games).max_by do |coach,percentage| 
      percentage 
    end
    worst_coach[0]
  end

  # def coached_games_and_none_wins_count(campaign)
  #   coached_games = Hash.new(0)
  #   coach_loss_tie = Hash.new(0)

  #   season_data(campaign).select do |row|
  #     coached_games[row[:head_coach]] += 1
  #       if row[:result] != "WIN"
  #         coach_loss_tie [row[:head_coach]] += 1
  #       end
  #   end
  #   coach_loss_tie 
  #   coached_games 
  # end

  #Team with the best ratio of shots to goals for the season (goals/shots)
  def most_accurate_team(campaign)

    x = (team_accuracy(campaign).max_by do |coach,percentage| 
      # require 'pry';binding.pry
      percentage end)

    team_name_from_team_id(x)

  end

  #Team with the worst ratio of shots to goals for the season
  def least_accurate_team_for(campaign)
      # team_name_from_team_id(team_accuracy(campaign).min_by do |coach,percentage| 
      #   percentage end)
    
      analysis = minimum_success_rate_for(team_accuracy(campaign))

      team_name_from_team_id(analysis)
    end

  def team_accuracy(campaign)
    season_goals = Hash.new(0)
    team_shots = Hash.new(0)

    season_data(campaign).select do |row|
      season_goals[row[:team_id]] += row[:goals].to_i
      team_shots[row[:team_id]] += row[:shots].to_i
    end
    season_goals
    team_shots

    merge_hashes_and_divide(season_goals,team_shots)
  end

  def merge_hashes_and_divide(objective, attempts)
    efficiency = Hash.new

    efficiency.update(objective,attempts) do |team,goal,attempts|
      goal.fdiv(attempts).round(4)
    end
    efficiency
  end

  def minimum_success_rate_for(data)
    data.min_by { |team,percentage| percentage }
  end

  #Team with the most tackles in the season
  def most_tackles(campaign)
    team_tackle = team_tackles_calculation(campaign).max_by { |team,percentage| percentage }

    team_name_from_team_id(team_tackle)
  end

  #Team with the fewest tackles in the season
  def fewest_tackles(campaign)
    team_tackle = team_tackles_calculation(campaign).min_by { |team,percentage| percentage }
    
    team_name_from_team_id(team_tackle)
  end

  def team_tackles_calculation(campaign)
    team_total_tackles = Hash.new(0)
      
    season_data(campaign).select do |row|
      tackles = row[:tackles].to_i
      team_total_tackles[row[:team_id]] += tackles
    end
    team_total_tackles
  end

  # helper method from Darby - team_id used to find team name
  def team_name_from_team_id(data)
    @teams_data.find do |row|
      if data[0] == row[:team_id]
        return row[:teamname]
      end
    end
  end

  #collects all rows within the given campaign
  def season_data(campaign)
    season = Set.new
    @game_teams_data.select do |row|      
      row.select do |game_id|
        season << row if campaign.scan(/.{4}/).shift == row[:game_id].scan(/.{4}/).shift
      end
    end
    season 
  end
end