require 'CSV'

class Team

  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link
  # def self.from_csv(data)
  #   Team.new(data)
  # end

  def initialize(data)
    @team_id = data[0]
    @franchise_id = data[1]
    @team_name = data[2]
    @abbreviation = data[3]
    @stadium = data[4]
    @link = data[5]
  end

end
