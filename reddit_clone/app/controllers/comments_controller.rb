class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @comment.post_id = params[:post_id]
    @comment.author_id = current_user.id
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to post_url(comment.post)
    else
      flash[:errors] = comment.errors.full_messages
      render :new
    end
  end

  def show
    # fail
    @comment = Comment.find_by(id: params[:id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :author_id, :parent_comment_id)
  end
end
