# module Averageable
#   def average(amount,total)
#     ((amount / total) * 100).ceil(2)
#   end
# end

module Summable
  def sum_of_goals_each_game
    game_id_hash = @game_teams.group_by do |game_team|
      game_team.game_id
    end

    array_sum_of_goals_each_game = []
    game_id_hash.each_pair do |key, value|
      array_sum_of_goals_each_game << value[0].goals.to_i + value[1].goals.to_i
    end
    array_sum_of_goals_each_game
  end
end
