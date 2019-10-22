class TeamsCollection
  attr_reader :teams

  def initialize(teams_path)
    @teams = generate_objects_from_csv(teams_path)
  end

  def generate_objects_from_csv(csv_file_path)
    objects = []
    CSV.foreach(csv_file_path, headers: true, header_converters: :symbol) do |row_object|
      objects << Team.new(row_object)
    end
    objects
  end
end
