require './lib/team'

class TeamsCollection
  attr_reader :teams
  def initialize(file_path)
    @teams = []
    create_teams(file_path)
  end

  def create_teams(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @teams << Team.new(row)
    end
  end
end
