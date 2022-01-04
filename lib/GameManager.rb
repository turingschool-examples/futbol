require 'csv'
require 'pry'
class GameManager
  attr_accessor :data, :hash_data, :labeled_data
  def initialize
    @data = load_file
    @hash_data = Hash.new {|h,k| h[k] = []}
    @labeled_data = label_data
  end

  def load_file()
    data = CSV.read('./data/games.csv')
    headers = data.shift.map {|i| i.to_sym }
    string_data = data.map {|row| row.map {|cell| cell.to_s} }
  end

  def label_data()
    @data.each do |row|
      @hash_data[:team_id] << row[0]
      @hash_data[:season] << row[1]
      @hash_data[:type] << row[2]
      @hash_data[:data_time] << row[3]
      @hash_data[:away_team_id] << row[4]
      @hash_data[:home_team_id] << row[5]
      @hash_data[:away_goals] << row[6]
      @hash_data[:home_goals] << row[7]
      @hash_data[:venue] << row[8]
      @hash_data[:venue_link] << row[9]
    end
    return @hash_data
  end
end

a = GameManager.new

binding.pry
