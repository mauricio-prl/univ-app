require 'rails_helper'

RSpec.describe 'Edit course', type: :feature do
  let!(:course) { create(:course) }
  let!(:other_course) { create(:course, short_name: '123') }

  context 'when valid attributes' do
    scenario 'good' do
      visit edit_course_path(course)

      edit_course
    end
  end

  context 'when invalid attributes' do
    scenario 'bad' do
      visit edit_course_path(course)
      expect(page).to have_content(course.name)
      fill_in 'Course Name', with: ''
      fill_in 'Code', with: other_course.short_name
      fill_in 'Description', with: ''
      find("button[type='submit']").click

      expect(page).to have_content('Name can\'t be blank')
      expect(page).to have_content('Short name has already been taken')
      expect(page).to have_content('Description can\'t be blank')
    end
  end

  context 'when visit from root' do
    scenario 'good' do
      visit root_path
      find_link(href: "/courses/#{course.id}").click
      expect(page).to have_current_path(course_path(course))
      find_link(href: "/courses/#{course.id}/edit").click

      edit_course
    end
  end

  def edit_course
    expect(page).to have_content(course.name)
    fill_in 'Course Name', with: 'New name'
    fill_in 'Code', with: 'NEWCODE'
    fill_in 'Description', with: 'New description'
    find("button[type='submit']").click

    expect(page).to have_content('Course successfully updated.')
    expect(page).to have_current_path(course_path(course))
  end
end
