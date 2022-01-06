require 'csv'
require 'pry'
class GameTeamsManager
  attr_accessor :data, :hash_data, :labeled_data

  def initialize
    @data = load_file
    @hash_data = Hash.new { |h, k| h[k] = [] }
    @labeled_data = label_data
  end

  def load_file
    data = CSV.read('./data/game_teams.csv')
    headers = data.shift.map { |i| i.to_sym }
    string_data = data.map { |row| row.map { |cell| cell.to_s } }
  end

  def label_data
    @data.each do |row|
      @hash_data[:game_id] << row[0]
      @hash_data[:team_id] << row[1]
      @hash_data[:HoA] << row[2]
      @hash_data[:result] << row[3]
      @hash_data[:settled_in] << row[4]
      @hash_data[:head_coach] << row[5]
      @hash_data[:goals] << row[6]
      @hash_data[:shots] << row[7]
      @hash_data[:tackles] << row[8]
      @hash_data[:pim] << row[9]
      @hash_data[:powerPlayOpportunities] << row[10]
      @hash_data[:powerPlayGoals] << row[11]
      @hash_data[:faceOffWinPercentage] << row[12]
      @hash_data[:giveaways] << row[13]
      @hash_data[:takeaways] << row[14]
    end
    @hash_data
  end
end

a = GameTeamsManager.new
require 'pry'
binding.pry
