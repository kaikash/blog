class Api::CommentsController < ApplicationController
  def create
    @comment = Comment.new comment_params
    return render json: {error: 1, message: "No such article"} unless @comment.article 
    @comment.user = current_user
    if @comment.save
      return render json: {error: 0, comment: {id: @comment.id, text: @comment.text}}
    end
    return render json: {error: 1, message: "Cannot leave a comment"}
  end

  def destroy
    
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :article_id)
  end
end
