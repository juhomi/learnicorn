require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path
    assert_response :success
    assert_select 'form'
  end

  test "should redirect to root if already signed in" do
    user = users(:student)
    post login_path, params: { email: user.email, password: 'password' }
    
    get signup_path
    assert_redirected_to root_path
  end

  test "should create user with valid params" do
    assert_difference 'User.count' do
      post signup_path, params: {
        user: {
          name: 'New User',
          email: 'newuser@example.com',
          password: 'password',
          password_confirmation: 'password',
          role: 'student'
        }
      }
    end

    assert_redirected_to root_path
    assert_equal 'Account created successfully!', flash[:notice]
    assert_not_nil session[:user_id]
  end

  test "should not create user with invalid params" do
    assert_no_difference 'User.count' do
      post signup_path, params: {
        user: {
          name: '',
          email: 'invalid-email',
          password: 'pass',
          password_confirmation: 'different',
          role: 'student'
        }
      }
    end

    assert_response :success
    assert_template :new
  end

  test "should not create user with duplicate email" do
    existing_user = users(:student)
    
    assert_no_difference 'User.count' do
      post signup_path, params: {
        user: {
          name: 'New User',
          email: existing_user.email,
          password: 'password',
          password_confirmation: 'password',
          role: 'student'
        }
      }
    end

    assert_response :success
    assert_template :new
  end

  test "should not create user with mismatched password confirmation" do
    assert_no_difference 'User.count' do
      post signup_path, params: {
        user: {
          name: 'New User',
          email: 'newuser@example.com',
          password: 'password',
          password_confirmation: 'different',
          role: 'student'
        }
      }
    end

    assert_response :success
    assert_template :new
  end

  test "should automatically log in user after successful signup" do
    post signup_path, params: {
      user: {
        name: 'New User',
        email: 'newuser@example.com',
        password: 'password',
        password_confirmation: 'password',
        role: 'student'
      }
    }

    user = User.find_by(email: 'newuser@example.com')
    assert_equal user.id, session[:user_id]
  end

  test "should handle role parameter correctly" do
    post signup_path, params: {
      user: {
        name: 'New Instructor',
        email: 'instructor@example.com',
        password: 'password',
        password_confirmation: 'password',
        role: 'instructor'
      }
    }

    user = User.find_by(email: 'instructor@example.com')
    assert_equal 'instructor', user.role
  end
end