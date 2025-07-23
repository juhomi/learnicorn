require 'test_helper'

class Student::CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = users(:student)
    @instructor = users(:instructor)
    @admin = users(:admin)
    @course = courses(:ruby_course)
  end

  test "should require student authentication" do
    get student_courses_path
    assert_redirected_to login_path
  end

  test "should not allow non-student users" do
    post login_path, params: { email: @instructor.email, password: 'password' }
    get student_courses_path
    assert_redirected_to root_path
    assert_equal 'Access denied.', flash[:alert]
  end

  test "should get index for student" do
    post login_path, params: { email: @student.email, password: 'password' }
    get student_courses_path
    assert_response :success
    assert_select 'h1', /courses/i
  end

  test "should show enrolled and available courses" do
    post login_path, params: { email: @student.email, password: 'password' }
    
    # Enroll student in one course
    Enrollment.create!(user: @student, course: @course)
    
    # Create another available course
    available_course = Course.create!(
      title: 'Available Course',
      description: 'Available course description',
      duration: 15,
      instructor: @instructor,
      published: true
    )
    
    get student_courses_path
    assert_response :success
    
    # Should show enrolled course
    assert_select 'h5 a', @course.title
    assert_select 'div', text: /#{@course.title}/
    
    # Should show available course
    assert_select 'h6', text: /Available Courses/
    assert_select 'h6 a', available_course.title
  end

  test "should not show unpublished courses in available" do
    post login_path, params: { email: @student.email, password: 'password' }
    
    # Create unpublished course
    unpublished_course = Course.create!(
      title: 'Unpublished Course',
      description: 'Unpublished course description',
      duration: 15,
      instructor: @instructor,
      published: false
    )
    
    get student_courses_path
    assert_response :success
    
    # Should not show unpublished course
    assert_select 'div', text: /#{unpublished_course.title}/, count: 0
  end

  test "should show course details for enrolled student" do
    post login_path, params: { email: @student.email, password: 'password' }
    
    # Enroll student
    Enrollment.create!(user: @student, course: @course)
    
    get student_course_path(@course)
    assert_response :success
    assert_select 'h3', @course.title
  end

  test "should not show course details for non-enrolled student" do
    post login_path, params: { email: @student.email, password: 'password' }
    
    get student_course_path(@course)
    # Should redirect to root when trying to access non-enrolled course
    assert_redirected_to root_path
    assert_equal 'The requested resource was not found.', flash[:alert]
  end

  test "should show lessons and completion status" do
    post login_path, params: { email: @student.email, password: 'password' }
    
    # Enroll student
    Enrollment.create!(user: @student, course: @course)
    
    # Complete one lesson
    lesson = @course.lessons.first
    LessonCompletion.create!(user: @student, lesson: lesson) if lesson
    
    get student_course_path(@course)
    assert_response :success
    
    # Should show lessons
    @course.lessons.each do |lesson|
      assert_select 'div', text: /#{lesson.title}/
    end
    
    # Should show completion status
    if lesson
      assert_select 'small', text: /Completed/
    end
  end

  test "should show completion percentage" do
    post login_path, params: { email: @student.email, password: 'password' }
    
    # Enroll student
    Enrollment.create!(user: @student, course: @course)
    
    get student_course_path(@course)
    assert_response :success
    
    # Should show completion percentage
    assert_select 'div', text: /progress/i
    assert_select 'div', text: /\d+%/
  end

  test "should show enrollment date" do
    post login_path, params: { email: @student.email, password: 'password' }
    
    # Enroll student
    enrollment = Enrollment.create!(user: @student, course: @course)
    
    get student_course_path(@course)
    assert_response :success
    
    # Should show enrollment date
    assert_select 'p', text: /enrolled.*#{enrollment.enrolled_at.strftime('%B %d, %Y')}/i
  end

  test "should show lessons ordered by position" do
    post login_path, params: { email: @student.email, password: 'password' }
    
    # Enroll student
    Enrollment.create!(user: @student, course: @course)
    
    # Create lessons with different positions (using higher numbers to avoid conflicts with fixtures)
    lesson1 = @course.lessons.create!(title: 'Test Lesson 1', content: 'This is lesson content 1', position: 6)
    lesson2 = @course.lessons.create!(title: 'Test Lesson 2', content: 'This is lesson content 2', position: 4)
    lesson3 = @course.lessons.create!(title: 'Test Lesson 3', content: 'This is lesson content 3', position: 5)
    
    get student_course_path(@course)
    assert_response :success
    
    # Verify lessons are shown in order
    response_body = response.body
    lesson2_pos = response_body.index(lesson2.title)
    lesson3_pos = response_body.index(lesson3.title)
    lesson1_pos = response_body.index(lesson1.title)
    
    assert lesson2_pos < lesson3_pos
    assert lesson3_pos < lesson1_pos
  end

  test "should show correct completion status for multiple lessons" do
    post login_path, params: { email: @student.email, password: 'password' }
    
    # Enroll student
    Enrollment.create!(user: @student, course: @course)
    
    # Create lessons
    lesson1 = @course.lessons.create!(title: 'Lesson 1', content: 'This is lesson content 1', position: 1)
    lesson2 = @course.lessons.create!(title: 'Lesson 2', content: 'This is lesson content 2', position: 2)
    
    # Complete only first lesson
    LessonCompletion.create!(user: @student, lesson: lesson1)
    
    get student_course_path(@course)
    assert_response :success
    
    # Should show first lesson as completed
    assert_select 'div', text: /#{lesson1.title}.*completed/i
    
    # Should show second lesson as not completed
    assert_select 'div', text: /#{lesson2.title}/ do
      assert_select 'span', text: /completed/i, count: 0
    end
  end

  test "should handle course with no lessons" do
    post login_path, params: { email: @student.email, password: 'password' }
    
    # Create course with no lessons
    empty_course = Course.create!(
      title: 'Empty Course',
      description: 'Course with no lessons',
      duration: 10,
      instructor: @instructor,
      published: true
    )
    
    # Enroll student
    Enrollment.create!(user: @student, course: empty_course)
    
    get student_course_path(empty_course)
    assert_response :success
    
    # Should show 0% completion
    assert_select 'div', text: /0%/
  end
end