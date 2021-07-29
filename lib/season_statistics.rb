require './lib/stat_tracker'

class SeasonStatistics
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games      = games
    @teams      = teams
    @game_teams = game_teams
  end

  def total_games_by_coach(season)
    games_by_coach = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        games_by_coach[game.head_coach] += 1
      end
    end
    games_by_coach
  end

  def winningest_coach(season)
    wins_by_coach = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten) && game.result == 'WIN'
        wins_by_coach[game.head_coach] += 1
      end
    end
    coach = wins_by_coach.max_by do |coach, wins|
      tot_games = total_games_by_coach(season)[coach]
      wins.fdiv(tot_games)
    end
    coach[0]
  end

  def worst_coach(season)
    losses_by_coach = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten) && game.result == 'LOSS'
        losses_by_coach[game.head_coach] += 1
      end
    end
    coach = losses_by_coach.max_by do |coach, losses|
      tot_games = total_games_by_coach(season)[coach]
      losses.fdiv(tot_games)
    end
    coach[0]
  end
end
