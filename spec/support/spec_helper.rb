module SpecHelper
  def login(student)
    session[:student_id] = student.id
  end

  def sign_in(student)
    visit login_path
    fill_in 'Email', with: student.email
    fill_in 'Password', with: student.password
    click_button 'Login'
  end

  def add_course_to_student(course, student)
    student.courses << course
  end

  def enroll(course)
    visit root_path
    find_link(href: "/course_enroll?course_id=#{course.id}").click
  end

  def logout(student)
    within('#nav-mobile') do
      find_link('Account').click
    end
    within('#dropdown1') do
      find_link('Logout').click
    end
  end
end
