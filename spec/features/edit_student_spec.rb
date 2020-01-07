require 'rails_helper'

RSpec.describe 'Edit student', type: :feature do
  let!(:student) { create(:student) }

  context 'when signed in' do
    before do
      sign_in(student)
    end

    scenario 'good - valid attributes' do
      visit students_path
      within('.col.s4.m4') do
        find_link(href: "/students/#{student.id}").click
      end
      click_link 'Edit student'
      fill_in 'Name', with: 'New name'
      fill_in 'Email', with: 'new_email@example.com'
      fill_in 'Password', with: 'new-password'
      fill_in 'Password confirmation', with: 'new-password'
      find("button[type='submit']").click

      expect(page).to have_content('Student successfully updated.')
      expect(page).to have_current_path(student_path(student))
    end

    scenario 'good - changes the password' do
      visit students_path
      within('.col.s4.m4') do
        find_link(href: "/students/#{student.id}").click
      end
      click_link 'Edit student'
      fill_in 'Password', with: 'new-password'
      fill_in 'Password confirmation', with: 'new-password'
      find("button[type='submit']").click

      expect(page).to have_content('Student successfully updated.')
      expect(page).to have_current_path(student_path(student))
    end

    scenario 'good - through navbar link' do
      visit root_path
      within('#nav-mobile') do
        find_link('Account').click
      end
      within('#dropdown1') do
        find_link(href: "/students/#{student.id}/edit").click
      end

      expect(page).to have_current_path(edit_student_path(student))
    end

    scenario 'bad - invald atributes' do
      visit students_path
      within('.col.s4.m4') do
        find_link(href: "/students/#{student.id}").click
      end
      click_link 'Edit student'
      fill_in 'Name', with: ''
      fill_in 'Email', with: 'invalid_email.something.@com'
      fill_in 'Password', with: ''
      fill_in 'Password confirmation', with: ''
      find("button[type='submit']").click

      expect(page).to have_content('Name can\'t be blank')
      expect(page).to have_content('Email is invalid')
    end
  end

  context 'when not signed in' do
    scenario 'it show the require user message' do
      visit edit_student_path(student)

      expect(page).to have_content('You must be logged in to perform that.')
      expect(page).to have_current_path(login_path)
    end
  end
end
