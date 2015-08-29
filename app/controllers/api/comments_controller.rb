class Api::CommentsController < Api::ApplicationController
  load_and_authorize_resource

  def create
    @comment = Comment.new comment_params
    return render json: {error: 1, message: "No such article"}, status: 404 unless @comment.article 
    @comment.user = current_user
    if @comment.save 
      _json =
      @comment.as_json(
        root: true,
        methods: :date, 
        include: {
          user: {
            only: [
              :name,
              :surname
            ],
            methods: :fullname
          }
        }
      )
      _json[:error] = 0
      return render json: _json
    end
    return render json: {error: 1, error_message: @comment.errors.full_messages[0]}, status: 404
  end

  def destroy
    @comment = Comment.find params[:id]
    if @comment.destroy
      return render json: {error: 0, response: {success: 1}}, status: 204
    end
    render json: {error: 1, error_message: "Error has occured."}
  end

  private
  def comment_params
    params.require(:comment).permit(:text, :article_id)
  end
end
