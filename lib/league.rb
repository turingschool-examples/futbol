require_relative './futbol_data'

class League < FutbolData

  def initialize(filenames)
    super(filenames)
  end

  def count_of_teams
    @teams.count
  end

  def calc_avg_goals_alltime(team_id, location = nil)

    #for all available games across all seasons,
      # if location isn't set, just iterate over all objects and aggregate the goals
      # if location IS set, only aggregate the goals for that location, home vs. away
    goals = []
    @game_teams.each do |game_team|
      if location == nil
        if game_team.team_id == team_id
          goals << game_team.goals
        end
      elsif location == "home"
        if game_team.team_id == team_id && game_team.HoA == "home"
          goals << game_team.goals
          # require "pry"; binding.pry
        end
      elsif location == "away"
        if game_team.team_id == team_id && game_team.HoA == "away"
          goals << game_team.goals
        end
      end
    end
    sum = goals.sum.to_f
    count = goals.count.to_f
    average = (sum / count)
    average
  end

  # highest scorer, with optional location representing away or home
  def best_offense(location = nil)
    averages = []
    @teams.each do |team|
      averages << [team, self.calc_avg_goals_alltime(team.team_id, location)]
    end
    max = averages.max {|a, b| a[1] <=> b[1]}
    max[0].teamName
  end

  # lowest scorer, with optional location representing away or home
  def worst_offense(location = nil)
    averages = []
    @teams.each do |team|
      averages << [team, self.calc_avg_goals_alltime(team.team_id, location)]
    end
    min = averages.min {|a, b| a[1] <=> b[1]}
    min[0].teamName
  end

  # team with highest average score per game, all-time, when playing away
  def highest_scoring_visitor
    best_offense("away")
  end

  # team with the highest average score per game, all-time, at home
  def highest_scoring_home_team
    best_offense("home")
  end

  # team with lowest average score per game, all-time, when playing away
  def lowest_scoring_visitor
    worst_offense("away")
  end

  # team with the lowest average score per game, all-time, at home
  def lowest_scoring_home_team
    worst_offense("home")
  end



end
