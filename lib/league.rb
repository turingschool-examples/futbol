
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


end
