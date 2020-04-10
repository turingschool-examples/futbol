# team_info (A hash with key/value pairs for the following attributes:
# team_id, franchise_id, team_name,
# abbreviation, and link)
# best_season
# worst_season
# average_win_percentage
# most_goals_scored
# fewest_goals_scored
# favorite_opponent
# rival

require_relative 'team'
require 'csv'

class Teams
  attr_reader :teams

  def initialize(csv_file_path)
    @teams = create_teams(csv_file_path)
  end

  def create_teams(csv_file_path)
    csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
    csv.map do |row|
      Team.new(row)
    end
  end
end
