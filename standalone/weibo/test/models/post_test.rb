require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should have content with minimum of length 1" do
    post = Post.new content: ''
    post.save
    assert post.invalid?
    assert_equal ["can't be blank", 'is too short (minimum is 1 character)'], post.errors[:content]
  end

  test "should have content with maximum of length 140" do
    content = []
    141.times { content << 'a' }
    post = Post.new content: content.join
    post.save
    assert post.invalid?
    assert_equal ['is too long (maximum is 140 characters)'], post.errors[:content]
  end
end
