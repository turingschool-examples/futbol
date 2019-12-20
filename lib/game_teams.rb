require 'csv'

class GameTeams
  
  @@all = []

  def self.all
    @@all
  end

  #this can be a self.reset method which makes an empty array again
  ## Teardown method for minitest

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)

    @@all = csv.map do |row|
      GameTeams.new(row)
    end
  end

  attr_reader 

  def initialize(game_team_info)
    @game_id = game_team_info[:game_id]
    @team_id = game_team_info[:team_id]
    @hoa = game_team_info[:HoA]
    @result = game_team_info[:result]
    @goals = game_team_info[:goals]
  end

end
