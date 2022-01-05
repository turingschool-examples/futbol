require 'csv'

class TeamManager
  attr_accessor :team_id,
                :franchise_id,
                :team_name,
                :abbreviation,
                :stadium,
                :link
  def initialize
      @data = load_file
      @hash_data = Hash.new {|h,k| h[k] = []}
      @labeled_data = label_data
  end

  def load_file()
    data = CSV.read('./data/teams.csv')
    headers = data.shift.map {|header| header.to_sym }
    string_data = data.map {|row| row.map {|cell| cell.to_s} }
  end

  def label_data()
    @data.each do |row|
      @hash_data[:team_id] << row[0]
      @hash_data[:franchiseid] << row[1]
      @hash_data[:teamname] << row[2]
      @hash_data[:abbreviation] << row[3]
      @hash_data[:stadium] << row[4]
      @hash_data[:link] << row[5]
    end
    return @hash_data
  end
end

team = TeamManager.new
require "pry"; binding.pry
