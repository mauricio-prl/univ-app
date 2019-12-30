require 'rails_helper'

RSpec.describe 'Create a new Course', type: :feature do
  context 'when valid attributes' do
    scenario 'user creates a new course' do
      visit new_course_path
      fill_in 'Course Name', with: 'Test course'
      fill_in 'Code', with: 'TEST123'
      fill_in 'Description', with: 'Some description'
      find("button[type='submit']").click

      expect(page).to have_content('Course successfully created.')
      expect(page).to have_current_path(root_path)
    end
  end

  context 'when invalid attributes' do
    scenario 'page show the errors' do
      visit new_course_path
      fill_in 'Course Name', with: ''
      fill_in 'Code', with: ''
      fill_in 'Description', with: ''
      find("button[type='submit']").click

      expect(page).to have_content('Short name can\'t be blank')
      expect(page).to have_content('Name can\'t be blank')
      expect(page).to have_content('Description can\'t be blank')
    end
  end
end
