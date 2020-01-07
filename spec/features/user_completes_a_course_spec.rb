require 'rails_helper'

RSpec.describe 'User completes a course', type: :feature do
  let!(:student) { create(:student) }
  let!(:course) { create(:course) }

  before do
    sign_in(student)
    enroll(course)
  end

  scenario 'good' do
    visit student_path(student)
    expect(page).to have_content('Course enrollments')
    expect(page).to have_link(course.name)
    find_link(href: "/course_enroll?course_id=#{course.id}").click

    expect(page).to have_content(
      "#{course.name} was successfully removed from your enrollments."
    )
  end

  scenario 'bad - not logged in' do
    logout(student)
    visit student_path(student)

    expect(page).to have_content('You must be logged in to perform that.')
  end
end
