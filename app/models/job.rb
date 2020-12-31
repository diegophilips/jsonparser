# frozen_string_literal: true

class Job < ApplicationRecord
  validates :title, :description, :location, presence: true
  validates :job_number, uniqueness: true
end
