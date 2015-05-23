require 'test_helper'

class SystemNotifierTest < ActionMailer::TestCase
  test "error" do
    mail = SystemNotifier.error "Something went wrong"
    assert_equal "System Error", mail.subject
    assert_equal ["support@depot.com"], mail.to
    assert_equal ["system@depot.com"], mail.from
    assert_match "Something went wrong", mail.body.encoded
  end

end
