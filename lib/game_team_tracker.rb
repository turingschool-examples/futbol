class GameTeamTracker
  attr_reader :games

  def initialize(path)
    @games = create_games(path)
    @path = path
  end

  def create_games(path)
    @games = []
    contents = CSV.open  "#{path}" , headers:true, header_converters: :symbol
    contents.each do |row|
    team_id = row[:team_id]
    game_id = row[:game_id]
    hoa = row[:HoA]
    result = row[:result]
    settled_in = row[:settled_in]
    head_coach = row[:head_coach]
    goals = row[:goals]
    shots = row[:shots]
    tackles = row[:tackles]
    pim = row[:pim]
    powerPlayOpportunities = row[:powerPlayOpportunities]
    powerPlayGoals = row[:powerPlayGoals]
    faceOffWinPercentage = row[:faceOffWinPercentage]
    giveaways = row[:giveaways]
    takeaways = row[:takeaways]
    @games << GameTeam.new(team_id, game_id, hoa, result, settled_in, head_coach, goals, shots, tackles, pim, powerPlayOpportunities, powerPlayGoals, faceOffWinPercentage, giveaways, takeaways)
  end
  @games
end
