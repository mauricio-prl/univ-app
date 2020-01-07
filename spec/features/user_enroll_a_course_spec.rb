require 'rails_helper'

RSpec.describe 'User enroll a course', type: :feature do
  let!(:student) { create(:student) }
  let!(:course) { create(:course) }

  scenario 'good' do
    sign_in(student)
    visit root_path
    find_link(href: "/course_enroll?course_id=#{course.id}").click

    expect(page).to have_content("You was successfully enrolled in #{course.name}.")
  end

  scenario 'bad - not logged in' do
    visit root_path

    expect(page).to have_content(course.name)
    expect(page).not_to have_link('Enroll')
  end

  scenario 'bad - user is already enrolled that course' do
    sign_in(student)
    enroll(course)
    visit root_path
    
    expect(page).not_to have_link('Enroll')
  end
end
