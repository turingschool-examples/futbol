require 'csv'
require_relative './stat_tracker'

class Teams
  attr_reader :team_id,
              :franchise_id,
              :teamname,
              :abbreviation,
              :stadium,
              :link

  def initialize(data)
    @team_id      = data[:team_id]
    @franchise_id = data[:franchiseid]
    @teamname     = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium      = data[:stadium]
    @link         = data[:link]
  end
end
