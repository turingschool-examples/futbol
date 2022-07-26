class Teams
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.create_multiple_teams(teams)
    teams.map do |team|
      new_team = Teams.new(teams[:name])
    end
  end


end
