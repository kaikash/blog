class Api::CommentsController < Api::ApplicationController
  load_and_authorize_resource

  def create
    @comment = Comment.new comment_params
    return render json: {error: 1, message: "No such article"}, status: 404 unless @comment.article 
    @comment.user = current_user
    if @comment.save
      return render json: {error: 0, comment: {id: @comment.id, text: @comment.text, user: {username: @comment.user.username}, date: @comment.date, likes_count: @comment.likes_count}}
    end
    return render json: {error: 1, error_message: @comment.errors.full_messages[0]}, status: 404
  end

  def destroy
    @comment = Comment.find params[:id]
    @comment.destroy

    render json: {error: 0, response: {success: 1}}
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :article_id)
  end
end
