class Manager
  def load(file_path, object)
    data = CSV.read(@file_path, headers: true)
    data.map do |row|
      object.new(row)
    end
  end
end
