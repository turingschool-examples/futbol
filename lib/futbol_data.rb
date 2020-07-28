require "csv"
class FutbolData

  def initialize(passed)
    @passed = passed
    @data_location = nil
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
        @collection_name = game_data
      when "game_team"
        @data_location = './data/game_teams.csv'
        @collection_name = game_teams_data
    end
  end

  def create_objects
    chosen_data_set
    all_teams = []
    csv_data = CSV.read(@data_location, headers: true)
      csv_data.each do |x|
        all_teams << x
    end
    require "pry"; binding.pry








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



  def create_attributes(table, line_index)
    team_id      = table[line_index]["team_id"]
    franchise_id  = table[line_index]["franchiseId"]
    team_name     = table[line_index]["teamName"]
    abbreviation = table[line_index]["abbreviation"]
    stadium      = table[line_index]["Stadium"]
    link         = table[line_index]["link"]
  end
end
