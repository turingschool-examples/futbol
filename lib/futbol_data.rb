require "csv"
class FutbolData

  def initialize(passed)
    @passed = passed
    @data_location = nil
    @teams = []
    @games = []
    @game_teams = []
    # @collection_name = nil
  end

  #case method that takes the passed and returns both the file location and .new?
  #self.create_objects passed param of case
  #passed param will update file location and new
  def chosen_data_set
    case @passed
      when "team"
        @data_location = './data/teams.csv'
      when "game"
        @data_location = './data/games.csv'
      when "game_team"
        @data_location = './data/game_teams.csv'
    end
  end

  def create_objects
    chosen_data_set
    if @passed == 'team'
      csv_data = CSV.read(@data_location, headers: true)
        csv_data.each do |x|
          @teams << x
        end
    elsif @passed == 'game'
      csv_data = CSV.read(@data_location, headers: true)
        csv_data.each do |x|
          @games << x
        end
    elsif @passed == 'game_team'
      csv_data = CSV.read(@data_location, headers: true)
        csv_data.each do |x|
          @game_teams << x
        end
    end
  end










    #   table = CSV.parse(File.read(@data_location), headers: true)
    #   line_index = 0
    #   all_data = []
    #   table.size.times do
    #     require "pry"; binding.pry
    #     self.create_attributes(table, line_index)
    #     all_data << collection_name
    #     line_index += 1
    # end
    # all_data
end
