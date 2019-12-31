require 'rails_helper'

RSpec.describe 'Show student', type: :feature do
  let!(:student) { create(:student) }

  scenario 'it has student information' do
    visit students_path
    find_link(href: "/students/#{student.id}").click

    expect(page).to have_content("#{student.name} information:")
    expect(page).to have_content(student.email)
    expect(page).to have_content(student.created_at)
    expect(page).to have_content(student.updated_at)
    expect(page).to have_link(href: "/students/#{student.id}/edit")
    expect(page).to have_link('Delete student')
  end
end
