require 'rails_helper'

RSpec.describe 'Delete student',type: :feature do
  let!(:student) { create(:student) }

  scenario 'good' do
    visit student_path(student)
    click_link 'Delete student'

    expect(page).to have_content('Student successfully deleted.')
    expect(page).to have_current_path(students_path)
    expect(page).not_to have_content(student.name)
  end
end
