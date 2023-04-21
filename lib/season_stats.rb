require_relative 'futbol'
class SeasonStats < Futbol

  def initialize(locations)
    super(locations)
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
      num_coach_losses.each_pair do |coach, losses|
      losses.to_f / head_coach_games(coach)
    end
  end

  def head_coach_games(coach)
    games.count do |game|
      game.home_head_coach == coach || game.away_head_coach == coach
    end
  end

  def num_team_tackles(season)
    num_team_tackles = Hash.new(0)
    @games.map do |game|
      if game.season == season
        num_team_tackles[game.home_team_name] += game.home_tackles 
        num_team_tackles[game.away_team_name] += game.away_tackles
      end
    end
    num_team_tackles
  end

  def most_tackles(season)
    num_team_tackles(season).max_by do |name, tackles|
      tackles
    end.first
  end

  def fewest_tackles(season)
    num_team_tackles(season).min_by do |name, tackles|
      tackles
    end.first
  end
end