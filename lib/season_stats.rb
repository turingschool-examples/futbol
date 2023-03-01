require_relative 'stat_tracker'

class SeasonStats < StatTracker
  def initialize
    @games = super
    @teams = super
    @game_teams = super
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