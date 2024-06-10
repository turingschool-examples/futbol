require 'csv'

class SeasonStats 
  attr_reader :game_teams_data,
              :team_data,
              :game_data

  def initialize(game_teams_data, team_data, game_data)
    @game_teams_data = game_teams_data
    @team_data = team_data
    @game_data = game_data
  end

  def current_season_data(season_id)
    # seasonal_games returns an Array of games for the selected season
    seasonal_games = @game_data.select do |game|
      game.season == season_id
    end
    # seasonal_game_ids returns an Array of game id's for the selected season
    seasonal_game_ids = []
    seasonal_games.each do |game|
      seasonal_game_ids << game.game_id
    end
    # seasonal_game_teams returns an Array of game_teams that match the selected season
    seasonal_game_teams = @game_teams_data.select do |game_teams|
      seasonal_game_ids.include?(game_teams.game_id)
    end
    seasonal_game_teams
  end

  #  build_coach_win_loss is a helper method for winningest_coach and worst_coach
  #   build_coach_win_loss returns an array of hashes. In each hash the coach is the key and 
  #  the values are an array of strings: [{"John Tortorella" => ["WIN", "LOSS"]}]
  def build_coach_win_loss(seasonal_game_teams)
    coaches_wl = {}
    seasonal_game_teams.each do |seasonal_game_team|
      if !coaches_wl.keys.include?(seasonal_game_team.head_coach)
        coaches_wl[seasonal_game_team.head_coach] = [seasonal_game_team.result]
      else
        coaches_wl[seasonal_game_team.head_coach] << seasonal_game_team.result
      end      
    end
     coaches_wl
  end
 
  # coach_win_loss_calc is a helper method for win_loss_calc
  # coach_win_loss_calc returns a hash where the coach name is the key and the value is the coach's
  #  win/loss ratio: {"John Tortorella"=>37, "Claude Julien"=>54, "Dan Bylsma"=>52}
  def coach_win_loss_calc(coach_win_loss)
    coaches_win_loss_ratio = {}
    coach_win_loss.map do |coach, wl|
      wins = 0
      total_games = wl.length
      wl.each do |x|
        wins += 1 if x == "WIN"
      end
      wl_ratio = (wins.to_f / total_games * 100).round(0)
      coaches_win_loss_ratio[coach] = wl_ratio
    end
    coaches_win_loss_ratio
  end

    # win_loss_calc is a helper method for winningest_coach/worst_coach
    # return value is a string of the coach's name: "John Tortorella"
  def win_loss_calc(coach_win_loss, winner)
    coaches_win_loss = coach_win_loss_calc(coach_win_loss)
    if winner == true
      coaches_win_loss.max_by{|key,value|value}[0]
    else 
      coaches_win_loss.min_by{|key,value|value}[0]
    end  
  end

  def winningest_coach(season_id)
    seasonal_games = current_season_data(season_id)
    win_loss_calc(build_coach_win_loss(seasonal_games), true)
  end 

  def worst_coach(season_id)
    seasonal_games = current_season_data(season_id)
    win_loss_calc(build_coach_win_loss(seasonal_games), false)
  end

  def id_to_team_name(team_id)
    team = @team_data.select do |team|
      team.team_id == team_id
    end
    team.uniq[0].team_name
  end
  
  # calculate_accuracy is a helper method for get team name
  def calculate_accuracy(teams_accuracy, accurate)
    accuracy = {}
    teams_accuracy.each do |team_accuracy|
      # binding.pry
      acc = (team_accuracy[1][:goals].to_f / team_accuracy[1][:shots]) * 100
      accuracy[team_accuracy[0]] = "#{acc.round(2)}%"
    end
    if accurate == true
      id_to_team_name(accuracy.max_by{|key,value|value}[0])
    else 
      id_to_team_name(accuracy.min_by{|key,value|value}[0])
    end  
  end

  # get_team_name is a helper method for most_accurate_team and least_accurate_team
  # returns a string with the team name: "DC United"
  def get_team_name(seasonal_game_teams, accurate)
    teams_accuracy = Hash.new {|hash, key| hash[key] = Hash.new}
    seasonal_game_teams.each do |game|
      if !teams_accuracy.include?(game.team_id)
        teams_accuracy[game.team_id][:goals] = game.goals.to_i
        teams_accuracy[game.team_id][:shots] = game.shots.to_i
      else
        teams_accuracy[game.team_id][:goals] += game.goals.to_i
        teams_accuracy[game.team_id][:shots] += game.shots.to_i
      end
    end
    # binding.pry
    calculate_accuracy(teams_accuracy, accurate)
  end

  def most_accurate_team(season_id)
    seasonal_game_teams = current_season_data(season_id)
    get_team_name(seasonal_game_teams, true)
  end

  def least_accurate_team(season_id)
    seasonal_game_teams = current_season_data(season_id)
    get_team_name(seasonal_game_teams, false)
  end

  def team_tackles(season_id)
    seasonal_games = current_season_data(season_id)
    team_tackles = Hash.new {0}
    seasonal_games.each do |game|
      team_tackles[game.team_id] += game.tackles.to_i
    end
    team_tackles
  end

  def  most_tackles(season_id)
    most_tackled = team_tackles(season_id).max_by{|x, y| y} 
    most_tackled = @team_data.find {|team| team.team_id == most_tackled[0]}.team_name
  end

  def fewest_tackles(season_id)
    fewest_tackled = team_tackles(season_id).min_by{|x, y| y}
    fewest_tackled = @team_data.find {|team| team.team_id == fewest_tackled[0]}.team_name
  end
end
