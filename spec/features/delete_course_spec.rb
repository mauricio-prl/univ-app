require 'rails_helper'

RSpec.describe 'Destroy course', type: :feature do
  let!(:course) { create(:course) }

  scenario 'good' do
    visit course_path(course)
    click_link 'Delete Course'

    expect(page).to have_content('Course successfully deleted.')
    expect(page).to have_current_path(root_path)
    expect(page).not_to have_content(course.name)
  end
end
