# frozen_string_literal: true

class Student < ApplicationRecord
  VALID_EMAIL_REGEX = /.+@.+\..+/.freeze

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
end
