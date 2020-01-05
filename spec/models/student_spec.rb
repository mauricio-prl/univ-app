require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { create(:student); is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.not_to allow_value('invalid_email.exemple.com').for(:email) }
    it { is_expected.to allow_value('valid_email@exemple.com').for(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:courses) }
  end
end
