# frozen_string_literal: true

require 'csv'

class TeamCollection
  attr_accessor :teams
  attr_reader :teams_file_path

  def initialize
    @teams = nil
    @teams_file_path = './data/teams.csv'
  end

  def from_csv
    @teams = CSV.read(@teams_file_path, headers: true, header_converters: :symbol)
  end
end
