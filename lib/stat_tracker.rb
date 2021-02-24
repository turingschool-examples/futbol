require 'csv'

class StatTracker

  def self.from_csv(csv_file)
    @data = csv_file.map {
      |csv_file|
      CSV.parse(File.read(csv_file[1]), headers: true, converters: :numeric)
    }

    @games = @data[0]
    @teams = @data[1]
    @game_teams = @data[2]
    @teams_test = @data[3]

     require "pry";binding.pry
  end
end
