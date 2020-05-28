require_relative "./stat_tracker"
require "csv"

class SeasonStatistics < StatTracker

  def games_by_season(season)
    all_rows = CSV.read(@games, :headers=>true, :header_converters=>:symbol)
    all_rows.select do |row|
      row[:season] == season
    end
  end
  
end
