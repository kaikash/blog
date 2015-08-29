class Web::SearchController < ApplicationController
  # def result
    # @search = Search.new
  # end

  def search
    @search = Search.new search_params # logging at database
    @search.user = current_user || nil
    if @search.save
      if @search.query[0] == "#"
        redirect_to web_hashtag_path @search.query[1..-1]
      end

    else
      render :search, status: 400
    end
  end
  private
  def search_params
    params.require(:search).permit :query
  end
end
