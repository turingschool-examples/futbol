require "CSV"

class Season
attr_reader :id, :games_in_season

  def initialize(season_info)
    @id = season_info[:id]
    # @games_in_season = games_getter(season_info[:path])
  end

  def count_of_games_by_season
		games_by_season = {}
		@seasons.each {|season| games_by_season[season.id.to_s] = season.total_games}
		games_by_season
	end

 #  def games_getter
 #  game_sorted = Hash.new { |hash, key| hash[key] = [] }
 #   CSV.foreach(games_path, :headers => true, header_converters: :symbol) do |row|
 #     if row[1] == @id
 #       game_sort_hash[(row[2])].push(row[0])
 #     end
 #   end
 #   games_sorted
 # end
end
