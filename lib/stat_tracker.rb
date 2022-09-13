require "csv"

class StatTracker
  attr_reader :games,
              :game_teams,
              :teams

  def initialize
    @teams = []
    @games = []
    @game_teams = []
  end

  def self.from_csv()
  end

  def team_import(file_name)
    content = CSV.open file_name, headers: true
    content.each do |line|
      next if line == ["team_id", "franchiseId", "teamName", "abbreviation", "Stadium", "link"]
      @teams << Team.new(line)
    end

  end
end
