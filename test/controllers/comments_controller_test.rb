require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # @comment = create(:comment)
    @comment = comments(:default)
    # @comment = create(:comment, post: posts(:default), user: users(:default))
  end

  500.times do |i|
    test "should create comment #{i}" do
      assert_difference('Comment.count') do
        post comments_url,
             params: { comment: { post_id: @comment.post_id, text: @comment.text, user_id: @comment.user_id } }
      end

      assert_redirected_to comment_url(Comment.last)
    end

    test "should show comment #{i}" do
      get comment_url(@comment)
      assert_response :success
    end

    test "should update comment #{i}" do
      patch comment_url(@comment),
            params: { comment: { post_id: @comment.post_id, text: @comment.text, user_id: @comment.user_id } }
      assert_redirected_to comment_url(@comment)
    end

    test "should destroy comment #{i}" do
      assert_difference('Comment.count', -1) do
        delete comment_url(@comment)
      end

      assert_redirected_to comments_url
    end
  end
end
