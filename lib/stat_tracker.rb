# Sum up Away and Home team's score per game_id
# Get data by col
  # Col by winning score + Col by losing score
# Parse CSV table initially and save as instance variable
# Method will iterate through instance variable
class StatTracker
  attr_reader :g_table, :gt_table, :t_table
  def self.from_csv(locations)
    @g_table = CSV.parse(File.read(locations[:games]), headers: true) # Games table
    @gt_table = CSV.parse(File.read(locations[:game_teams]), headers: true) # Game Teams table
    @t_table = CSV.parse(File.read(locations[:teams]), headers: true) # Teams table
  end
  
  def initialize
    @g_table = nil
    @gt_table = nil
    @t_table = nil
  end

  def highest_total_score# Rename later, for now from Games Table
    require 'pry'; binding.pry
    @g_table[6]
  end

end
