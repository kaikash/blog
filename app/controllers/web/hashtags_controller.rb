class Web::HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by hashtag: params[:hashtag]
    unless @hashtag ||= Hashtag.new || !@hashtag.articles.any?
      return render :show, status: 404
    end
  end
end
