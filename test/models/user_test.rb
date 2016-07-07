require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar12", password_confirmation: "foobar12")
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '   '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '   '
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 101
    assert_not @user.valid?
  end

  test 'email should be valid' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US_ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.com]
    valid_addresses.each do |valid|
      @user.email = valid
      assert @user.valid?, "#{valid.inspect} should be valid"
    end
  end

  test 'email should be rejected if invalid' do
    invalid_addresses = %w[user@example,com USER_at_foo.COM
                           A_US_ER@foo. first@foo_baz.jp alice@foo+baz.com]
    invalid_addresses.each do |invalid|
      @user.email = invalid
      assert @user.invalid?, "#{invalid.inspect} should be invalid"
    end
  end

  test 'email should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email address should be saved as lower-case' do
    email = "FoO@ExAmPlE.CoM"
    @user.email = email
    @user.save
    assert_equal email.downcase, @user.reload.email
  end

  test 'password should be present' do
    @user.password = @user.password_confirmation = " " * 8
    assert_not @user.valid?
  end

  test 'password should have a min length' do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end

end
