class TeamsManager
  attr_reader :teams, :tracker
  def initialize(teams_path, tracker)
    @teams = []
    @tracker = tracker
    # create_games(teams_path)
  end

  # def create_games(teams_path)
  #   teams_data = CSV.parse(File.read(teams_path), headers: true)
  #   @teams = teams_data.map do |data|
  #     Team.new(data, self)
  #   end
  # end
end
