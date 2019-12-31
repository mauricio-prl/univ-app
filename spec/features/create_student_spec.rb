require 'rails_helper'

RSpec.describe 'Create student', type: :feature do
  scenario 'good - with valid attributes' do
    visit root_path
    within('#nav-mobile') do
      find_link('Account').click
    end
    within('#dropdown1') do
      find_link('Sign up').click
    end
    expect(page).to have_current_path(new_student_path)
    fill_in 'Student Name', with: 'Student'
    fill_in 'Email', with: 'student@email.com'
    fill_in 'Password', with: 'password'
    find("button[type='submit']").click

    expect(page).to have_content('Student successfully created.')
    expect(page).to have_current_path(students_path)
  end

  scenario 'bad - invalid attributes' do
    visit root_path
    within('#nav-mobile') do
      find_link('Account').click
    end
    within('#dropdown1') do
      find_link('Sign up').click
    end
    expect(page).to have_current_path(new_student_path)
    find("button[type='submit']").click

    expect(page).to have_content('Name can\'t be blank')
    expect(page).to have_content('Email is invalid')
    expect(page).to have_content('Password can\'t be blank')
  end
end
