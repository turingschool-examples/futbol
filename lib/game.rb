
class Game
  attr_reader :game_id,
              :season,
              :type,
              :date_time,
              :away_team_id,
              :home_team_id,
              :away_goals,
              :home_goals,
              :id_hash,
              :game_rows

  def initialize(attributes)
    @game_id = attributes[:game_id]
    @season = attributes[:season]
    @type = attributes[:type]
    @date_time = attributes[:date_time]
    @away_team_id = attributes[:away_team_id]
    @home_team_id = attributes[:home_team_id]
    @away_goals = attributes[:away_goals]
    @home_goals = attributes[:home_goals]
    @id_hash = {}
    @game_rows = []
  end

  def self.read_file(location)
    @game_rows = CSV.read(location, headers: true, header_converters: :symbol)

    @game_rows.map do |game_row|
      new(game_row)
    end
  end

  # def game_by_id
  #   @game_rows.each do |game_row|
  #     @id_hash[game_row.game_id] ||= []
  #     @id_hash[game_row.game_id] << game_row
  #   end
  #   @id_hash
  #
  # end
end
