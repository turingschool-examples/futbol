require "csv"

class StatTracker
  attr_reader :teams,
              :games,
              :game_teams

  def initialize
    @teams = []
    @games = []
    @game_teams = []
  end

  def self.from_csv()
  end

  def self.team_import(file_name)
    content = CSV.open file_name, headers: false, header_converters: :symbol
  # require "pry";binding.pry
    content.each do |line|
          require "pry";binding.pry
    @teams << Team.new(line)
    end

  end
end
