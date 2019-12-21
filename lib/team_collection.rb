require_relative 'team'
require 'csv'

class TeamCollection < Collection
  def initialize(csv_file_path)
    super(csv_file_path, Team)
  end
end
