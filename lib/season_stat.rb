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

  def build_coach_win_loss(seasonal_games)
    coaches_wl = {}
    seasonal_games.each do |data|
      if !coaches_wl.keys.include?(data.head_coach)
        coaches_wl[data.head_coach] = [data.result]
      else
        coaches_wl[data.head_coach] << [data.result]
      end      
    end
     coaches_wl
  end

  def winningest_coach(season_id)
    seasonal_games = current_season_data(season_id)
    win_loss_calc(build_coach_win_loss(seasonal_games), "WIN")
  end 
  
  def win_loss_calc(coach_win_loss, win_loss)
    coaches_win_loss_ratio = {}
    coach_win_loss.map do |coach, wl|
      wins = 0
      total_games = wl.flatten.length
      wl.flatten.each do |x|
        wins += 1 if x == "WIN"
      end
      wl_ratio = (wins.to_f / total_games * 100).round(0)
     
      coaches_win_loss_ratio[coach] = wl_ratio
    end
    if win_loss == "WIN"
      coaches_win_loss_ratio.max_by{|key,value|value}[0]
    else 
      coaches_win_loss_ratio.min_by{|key,value|value}[0]
    end  
  end

  def worst_coach(season_id)
    seasonal_games = current_season_data(season_id)
    win_loss_calc(build_coach_win_loss(seasonal_games), "LOSS")
  end

  def get_team_name(team_id)
    team = @team_data.select do |team|
      team.team_id == team_id
    end
    team.uniq[0].team_name
  end
  
  def calculate_accuracy(teams_accuracy, accurate)
    accuracy = {}
    
    teams_accuracy.each do |tgas|
      acc = (tgas[1][:goals].to_f / tgas[1][:shots]).round(2) * 100
      accuracy[tgas[0]] = "#{acc}%"
    end
    
    if accurate == true
      get_team_name(accuracy.max_by{|key,value|value}[0])
    else 
      get_team_name(accuracy.min_by{|key,value|value}[0])
    end  
  end

  def team_accuracy_calculations(seasonal_games, accurate)
    teams_accuracy = Hash.new {|hash, key| hash[key] = Hash.new}
    seasonal_games.each do |game|
      if !teams_accuracy.include?(game.team_id)
        teams_accuracy[game.team_id][:goals] = game.goals.to_i
        teams_accuracy[game.team_id][:shots] = game.shots.to_i
      else
        teams_accuracy[game.team_id][:goals] += game.goals.to_i
        teams_accuracy[game.team_id][:shots] += game.shots.to_i
      end
    end
    
    calculate_accuracy(teams_accuracy, accurate)
  end

  def most_accurate_team(season_id)
    seasonal_games = current_season_data(season_id)
   
    team_accuracy_calculations(seasonal_games, true)
  end

  def least_accurate_team(season_id)
    seasonal_games = current_season_data(season_id)
    team_accuracy_calculations(seasonal_games, false)
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
