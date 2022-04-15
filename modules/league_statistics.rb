require_relative '../lib/team_stats'
require_relative '../lib/game'
require_relative '../lib/game_teams'

module LeagueStats
  def count_of_teams
    @teams.length
  end

  def team_id_to_name(id)
    @teams.find { |team| team.team_id == id }.team_name
  end

  def wins_calculator
    teams_and_wins = {}
    @game_teams.each do |game|
      if teams_and_wins[game.team_id].nil?
        teams_and_wins[game.team_id] = { goals: game.goals, games: 1 }
      else
        teams_and_wins[game.team_id][:goals] += game.goals
        teams_and_wins[game.team_id][:games] += 1
      end
    end
    teams_and_wins.map do |team, nums|
      [team, nums[:goals].to_f / nums[:games]]
    end.sort_by { |team| team[1] }
  end

  def best_offense
    team_id_to_name(wins_calculator.reverse.first[0])
  end

  def worst_offense
    team_id_to_name(wins_calculator.first[0])
  end

  def home_away_calculator(position)
    teams_and_wins = {}
    @game_teams.each do |game|
      if game.hoa == position
        if teams_and_wins[game.team_id].nil?
          teams_and_wins[game.team_id] = { goals: game.goals, games: 1 }
        else
          teams_and_wins[game.team_id][:goals] += game.goals
          teams_and_wins[game.team_id][:games] += 1
        end
      end
    end
    teams_and_wins.map do |team, nums|
      [team, nums[:goals].to_f / nums[:games]]
    end.sort_by { |team| team[1] }
  end

  def highest_scoring_visitor
    team_id_to_name(home_away_calculator('away').reverse.first[0])
  end

  def highest_scoring_home_team
    team_id_to_name(home_away_calculator('home').reverse.first[0])
  end

  def lowest_scoring_visitor
    team_id_to_name(home_away_calculator('away').first[0])
  end

  def lowest_scoring_home_team
    team_id_to_name(home_away_calculator('home').first[0])
  end
end
