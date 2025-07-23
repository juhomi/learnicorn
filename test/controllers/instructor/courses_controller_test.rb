require 'test_helper'

class Instructor::CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @instructor = users(:instructor)
    @student = users(:student)
    @admin = users(:admin)
    @course = courses(:ruby_course)
  end

  test "should require instructor authentication" do
    get instructor_courses_path
    assert_redirected_to login_path
  end

  test "should not allow non-instructor users" do
    post login_path, params: { email: @student.email, password: 'password' }
    get instructor_courses_path
    assert_redirected_to root_path
    assert_equal 'Access denied.', flash[:alert]
  end

  test "should get index for instructor" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    get instructor_courses_path
    assert_response :success
    assert_select 'h1', /courses/i
  end

  test "should show only instructor's courses in index" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    get instructor_courses_path
    assert_response :success
    
    # Should show instructor's course
    assert_select 'td', @course.title
    
    # Create course for different instructor
    other_instructor = User.create!(
      name: 'Other Instructor',
      email: 'other@example.com',
      password: 'password',
      role: 'instructor'
    )
    other_course = Course.create!(
      title: 'Other Course',
      description: 'Other description',
      duration: 15,
      instructor: other_instructor
    )
    
    get instructor_courses_path
    assert_select 'td', text: other_course.title, count: 0
  end

  test "should show course" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    get instructor_course_path(@course)
    assert_response :success
    assert_select 'h1', @course.title
  end

  test "should show course lessons and students" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    
    # Enroll student
    Enrollment.create!(user: @student, course: @course)
    
    get instructor_course_path(@course)
    assert_response :success
    
    # Should show lessons
    @course.lessons.each do |lesson|
      assert_select 'div', text: /#{lesson.title}/
    end
    
    # Should show enrolled students
    assert_select 'td', @student.name
  end

  test "should not show other instructor's courses" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    
    # Create course for different instructor
    other_instructor = User.create!(
      name: 'Other Instructor',
      email: 'other@example.com',
      password: 'password',
      role: 'instructor'
    )
    other_course = Course.create!(
      title: 'Other Course',
      description: 'Other description',
      duration: 15,
      instructor: other_instructor
    )
    
    assert_raises(ActiveRecord::RecordNotFound) do
      get instructor_course_path(other_course)
    end
  end

  test "should get new" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    get new_instructor_course_path
    assert_response :success
    assert_select 'form'
  end

  test "should create course" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    
    assert_difference 'Course.count' do
      post instructor_courses_path, params: {
        course: {
          title: 'New Course',
          description: 'New course description',
          duration: 20,
          published: true
        }
      }
    end

    course = Course.last
    assert_equal @instructor, course.instructor
    assert_redirected_to instructor_course_path(course)
    assert_equal 'Course created successfully!', flash[:notice]
  end

  test "should not create course with invalid params" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    
    assert_no_difference 'Course.count' do
      post instructor_courses_path, params: {
        course: {
          title: '',
          description: 'Short',
          duration: -1
        }
      }
    end

    assert_response :success
    assert_template :new
  end

  test "should get edit" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    get edit_instructor_course_path(@course)
    assert_response :success
    assert_select 'form'
    assert_select 'input[value=?]', @course.title
  end

  test "should update course" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    
    patch instructor_course_path(@course), params: {
      course: {
        title: 'Updated Title',
        description: 'Updated description',
        duration: 25,
        published: false
      }
    }

    @course.reload
    assert_equal 'Updated Title', @course.title
    assert_equal 'Updated description', @course.description
    assert_equal 25, @course.duration
    assert_equal false, @course.published
    assert_redirected_to instructor_course_path(@course)
    assert_equal 'Course updated successfully!', flash[:notice]
  end

  test "should not update course with invalid params" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    
    patch instructor_course_path(@course), params: {
      course: {
        title: '',
        description: 'Short',
        duration: -1
      }
    }

    assert_response :success
    assert_template :edit
  end

  test "should destroy course" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    
    assert_difference 'Course.count', -1 do
      delete instructor_course_path(@course)
    end

    assert_redirected_to instructor_courses_path
    assert_equal 'Course deleted successfully!', flash[:notice]
  end

  test "should show courses ordered by title" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    
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
    
    get instructor_courses_path
    assert_response :success
    
    # Check that courses appear in alphabetical order
    response_body = response.body
    course_a_pos = response_body.index(course_a.title)
    course_z_pos = response_body.index(course_z.title)
    
    assert course_a_pos < course_z_pos
  end

  test "should include student and lesson counts in index" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    
    # Enroll student
    Enrollment.create!(user: @student, course: @course)
    
    get instructor_courses_path
    assert_response :success
    
    # Should show student count
    assert_select 'td', text: /1.*student/i
    
    # Should show lesson count
    lesson_count = @course.lessons.count
    assert_select 'td', text: /#{lesson_count}.*lesson/i
  end
end