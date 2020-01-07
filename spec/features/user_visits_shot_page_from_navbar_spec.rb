require 'rails_helper'

RSpec.describe 'user visists show page from navbar', type: :feature do
  let!(:student) { create(:student) }

  scenario 'good - logged in' do
    sign_in(student)
    visit root_path
    within('#nav-mobile') do
      find_link('Account').click
    end
    within('#dropdown1') do
      find_link(href: "/students/#{student.id}").click
    end

    expect(page).to have_current_path(student_path(student))
  end
end
