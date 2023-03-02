require_relative './helper'

module SeasonStats
  include Helper

  def season_rspec_test
    true
  end

  def winningest_coach
    wins_by_coach = Hash.new(0)
    @game_teams.each do |game|
      coach = game.head_coach
      result = game.result
      if result == "WIN"
        wins_by_coach[coach] += 1
      end
    end
    wins_by_coach.max_by { |coach, wins| wins }[0]
  end

  def worst_coach
    losses_by_coach = Hash.new(0)
    @game_teams.each do |game|
      coach = game.head_coach
      result = game.result
      if result == "LOSS"
        losses_by_coach[coach] += 1
      end
    end
    losses_by_coach.max_by { |coach, losses| losses }[0]
  end

  def most_accurate_team

  end

  def least_accurate_team

  end

  def most_tackles

  end

  def fewest_tackles

  end
end