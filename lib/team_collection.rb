require './lib/team'
require 'csv'
require 'pry'

class TeamCollection
  attr_reader :all

  def initialize(team_collection)
    @all = team_collection
  end

    Team.new({:id => info["id"],
     :franchise_id => info["franchiseid"],
     :name => info["name"],
     :abbreviation => info["abbreviation"],
     :stadium => info["stadium"],
     :link => info["link"]})
    # rows = CSV.read("#{team_path}", headers: true, header_converters: :symbol)
    # csv.map do |row|
    #   p row
end 
