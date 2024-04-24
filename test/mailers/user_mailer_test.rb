require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:sara)
  end

  test 'welcome' do
    mail = UserMailer.with(user: @user).welcome
    assert_equal('Welcome to Yousell', mail.subject)
    assert_equal([@user.email], mail.to)
    assert_equal(['no-reply@yousell.com'], mail.from)
    assert_match("Welcome to Yousell, #{@user.username}, we hope you sell a lot!", mail.body.encoded)
  end
end
