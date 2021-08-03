class Manager
  def load(file_path, object)
    objects = []
    data = CSV.read(@file_path, headers: true)
    data.each do |row| #change this to map later
      new_object = object.new(row)
      objects.push(new_object)
    end
    objects
  end
end
