class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def self.from_csv(csv_files)
    games = CSV.read(csv_files[:games], headers: true, header_converters: :symbol)
    teams = CSV.read(csv_files[:teams], headers: true, header_converters: :symbol)
    game_teams = CSV.read(csv_files[:game_teams], headers: true, header_converters: :symbol)
    StatTracker.new(games, teams, game_teams)
  end

  def initialize(game_path, team_path, game_teams_path)
    @games = game_path
    @teams = team_path
    @game_teams = game_teams_path
  end

  def highest_total_score
    # game_totals = CSV.parse(File.read(@games), headers: true, converters: :numeric)
    highest_total_home_score = games.by_col[6].sum do |number|
      number
    end

    highest_total_away_score = games.by_col[7].sum do |number|
      number
    end

    highest_total_score = highest_total_home_score + highest_total_away_score
  end
end
#comment
