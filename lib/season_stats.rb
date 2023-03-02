require_relative 'classes'

class SeasonStats < Classes

  def initialize(locations)
    super
  end

  def winningest_coach
  find_coach_ratios.max_by{|k,v| v}[0]
  end
  
  def worst_coach
    find_coach_ratios.min_by{|k,v| v}[0]
  end
  
  def find_coach_ratios
    win_loss = Hash.new(0)
    @game_teams.each do |game|
      if game.result == 'WIN'
        win_loss[game.head_coach] += 1
      elsif game.result == 'LOSS'
        win_loss[game.head_coach] -= 1
      end
    end
    win_loss
  end

  def total_team_tackles
    total_team_tackles_hash = Hash.new(0)
    @game_teams.each do |team|
      total_team_tackles_hash[team.team_id] += team.tackles
    end
    total_team_tackles_hash
  end

  def most_team_tackles
    team_id = total_team_tackles.max_by { |k, v| v }[0]
    @teams.each do |team|
      if team.team_id == team_id
        team_id = team.teamname
      end
    end
    team_id
  end

  def least_team_tackles
    team_id = total_team_tackles.min_by { |k, v| v }[0]
    @teams.each do |team|
      if team.team_id == team_id
        team_id = team.teamname
      end
    end
    team_id
  end
  #Helper method for most/least accurate team
  def season_shots_goals 
    infohash = Hash.new()
    @games.each do |game|
      infohash[game.id] = {:season => game.season}
    end
    
    @game_teams.each do |game|
      infohash[game.game_id][:shots] = game.shots
      infohash[game.game_id][:goals] = game.goals 
      infohash[game.game_id][:team_id] = game.team_id
    end
    infohash
  end
  #Helper method for most/least accurate team
  def sort_by_season(season_string) #("20132014")
    infohash = season_shots_goals()
    infohash_by_season = Hash.new(0)
    infohash.each do |key, value|
      if value[:season] == season_string
        infohash_by_season[value[:team_id]] = {:total_shots => 0, :total_goals => 0}
      end
    end

    infohash.each do |key,value|
      if value[:season] == season_string
        infohash_by_season[value[:team_id]][:total_shots] += value[:shots]
        infohash_by_season[value[:team_id]][:total_goals] += value[:goals]
      end
    end
    infohash_by_season
  end
  
  def most_accurate_team(season_string)
    infohash = sort_by_season(season_string)
    ratio_hash = Hash.new
    infohash.each do |key ,value|
      ratio_hash[key] = ( value[:total_shots].to_f / value[:total_goals].to_f).round(2)
    end
    ratio_hash = ratio_hash.sort_by {|_, v| v }
    team_id = ratio_hash[0][0]
    convert_id_to_teamname(team_id)
  end

  def least_accurate_team(season_string)
    infohash = sort_by_season(season_string)
    ratio_hash = Hash.new
    infohash.each do |key ,value|
      ratio_hash[key] = (value[:total_shots].to_f / value[:total_goals].to_f).round(2)
    end
    ratio_hash = ratio_hash.sort_by {|_, v| v }
    team_id = ratio_hash.last[0]
    convert_id_to_teamname(team_id)
  end

  def convert_id_to_teamname(id_string)
    team = @teams.select{|team|team.team_id == id_string}
    team[0].teamname
  end
end