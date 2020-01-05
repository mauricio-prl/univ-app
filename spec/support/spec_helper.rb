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
end
