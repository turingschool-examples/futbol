class Futbol
  attr_reader :games,
              :teams,
              :game_teams
  
  def initalize(locations)
    @games = (CSV.open locations[:games], headers: true, header_converters: :symbol).map { |game| Game.new(game) } 
    @teams = (CSV.open locations[:teams], headers: true, header_converters: :symbol).map { |team| Team.new(team) } 
    @game_teams = (CSV.open locations[:game_teams], headers: true, header_converters: :symbol).map { |game_team| Game.new(game_team) } 
  end

end