class GameFactory
  def self.create_games(filepath)
    games = []
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      games << Game.new(row[:home_team_id], row[:away_goals].to_i, row[:home_goals].to_i, row[:venue], row[:venue_link])
    end
    return games
  end
end