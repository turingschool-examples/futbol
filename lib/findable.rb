module Findable
  def find_in_sheet(identifier, header, sheet)
    collection = sheet.select do |row|
      row[header] == identifier
    end
  end
end
