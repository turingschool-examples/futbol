module Listable
  def games_by_season(season, csv_table)
    csv_table.find_all do |game|
      game.game_id.to_s[0..3] == season[0..3]
    end
  end
end
