class GameCollection
  attr_reader :all

  def initialize(game_collection)
    @all = game_collection
  end

  def self.get_all(game_file)
    all_games = []
    CSV.read(game_file, headers: true).each do |game|
      game_hash = {:id,
                  :season,
                  :type,
                  :date_time,
                  :away_team_id,
                  :home_team_id,
                  :away_goals,
                  :home_goals,
                  :venue}
      all_games << Game.new(merchant_hash)
    end
    all_games
  end
end
