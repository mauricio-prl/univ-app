require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:short_name) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { create(:course); is_expected.to validate_uniqueness_of(:short_name) }
    it { create(:course); is_expected.to validate_uniqueness_of(:name) }
  end
end
