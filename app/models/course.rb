# frozen_string_literal: true

class Course < ApplicationRecord
  validates :short_name, :name, presence: true, uniqueness: true
  validates :description, presence: true
end
