require 'rails_helper'

RSpec.describe 'Show student', type: :feature do
  let!(:student) { create(:student) }

  context 'when user is logged in and visits your own account' do
    before do
      sign_in(student)
    end

    scenario 'it has student information' do
      visit students_path
      within('.col.s4.m4') do
        find_link(href: "/students/#{student.id}").click
      end

      expect(page).to have_content("#{student.name} information:")
      expect(page).to have_content(student.email)
      expect(page).to have_content(student.created_at)
      expect(page).to have_content(student.updated_at)
      expect(page).to have_link(href: "/students/#{student.id}/edit")
      expect(page).to have_link('Delete student')
    end
  end

  context 'when user is not logged in' do
    scenario 'it has not edit and delete buttons' do
      visit student_path(student)

      expect(page).to have_content('You must be logged in to perform that.')
      expect(page).to have_current_path(login_path)
    end
  end

  context 'when user is logged but visit another account' do
    let!(:other_student) { create(:student) }

    before do
      sign_in(student)
    end

    scenario 'it has not edit and delete buttons' do
      visit students_path
      find_link(href: "/students/#{other_student.id}").click

      expect(page).to have_content("#{other_student.name} information:")
      expect(page).to have_content(other_student.email)
      expect(page).to have_content(other_student.created_at)
      expect(page).to have_content(other_student.updated_at)
      expect(page).not_to have_link(href: "/students/#{other_student.id}/edit")
      expect(page).not_to have_link('Delete student')
    end
  end
end
