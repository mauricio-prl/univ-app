require 'rails_helper'

RSpec.describe 'Show Course', type: :feature do
  let!(:course) { create(:course) }

  scenario 'visit by home page' do
    visit root_path
    find_link(href: "/courses/#{course.id}").click

    expect(page).to have_content(course.short_name)
    expect(page).to have_content(course.name)
    expect(page).to have_content(course.description)
    expect(page).to have_content(course.created_at)
    expect(page).to have_content(course.updated_at)
    expect(page).to have_current_path(course_path(course))
  end
end
