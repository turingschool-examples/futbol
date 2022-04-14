require './lib/team_stats'
require './lib/game'
require './lib/game_teams'
require 'pry'

module LeagueStats
  def count_of_teams
    @teams.length
  end

  def best_offense
    teams_and_wins = {}
    @game_teams.each do |game|
      if teams_and_wins[game.team_id].nil?
        teams_and_wins[game.team_id] = { goals: game.goals, games: 1 }
      else
        teams_and_wins[game.team_id][:goals] += game.goals
        teams_and_wins[game.team_id][:games] += 1
      end
    end
    best_team = teams_and_wins.map do |team, nums|
      [team, nums[:goals].to_f / nums[:games]]
    end.sort_by { |team| team[1] }.reverse.first[0]
    @teams.find { |team| team.team_id == best_team }.team_name
  end

  def worst_offense
    teams_and_wins = {}
    @game_teams.each do |game|
      if teams_and_wins[game.team_id].nil?
        teams_and_wins[game.team_id] = { goals: game.goals, games: 1 }
      else
        teams_and_wins[game.team_id][:goals] += game.goals
        teams_and_wins[game.team_id][:games] += 1
      end
    end
    worst_team = teams_and_wins.map do |team, nums|
      [team, nums[:goals].to_f / nums[:games]]
    end.sort_by { |team| team[1] }.first[0]
    @teams.find { |team| team.team_id == worst_team }.team_name
  end

  def highest_scoring_visitor
    teams_and_wins = {}
    @game_teams.each do |game|
      if game.hoa == 'away'
        if teams_and_wins[game.team_id].nil?
          teams_and_wins[game.team_id] = { goals: game.goals, games: 1 }
        else
          teams_and_wins[game.team_id][:goals] += game.goals
          teams_and_wins[game.team_id][:games] += 1
        end
      end
    end
    best_team = teams_and_wins.map do |team, nums|
      [team, nums[:goals].to_f / nums[:games]]
    end.sort_by { |team| team[1] }.reverse.first[0]
    @teams.find { |team| team.team_id == best_team }.team_name
  end

  def highest_scoring_home_team
    teams_and_wins = {}
    @game_teams.each do |game|
      if game.hoa == 'home'
        if teams_and_wins[game.team_id].nil?
          teams_and_wins[game.team_id] = { goals: game.goals, games: 1 }
        else
          teams_and_wins[game.team_id][:goals] += game.goals
          teams_and_wins[game.team_id][:games] += 1
        end
      end
    end
    best_team = teams_and_wins.map do |team, nums|
      [team, nums[:goals].to_f / nums[:games]]
    end.sort_by { |team| team[1] }.reverse.first[0]
    @teams.find { |team| team.team_id == best_team }.team_name
  end

  def lowest_scoring_visitor
    teams_and_wins = {}
    @game_teams.each do |game|
      if game.hoa == 'away'
        if teams_and_wins[game.team_id].nil?
          teams_and_wins[game.team_id] = { goals: game.goals, games: 1 }
        else
          teams_and_wins[game.team_id][:goals] += game.goals
          teams_and_wins[game.team_id][:games] += 1
        end
      end
    end
    worst_team = teams_and_wins.map do |team, nums|
      [team, nums[:goals].to_f / nums[:games]]
    end.sort_by { |team| team[1] }.first[0]
    @teams.find { |team| team.team_id == worst_team }.team_name
  end

  def lowest_scoring_home_team
    teams_and_wins = {}
    @game_teams.each do |game|
      if game.hoa == 'home'
        if teams_and_wins[game.team_id].nil?
          teams_and_wins[game.team_id] = { goals: game.goals, games: 1 }
        else
          teams_and_wins[game.team_id][:goals] += game.goals
          teams_and_wins[game.team_id][:games] += 1
        end
      end
    end
    worst_team = teams_and_wins.map do |team, nums|
      [team, nums[:goals].to_f / nums[:games]]
    end.sort_by { |team| team[1] }.first[0]
    @teams.find { |team| team.team_id == worst_team }.team_name
  end
end
