class GameCollection

  attr_reader :games

  def initialize(csv_file_path)
    @games = create_games(csv_file_path)
  end

  def create_games(csv_file_path)
    csv = CSV.read(csv_file_path, headers: true, header_converters: :symbol)
    csv.map do |row|
       # Game.new(row)
       row
    end
  end

  def percentage_home_wins
    count = 0
    @games.each {|game| count += 1 if game[:home_goals] > game[:away_goals]}
    ((count / @games.length.to_f) * 100).round(2)
  end

  def percentage_visitor_wins
    count = 0
    @games.each {|game| count += 1 if game[:away_goals] > game[:home_goals]}
    ((count / @games.length.to_f) * 100).round(2)
  end

  def percentage_ties
    count = 0
    @games.each {|game| count += 1 if game[:away_goals] == game[:home_goals]}
    ((count / @games.length.to_f) * 100).round(2)
  end
end
