require 'CSV'
require './lib/team'

class TeamManager
  attr_reader :teams

  def initialize(file_path)
    @file_path = file_path
    @teams = {}
    load
  end

  def load
    data = CSV.read(@file_path, headers: true)
    data.each do |row|
      @teams[row["team_id"]] = Team.new(row)
    end
  end
end
