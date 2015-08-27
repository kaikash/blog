# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('document').ready () ->
  $('#new_comment')
  .on 'ajax:success', (event, data, status, xhr) ->
    console.log data
    new_comment data.comment
    $('#comment_text').val ''
    $('.comments-count').each () ->
      $(this).text $(this).text()*1+1
  .on 'ajax:before', () ->
    if $('#comment_text').val().length == 0
      error_comment "Text can't be blank"
      return false
    if $('#comment_text').val().length < 6
      error_comment "Text is too short (minimum is 6 characters)"
      return false
  .on 'ajax:error', (xhr, status, error) ->
    error_comment status.responseJSON.error_message
    console.log status.responseJSON
  $('#comments')
  .on 'click', '.comment-remove', () ->
    _this = $(this).parent().parent()
    _id = _this.attr('data-id')
    $.ajax
      url: "/api/comments/#{_id}"
      type: "DELETE"
    .done (data) ->
      _this.slideUp 600, () ->
        do $(this).remove
      $('.comments-count').each () ->
        $(this).text $(this).text()*1-1
    .fail (data) ->
      error_comment data.responseJSON.error_message


new_comment = (comment) ->
  $('#comments').append "<div class='comment' data-id='#{comment.id}'>
  <div class='comment-top clearfix'>
    <div class='comment-name pull-left'>
      #{comment.user.username}
    </div>
    <div class='comment-date pull-left'>
      #{comment.date}
    </div>
    <div class='comment-likes pull-right'>
      <i class='glyphicon glyphicon-heart'>
        #{comment.likes_count}
      </i>
    </div>
    <div class='comment-remove pull-right'>
      <i class='glyphicon glyphicon-remove'>
      </i>
    </div>
  </div>
  <div class='comment-content'>
    #{comment.text}
  </div>
</div>
"

error_comment = (message) ->
  _elem = $ "<div class='alert alert-danger'>
    <a class='close' data-dismiss='alert'>×</a>
    #{message}
  </div>"

  $('#new-comment-errors').append _elem
  _elem
    .delay 1000
    .slideUp 600, () ->
      do $(this).remove










