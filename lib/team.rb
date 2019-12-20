require 'csv'
require_relative 'team'

class Team
  @@all = []

  def self.all
    @@all
  end

  #this can be a self.reset method which makes an empty array again
  ## Teardown method for minitest

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)


    @@all = csv.map do |row|
      Team.new(row)
    end
  end

    attr_reader :team_id, :franchiseId, :teamName, :abbreviation

  def initialize(team_info)
    @team_id = team_info[:team_id]
    @franchiseId = team_info[:franchiseid]
    @teamName = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    # @Stadium = team_info[:] #downcase
  end

end
