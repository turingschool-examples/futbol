module Digger

  def team(team_id)
    @teams.find {|team| team.id == team_id}
  end

  def game(game_id)
    all_games = []
    @seasons.each {|season| all_games << season.games_by_type.values}
    all_games.flatten.find {|game| game.id == game_id}
  end

end
