require 'rails_helper'

RSpec.describe 'home page', type: :feature do
  let!(:course) { create(:course) }

  scenario 'show the courses' do
    visit root_path

    expect(page).to have_content('Course Listing')
    expect(page).to have_content(course.name)
    expect(page).to have_content(course.short_name)
    expect(page).to have_content(course.description)
    expect(page).to have_link(href: "/courses/#{course.id}")
  end
end
