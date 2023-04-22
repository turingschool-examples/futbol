require_relative 'futbol'

class SeasonStats < Futbol

  def initialize(locations)
    super(locations)
  end

  def most_accurate_team(season)
    return invalid_season if season_no_existy?(@games.season)
    team = @teams.select do |team|
      team.team_id == 
    end
  end

  def least_accurate_team

  end

  def season_no_existy?(season)
    seasons = 
  end

  def invalid_season
    'Season does not exist'
  end

  def winningest_coach(season)
    num_coach_wins = Hash.new(0)
    @games.map do |game|
      if game.home_result == "WIN" && game.season == season
        num_coach_wins[game.home_head_coach] += 1
      elsif
        game.away_result == "WIN" && game.season == season
        num_coach_wins[game.away_head_coach] += 1
      end
    end
    num_coach_wins.max_by do |coach, wins|
      wins
    end.first
  end

  def worst_coach(season)
    num_coach_losses = Hash.new(0)
    @games.map do |game|
      if game.home_result == "LOSS" && game.season == season
        num_coach_losses[game.home_head_coach] += 1
      elsif
        game.away_result == "LOSS" && game.season == season
        num_coach_losses[game.away_head_coach] += 1
      end
    end
    require 'pry'; binding.pry
      num_coach_losses.each_pair do |coach, losses|
      losses.to_f / head_coach_games(coach)
    end
  end

  def head_coach_games(coach)
    games.count do |game|
      game.home_head_coach == coach || game.away_head_coach == coach
    end
  end
end
