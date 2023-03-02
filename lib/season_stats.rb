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
end