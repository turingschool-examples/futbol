require_relative "futbol"

class LeagueStats < Futbol

  def initialize(locations)
    super(locations)
  end

  def count_of_teams
    @games.map(&:game_id).uniq.length
    end
  end

  def best_offense

  end

  def worst_offense

  end


  def highest_scoring_visitor

    games.map do |game|
          
      visitor_hash = Hash.new(0)
      if game.home_away == "away"
        count_of_games = 0
        count_of_goals = 0
      end
    end.max()
  end

  def highest_scoring_home_team
    games.map do |game|
      count_of_games = 0
      count_of_goals = 0
      if game.home_away == "home"
        count_of_games += 1
        count_of_goals += game.goals
      end
      count_of_goals / count_of_games
    end.max()
  end

  def lowest_scoring_visitor
    games.map do |game|
      count_of_games = 0
      count_of_goals = 0
      if game.home_away == "away"
        count_of_games += 1
        count_of_goals += game.goals
      end
      count_of_goals / count_of_games
    end.min()
  end

  def lowest_scoring_home_team
    games.map do |game|
      count_of_games = 0
      count_of_goals = 0
      if game.home_away == "home"
        count_of_games += 1
        count_of_goals += game.goals
      end
      count_of_goals / count_of_games
    end.min()
  end
end