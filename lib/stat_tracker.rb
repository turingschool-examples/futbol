# class SalesEngineTest < Minitest::Test
#   def setup
#     @sales_engine = SalesEngine.from_csv({
#       :items     => "./data/items.csv",
#       :merchants => "./data/merchants.csv",
#     })
#   end

# class SalesEngine
#   attr_reader :item_path, :merchant_path
#
#   def self.from_csv(file_paths)
#     item_path = file_paths[:items]
#     merchant_path = file_paths[:merchants]
#
#     SalesEngine.new(item_path, merchant_path)
#   end
#
#   def initialize(item_path, merchant_path)
#     @item_path = item_path
#     @merchant_path = merchant_path
#   end

class StatTracker




  def self.from_csv(file_paths)
    team_path = file_paths[:teams]
    game_path = file_paths[:games]
    stat_path = file_paths[:game_teams]

    StatTracker.new(team_path, game_path, stat_path)
  end
    attr_reader :team_path, :game_path, :stat_path
  def initialize(team_path, game_path, stat_path)
    @team_path = team_path
    @game_path = game_path
    @stat_path = stat_path
  end

  def teams(file_path)
    Team.from_csv(team_path)
    Team.all_teams
  end

    def games(file_path)
      Game.from_csv(game_path)
      Game.all_games
  end

  def game_stats(file_path)
    GameStats.from_csv(file_path)
    game_stats = GameStats.all_game_stats

  end
end
