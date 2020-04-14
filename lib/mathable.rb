module Mathable

  def average(num1, num2)
    (num1 / num2).round(2)
  end

  def group_by_season
    game_collection.group_by do |game|
      game.season
    end
  end

  # def home_away_or_tie(arg)
  #   if arg == "home" || arg == "away"
  #     @game_teams_collection.find_all do |game|
  #      game.home_or_away == arg
  #    end
  #   else
  #     @game_teams_collection.find_all do |game|
  #       game.result  == "TIE"
  #     end
  #   end
  # end

end
