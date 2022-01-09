
class League
    attr_reader :games, :teams, :game_teams

    def initialize(games, teams, game_teams)
      @games = games
      @teams = teams
      @game_teams = game_teams
  end

  def average_goals_per_team(team_id_integer)
    game_counter = 0
    goals_per_game = []
    @game_teams.each do |row|
      if row[:team_id].to_i == team_id_integer
        goals_per_game << row[:goals].to_i
        game_counter += 1
      end
    end
    average(goals_per_game, game_counter)
  end

  def count_of_teams
    @teams.count
  end

  def all_teams_ids(data)
    team_id = []
    data.each do |row|
      team_id << row[:team_id].to_i
    end
    team_id.uniq
  end

  def average(numerator, denominator)
    (numerator.sum.to_f / denominator).round(2)
  end

  def convert_team_id_to_name(team_id_integer)
    name_array = []
    x = @teams.find do |row|
      row[:team_id].to_i == team_id_integer
    end
    x[:teamname]
  end

  def best_offense
  end

  def highest_scoring_visitor
    score_ranker("high", "away")
  end

  def highest_scoring_home_team
    score_ranker("high", "home")
  end

  def lowest_scoring_visitor
    score_ranker("low", "away")
  end

  def lowest_scoring_home_team
    score_ranker("low", "home")
  end

  def score_ranker(rank, location)
    if rank == "high"
      team = avg_scoring(location).max_by { |k,v| v }
      team[0]
    elsif rank == "low"
      team = avg_scoring(location).min_by { |k,v| v }
      team[0]
    end
  end

  def avg_scoring(location)
    h = {}
    all_team_ids = @teams.map {|row| row[:team_id]}
    all_team_ids.each do |id|
      goals = 0
      gamez = 0
      @games.each do |row|
        if row["#{location}_team_id".to_sym] == id
          goals += row["#{location}_goals".to_sym].to_i
          gamez += 1
        end
        h[convert_team_id_to_name(id.to_i)] = (goals.to_f / gamez).round(2) unless gamez == 0
      end
    end
    h
  end
end
