require 'csv'

class StatTracker
  def self.from_csv(locations)
    all_data_hash = Hash.new
    all_data_hash[:games] = CSV.open locations[:games], headers: true, header_converters: :symbol
    all_data_hash[:teams] = CSV.open locations[:teams], headers: true, header_converters: :symbol
    all_data_hash[:game_teams] = CSV.open locations[:game_teams], headers: true, header_converters: :symbol
    all_data_hash
  end
end