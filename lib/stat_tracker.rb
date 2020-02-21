# require "./lib/modules/calculable"

class StatTracker
  # include Calculable

  def initialize()
  end

  def self.from_csv(locations)
    StatTracker.create_items(locations[:games], Game)
    StatTracker.create_items(locations[:game_teams], GameTeam)
    StatTracker.create_items(locations[:teams], Team)
    StatTracker.new()
  end

  def self.create_items(file, item_class)
    csv_options = {
                    headers: true,
                    header_converters: :symbol,
                    converters: :all
                  }
      CSV.foreach(file, csv_options) { |row| item_class.add(item_class.new(row.to_hash)) }
  end

  def sort(class_object, function = "add")
    total_scores = []
    class_object.all.each_value do |value|
      if function == "add"
        total_scores << value.home_goals + value.away_goals
      elsif function == "subtract"
        total_scores << value.home_goals - value.away_goals
      end
    end
    total_scores.uniq.sort
  end

  def highest_total_score
    sort(Game).max
  end

  def lowest_total_score
    sort(Game).min
  end

  def biggest_blowout
    sort(Game, "subtract").min.abs
  end

  def games_outcome_percent(outcome = nil)
    games_count = 0.0
    Game.all.each_value do |value|
      if outcome == "away" && value.home_goals < value.away_goals
        games_count += 1
      elsif outcome == "home" && value.home_goals > value.away_goals
        games_count += 1
      elsif outcome == "draw" && value.home_goals == value.away_goals
        games_count += 1
      end
    end
    (games_count / Game.all.length * 100).round(2)
  end

  def percentage_home_wins
    games_outcome_percent("home")
  end

  def percentage_visitor_wins
    games_outcome_percent("away")
  end

  def percentage_ties
    games_outcome_percent("draw")
  end

  def count_of_games_by_season
    count = Game.all.values.reduce(Hash.new(0)) do |games_by_season, game|
      games_by_season[game.season] += 1
      games_by_season
    end
    count
  end

  def average_goals_per_game
    total_goals_per_game = []
    Game.all.each_value do |game|
      total_goals_per_game << game.away_goals + game.home_goals.to_f
    end
    (total_goals_per_game.sum.to_f / Game.all.length).round(2)
  end

  def total_goals_per_season(season)
    total_goals = 0.0
    Game.all.each_value do |game|
      if game.season == season
        total_goals += (game.away_goals + game.home_goals)
      end
    end
    total_goals
  end

  def number_of_games_per_season(season)
    total_games = 0
    Game.all.each_value do |game|
      if game.season == season
        total_games += 1
      end
    end
    total_games
  end

  def average_goals_by_season
    Game.all.values.reduce(Hash.new(0)) do |goals_by_season, game|
      goals = total_goals_per_season(game.season)
      games = number_of_games_per_season(game.season)

      goals_by_season[game.season] = (goals / games).round(2)
      goals_by_season
    end
  end

end
