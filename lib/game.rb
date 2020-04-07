class Game
  @@all_games = []
  def self.from_csv(file_path)
      csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
      @@all_games = csv.map do |row|
        game = Game.new(row)
      end
  end

  def self.all_games
    @@all_games
  end

  attr_reader :game_id, :season, :type, :date_time,
              :away_team_id, :home_team_id, :away_goals,
              :home_goals, :venue, :venue_link

  def initialize(info)
    @game_id = info[:game_id].to_i
    @season = info[:season]
    @type = info[:type]
    @date_time = info[:date_time]
    @away_team_id = info[:away_team_id].to_i
    @home_team_id = info[:home_team_id].to_i
    @away_goals = info[:away_goals].to_i
    @home_goals = info[:home_goals].to_i
    @venue = info[:venue]
    @venue_link = info[:venue_link]
  end

end
