require 'test_helper'

class Admin::CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:admin)
    @instructor = users(:instructor)
    @student = users(:student)
    @course = courses(:ruby_course)
  end

  test "should require admin authentication" do
    get admin_courses_path
    assert_redirected_to login_path
  end

  test "should not allow non-admin users" do
    post login_path, params: { email: @student.email, password: 'password' }
    get admin_courses_path
    assert_redirected_to root_path
    assert_equal 'Access denied.', flash[:alert]
  end

  test "should get index for admin" do
    post login_path, params: { email: @admin.email, password: 'password' }
    get admin_courses_path
    assert_response :success
    assert_select 'h1', /courses/i
  end

  test "should show all courses in index" do
    post login_path, params: { email: @admin.email, password: 'password' }
    get admin_courses_path
    assert_response :success
    
    # Should show course title
    assert_select 'td', @course.title
    assert_select 'td', @course.instructor.name
  end

  test "should show course" do
    post login_path, params: { email: @admin.email, password: 'password' }
    get admin_course_path(@course)
    assert_response :success
    assert_select 'h3', @course.title
  end

  test "should get new" do
    post login_path, params: { email: @admin.email, password: 'password' }
    get new_admin_course_path
    assert_response :success
    assert_select 'form'
    assert_select 'select#course_instructor_id'
  end

  test "should create course" do
    post login_path, params: { email: @admin.email, password: 'password' }
    
    assert_difference 'Course.count' do
      post admin_courses_path, params: {
        course: {
          title: 'New Course',
          description: 'New course description',
          duration: 20,
          instructor_id: @instructor.id,
          published: true
        }
      }
    end

    course = Course.last
    assert_redirected_to admin_course_path(course)
    assert_equal 'Course created successfully!', flash[:notice]
  end

  test "should not create course with invalid params" do
    post login_path, params: { email: @admin.email, password: 'password' }
    
    assert_no_difference 'Course.count' do
      post admin_courses_path, params: {
        course: {
          title: '',
          description: 'Short',
          duration: -1,
          instructor_id: @instructor.id
        }
      }
    end

    assert_response :success
    # Template rendering verified by successful response
    assert_select 'select#course_instructor_id'
  end

  test "should get edit" do
    post login_path, params: { email: @admin.email, password: 'password' }
    get edit_admin_course_path(@course)
    assert_response :success
    assert_select 'form'
    assert_select 'input[value=?]', @course.title
  end

  test "should update course" do
    post login_path, params: { email: @admin.email, password: 'password' }
    
    patch admin_course_path(@course), params: {
      course: {
        title: 'Updated Title',
        description: 'Updated description',
        duration: 25,
        instructor_id: @instructor.id,
        published: false
      }
    }

    @course.reload
    assert_equal 'Updated Title', @course.title
    assert_equal 'Updated description', @course.description
    assert_equal 25, @course.duration
    assert_equal false, @course.published
    assert_redirected_to admin_course_path(@course)
    assert_equal 'Course updated successfully!', flash[:notice]
  end

  test "should not update course with invalid params" do
    post login_path, params: { email: @admin.email, password: 'password' }
    
    patch admin_course_path(@course), params: {
      course: {
        title: '',
        description: 'Short',
        duration: -1,
        instructor_id: @instructor.id
      }
    }

    assert_response :success
    # Template rendering verified by successful response
    assert_select 'select#course_instructor_id'
  end

  test "should destroy course" do
    post login_path, params: { email: @admin.email, password: 'password' }
    
    assert_difference 'Course.count', -1 do
      delete admin_course_path(@course)
    end

    assert_redirected_to admin_courses_path
    assert_equal 'Course deleted successfully!', flash[:notice]
  end

  test "should handle course with enrollments on destroy" do
    post login_path, params: { email: @admin.email, password: 'password' }
    
    # Create enrollment
    Enrollment.create!(user: @student, course: @course)
    
    assert_difference 'Course.count', -1 do
      assert_difference 'Enrollment.count', -1 do
        delete admin_course_path(@course)
      end
    end

    assert_redirected_to admin_courses_path
    assert_equal 'Course deleted successfully!', flash[:notice]
  end

  test "should load instructors for new and edit forms" do
    post login_path, params: { email: @admin.email, password: 'password' }
    
    get new_admin_course_path
    assert_response :success
    assert_select 'select#course_instructor_id' do
      assert_select 'option[value=?]', @instructor.id.to_s
    end
    
    get edit_admin_course_path(@course)
    assert_response :success
    assert_select 'select#course_instructor_id' do
      assert_select 'option[value=?]', @instructor.id.to_s
    end
  end

  test "should order courses by title in index" do
    post login_path, params: { email: @admin.email, password: 'password' }
    
    # Create courses with different titles
    course_a = Course.create!(
      title: 'AAA Course',
      description: 'Description A',
      duration: 10,
      instructor: @instructor
    )
    course_z = Course.create!(
      title: 'ZZZ Course',
      description: 'Description Z',
      duration: 10,
      instructor: @instructor
    )
    
    get admin_courses_path
    assert_response :success
    
    # Check that courses appear in alphabetical order
    response_body = response.body
    course_a_pos = response_body.index(course_a.title)
    course_z_pos = response_body.index(course_z.title)
    
    assert course_a_pos < course_z_pos
  end
end