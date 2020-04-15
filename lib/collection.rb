require "csv"
class Collection

  def self.from_csv(file_path, class_name)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    @all = csv.map do |row|
      class_name.new(row)
    end
  end

  def self.all
    @all
  end

  def self.find_by(id)
    all.find_all{|game| game.game_id==id}
  end
end
