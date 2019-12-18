# frozen_string_literal: true

require 'csv'

class TeamCollection
  attr_accessor :team
  attr_reader :team_file_path

  def initialize
    @team_data = nil
    @team_file_path = './data/team.csv'
  end

  def from_csv
    @team_data = CSV.read(@team_file_path, headers: true, header_converters: :symbol)
  end
end
