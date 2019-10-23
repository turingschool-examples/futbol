require './lib/game_team'


class GameTeamCollection
  attr_reader :game_team

  def initialize(csv_file_path)
    @game_team = create_game_team(csv_file_path)
  end

  # def create_merchants(csv_file_path)
  #   csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
  #
  #   csv.map do |row|
  #      Merchant.new(row)
  #   end
  # end
  #
  # def all_merchants
  #   @merchants
  # end
  #
  # def find(id)
  #   all_merchants.find do |merchant|
  #     merchant.id == id
  #   end
  # end
end
