require 'rails_helper'

RSpec.describe StudentCoursesController, type: :controller do
  describe 'POST #create' do
    let!(:student) { create(:student) }
    let!(:course) { create(:course) }
    
    context 'when logged in and student has not enrolled the course yet' do
      subject { 
        post :create, params: {
          course_id: course.id
        }
      }

      before do
        login(student)
      end

      it 'enrolls the course to student' do
        subject

        expect(student.courses).to include(course)
      end

      it 'has flash[:notice]' do
        subject

        expect(flash[:notice]).to eq("You was successfully enrolled in #{course.name}.")
      end
    end

    context 'when the student already is enrolled to that course' do
      subject { 
        post :create, params: {
          course_id: course.id,
        }
      }

      before do
        login(student)
        add_course_to_student(course, student)
      end

      it 'has flash[:alert]' do
        subject

        expect(flash[:alert]).to eq('You already had enrolled this course.')
      end

      it 'redirects to root' do
        subject

        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:student) { create(:student) }
    let!(:course) { create(:course) }

    context 'when the user enroll the course' do
      subject {
        delete :destroy, params: {
          course_id: course.id
        }
      }

      before do
        login(student)
        add_course_to_student(course, student)
      end

      it 'remove the course from student courses' do
        subject
        student.reload

        expect(student.courses).not_to include(course)
      end

      it 'has flash[:notice]' do
        subject

        expect(flash[:notice]).to eq(
          "#{course.name} was successfully removed from your enrollments."
        )
      end

      it 'redirects to student' do
        subject

        expect(response).to redirect_to(student_path(student))
      end
    end

    context 'when user does not have enrolled the course.' do
      subject {
        delete :destroy, params: {
          course_id: course.id
        }
      }

      before do
        login(student)
      end

      it 'has flash[:alert]' do
        subject

        expect(flash[:alert]).to eq('You had not enrolled this course yet.')
      end

      it 'redirects to root' do
        subject

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
