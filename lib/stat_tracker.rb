class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def self.from_csv(csv_files)
    games = CSV.read(csv_files[:games], headers: true, header_converters: :symbol, converters: :numeric)
    teams = CSV.read(csv_files[:teams], headers: true, header_converters: :symbol, converters: :numeric)
    game_teams = CSV.read(csv_files[:game_teams], headers: true, header_converters: :symbol, converters: :numeric)
    StatTracker.new(games, teams, game_teams)
  end

  def initialize(game_path, team_path, game_teams_path)
    @games = game_path
    @teams = team_path
    @game_teams = game_teams_path
  end

  def highest_total_score
    highest_total_home_score = games.by_col![6][7].max_by do |number|
      number
      require'pry';binding.pry
    end

    highest_total_away_score = games.by_col![7].max_by do |number|
      number
    end

    highest_total_score = highest_total_home_score + highest_total_away_score
  end

  def lowest_total_score
    highest_total_home_score = games.by_row[6][7].sum do |number|
      number
    end

    highest_total_away_score = games.by_col[7].max do |number|
      number
    end

    highest_total_score = highest_total_away_score - highest_total_home_score
  end
end
