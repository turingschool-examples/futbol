class GamesCollection
  attr_reader :games

  def initialize(games_path)
    @games = generate_objects_from_csv(games_path)
  end

  def generate_objects_from_csv(csv_games_path)
    objects = []
    CSV.foreach(csv_games_path, headers: true, header_converters: :symbol) do |row_object|
      objects << Game.new(row_object)
    end
    objects
  end

  def unique_seasons
    @games.map {|game| game.season}.uniq
  end

  def number_of_games_in_each_season
    seasons_of_games = @games.group_by {|game| game.season}
    seasons_of_games.values.map {|value| value.length}
  end

  def count_of_games_by_season
    target_hash = {}
    unique_seasons.each_with_index do |season, index|
      target_hash[season] = number_of_games_in_each_season[index]
    end
    target_hash
  end

  def highest_total_score
    @games.map {|game| game.away_goals.to_i + game.home_goals.to_i }.max
  end

  def lowest_total_score
    @games.map {|game| game.away_goals.to_i + game.home_goals.to_i }.min
  end

  # Helper method designed to be reusable; consider moving to a module
  def every(attribute, collection)
    collection.map { |element| element.send(attribute) }
  end

  # Helper method designed to be reusable; consider moving to a module
  def every_unique(attribute, collection)
    every(attribute, collection).uniq
  end

  # Helper method designed to be reusable; consider moving to a module
  def total_unique(attribute, collection)
    every_unique(attribute, collection).length
  end

  # Helper method; possibly unnecessary if goals pulled from games_teams
  def goals(game)
    game.home_goals.to_i + game.away_goals.to_i
  end

  # Helper method
  def total_goals(games)
    games.sum { |game| goals(game) }
  end

  # Helper method
  def average_goals_in(games)
    (total_goals(games) / total_unique("game_id", games).to_f).round(2)
  end

  # Iteration 2 required method
  def average_goals_per_game
    average_goals_in(@games)
  end

  # Helper method
  def all_games_in_season(season)
    @games.select { |game| game.season == season }
  end

  # Iteration 2 required method
  def average_goals_per_season
    every_unique("season", @games).reduce({}) do |hash, season|
      hash[season] = average_goals_in(all_games_in_season(season))
      hash
    end
  end

  def home_teams
    every_unique("home_team_id", @games)
  end

  def total_home_goals(team)
    season_goals = 0
    @games.each do |game|
      if team == game.home_team_id
        season_goals += game.home_goals.to_i
      end
    end
    season_goals
  end

  # # address this
  # def home_team_goals
  #   home_teams.reduce({}) do |acc, team|
  #     acc[team] = season_goals
  #     acc
  #   end
  # end

  def highest_scoring_home_team
    home_team_goals.find do |team, goals|
      goals == home_team_goals.values.sort.last
    end.first
  end

  def lowest_scoring_home_team
    home_team_goals.find do |team, goals|
      goals == home_team_goals.values.sort.first
    end.first
  end

  def away_teams
    every_unique("away_team_id", @games)
  end

  def away_team_goals
    away_teams.reduce({}) do |acc, team|
    season_goals = 0
      games.each do |game|
        if team == game.away_team_id
          season_goals += game.away_goals.to_i
        end
      end
      acc[team] = season_goals
      acc
    end
  end

  def highest_scoring_away_team
    away_team_goals.find do |team, goals|
      goals == away_team_goals.values.sort.last
    end.first
  end

  def lowest_scoring_away_team
    away_team_goals.find do |team, goals|
      goals == away_team_goals.values.sort.first
    end.first
  end

end
