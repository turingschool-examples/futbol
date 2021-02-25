require_relative 'game_team'

class GameTeamManager

  attr_reader :game_teams

  def initialize(data)
    @game_teams = load_data(data)
  end

  def load_data(file_path)
    csv = CSV.read(file_path, :headers => true,
    header_converters: :symbol)
      csv.map do |row|
      GameTeam.new(row)
    end

end
