require_relative 'loadable'

class Team
  extend Loadable

   def self.from_csv(file_path)
     @@all = []
     load_csv(file_path, self)
   end

  def self.all
    @@all
  end

  attr_reader :team_id, :franchise_id,
            :team_name, :abbreviation,
            :stadium, :link

  def initialize(team_info)
    @team_id = team_info[:team_id]
    @franchise_id = team_info[:franchiseid]
    @team_name = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @stadium = team_info[:stadium]
    @link = team_info[:link]
  end
end
