require './lib/game'
require 'csv'

# def initialize(csv_file_path)
#     @merchants = create_merchants(csv_file_path)
#   end
#
#   def create_merchants(csv_file_path)
#     csv = CSV.read("#{csv_file_path}", headers: true, header_converters: :symbol)
#     csv.map do |row|
#        Merchant.new(row)
#     end
#   end
