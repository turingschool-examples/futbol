require './lib/futbol_csv_reader'

class LeagueChild < CSVReader

  def initialize(locations)
    super(locations)
  end

  def count_of_teams
    @teams.count
  end

  def avg_total_goals(team_id, hoa = nil)
    goals = []
    @game_teams.each do |game|
      if game.hoa == hoa or hoa == nil
        if game.team_id == team_id
          goals << game.goals.to_f
        end
      end
    end
    sum = goals.sum
    total_games = goals.length
    avg = (sum / total_games)
    avg.round(2)
  end

  def best_offense(hoa = nil)
   avg = []
   @teams.each do |team|
     avg << [team, avg_total_goals(team.team_id, hoa)]
   end
   high_avg_team = avg.max_by do |team|
     team[1]
   end[0].team_name
  end

  def worst_offense(hoa = nil)
   avg = []
   @teams.each do |team|
     avg << [team, avg_total_goals(team.team_id, hoa)]
   end
   low_avg_team = avg.min_by do |team|
     team[1]
   end[0].team_name
  end

  def highest_scoring_visitor
    best_offense("away")
  end

  def highest_scoring_home_team
    best_offense("home")
  end

  def lowest_scoring_visitor
    worst_offense("away")
  end

  def lowest_scoring_home_team
    worst_offense("home")
  end
end
