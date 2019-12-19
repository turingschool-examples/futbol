require 'csv'
require_relative 'teams'

class Team
  @@all = []

  def self.all
    @@all
  end

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    @@all = csv.map do |row|
      Item.new(row)
    end
  end

  
end




## Teardown method for minitest
#this can be a self.reset method which makes an empty array again
