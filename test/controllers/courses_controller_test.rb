require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @course = courses(:ruby_course)
    @student = users(:student)
    @instructor = users(:instructor)
  end

  test "should get index without authentication" do
    get courses_path
    assert_response :success
    assert_select 'h1', /courses/i
  end

  test "should show only published courses in index" do
    get courses_path
    assert_response :success
    
    # Should show published courses
    assert_select 'h5 a', text: @course.title
    
    # Create unpublished course and ensure it's not shown
    unpublished_course = Course.create!(
      title: 'Unpublished Course',
      description: 'This should not appear',
      duration: 10,
      instructor: @instructor,
      published: false
    )
    
    get courses_path
    assert_select 'div', text: /#{unpublished_course.title}/, count: 0
  end

  test "should show course details" do
    get course_path(@course)
    assert_response :success
    assert_select 'h2', @course.title
    assert_select 'p.lead', @course.description
  end

  test "should show course lessons when authenticated" do
    post login_path, params: { email: @student.email, password: 'password' }
    get course_path(@course)
    assert_response :success
    
    # Should show lessons
    @course.lessons.each do |lesson|
      assert_select 'div', text: /#{lesson.title}/
    end
  end

  test "should show enroll button for students not enrolled" do
    post login_path, params: { email: @student.email, password: 'password' }
    get course_path(@course)
    assert_response :success
    assert_select 'form[action=?]', enroll_course_path(@course)
  end

  test "should not show enroll button for enrolled students" do
    # Enroll student first
    Enrollment.create!(user: @student, course: @course)
    
    post login_path, params: { email: @student.email, password: 'password' }
    get course_path(@course)
    assert_response :success
    assert_select 'form[action=?]', enroll_course_path(@course), count: 0
  end

  test "should not show enroll button for instructors" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    get course_path(@course)
    assert_response :success
    assert_select 'form[action=?]', enroll_course_path(@course), count: 0
  end

  test "should enroll student in course" do
    post login_path, params: { email: @student.email, password: 'password' }
    
    assert_difference 'Enrollment.count' do
      post enroll_course_path(@course)
    end
    
    assert_redirected_to student_course_path(@course)
    assert_equal 'Successfully enrolled in the course!', flash[:notice]
  end

  test "should not enroll student twice in same course" do
    # Enroll student first
    Enrollment.create!(user: @student, course: @course)
    
    post login_path, params: { email: @student.email, password: 'password' }
    
    assert_no_difference 'Enrollment.count' do
      post enroll_course_path(@course)
    end
    
    assert_redirected_to course_path(@course)
    assert_equal 'You are already enrolled in this course.', flash[:alert]
  end

  test "should not allow non-students to enroll" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    
    assert_no_difference 'Enrollment.count' do
      post enroll_course_path(@course)
    end
    
    assert_redirected_to root_path
    assert_equal 'Access denied.', flash[:alert]
  end

  test "should not allow unauthenticated users to enroll" do
    assert_no_difference 'Enrollment.count' do
      post enroll_course_path(@course)
    end
    
    assert_redirected_to login_path
    assert_equal 'Please log in to access this page.', flash[:alert]
  end

  test "should handle enrollment with invalid course" do
    post login_path, params: { email: @student.email, password: 'password' }
    
    post enroll_course_path(999999)
    assert_redirected_to root_path
    assert_equal 'The requested resource was not found.', flash[:alert]
  end

  test "should show course with lessons ordered by position" do
    # Create lessons with different positions (using higher numbers to avoid conflicts with fixtures)
    lesson1 = @course.lessons.create!(title: 'Test Lesson A', content: 'This is lesson content A', position: 6)
    lesson2 = @course.lessons.create!(title: 'Test Lesson B', content: 'This is lesson content B', position: 4)
    lesson3 = @course.lessons.create!(title: 'Test Lesson C', content: 'This is lesson content C', position: 5)
    
    get course_path(@course)
    assert_response :success
    
    # Verify lessons are shown in order (lesson2=pos4, lesson3=pos5, lesson1=pos6)
    response_body = response.body
    lesson2_pos = response_body.index(lesson2.title)
    lesson3_pos = response_body.index(lesson3.title)
    lesson1_pos = response_body.index(lesson1.title)
    
    assert lesson2_pos < lesson3_pos, "Lesson B (pos 4) should appear before Lesson C (pos 5)"
    assert lesson3_pos < lesson1_pos, "Lesson C (pos 5) should appear before Lesson A (pos 6)"
  end
end