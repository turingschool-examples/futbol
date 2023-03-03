module Offensive

  def offensive
    offense = Hash.new {|hash, key| hash[key] = []}
    @games.map do |game|
      offense[game.away_team_id] << game.away_goals
      offense[game.home_team_id] << game.home_goals
    end
    average = {}
    offense.each do |id, goals|
      average[id] = goals.sum / goals.count.to_f
    end
    average
  end
end
