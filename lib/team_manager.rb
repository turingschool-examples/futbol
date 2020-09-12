class TeamManager
  attr_reader :teams, :tracker #do we need attr_reader?
  def initialize(path, tracker)
    @teams = []
    @tracker = tracker
    create_teams(path)
  end

  def create_teams(path)
    teams_data = CSV.read(path, headers:true) #may need to change .read to .load
    @teams = teams_data.map do |data|
      Team.new(data, self)
    end
  end
end
