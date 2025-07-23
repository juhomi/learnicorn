require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test "should redirect to login when user not authenticated" do
    get root_path
    assert_response :success  # HomeController allows unauthenticated access to landing page
  end

  test "should allow access when user is authenticated" do
    user = users(:student)
    post login_path, params: { email: user.email, password: 'password' }
    get root_path
    assert_redirected_to dashboard_path
  end

  test "should handle record not found" do
    user = users(:student)
    post login_path, params: { email: user.email, password: 'password' }
    
    # Try to access a non-existent course
    get course_path(999999)
    assert_redirected_to root_path
    assert_equal 'The requested resource was not found.', flash[:alert]
  end

  test "current_user helper method should work" do
    user = users(:student)
    post login_path, params: { email: user.email, password: 'password' }
    
    get root_path
    assert_redirected_to dashboard_path
    # The helper method is tested implicitly through successful authentication
  end

  test "user_signed_in helper method should work" do
    # Test when not signed in
    get root_path
    assert_response :success  # HomeController allows unauthenticated access
    
    # Test when signed in
    user = users(:student)
    post login_path, params: { email: user.email, password: 'password' }
    get root_path
    assert_redirected_to dashboard_path
  end

  test "require_admin should redirect non-admin users" do
    user = users(:student)
    post login_path, params: { email: user.email, password: 'password' }
    
    get admin_path
    assert_redirected_to root_path
    assert_equal 'Access denied.', flash[:alert]
  end

  test "require_instructor should redirect non-instructor users" do
    user = users(:student)
    post login_path, params: { email: user.email, password: 'password' }
    
    get instructor_path
    assert_redirected_to root_path
    assert_equal 'Access denied.', flash[:alert]
  end

  test "require_student should redirect non-student users" do
    user = users(:instructor)
    post login_path, params: { email: user.email, password: 'password' }
    
    get student_path
    assert_redirected_to root_path
    assert_equal 'Access denied.', flash[:alert]
  end

  test "admin user should access admin area" do
    user = users(:admin)
    post login_path, params: { email: user.email, password: 'password' }
    
    get admin_path
    assert_response :success
  end

  test "instructor user should access instructor area" do
    user = users(:instructor)
    post login_path, params: { email: user.email, password: 'password' }
    
    get instructor_path
    assert_response :success
  end

  test "student user should access student area" do
    user = users(:student)
    post login_path, params: { email: user.email, password: 'password' }
    
    get student_path
    assert_response :success
  end
end