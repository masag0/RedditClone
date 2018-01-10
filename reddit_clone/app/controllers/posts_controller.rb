class PostsController < ApplicationController
  before_action :is_author?, only: [:edit, :update, :destroy]
  before_action :require_logged_in

  # def new
  #   @post = Post.new
  #   @post.sub_id = sub_id
  # end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @post = Post.find_by(id: params[:id])

    if @post && @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = ["Invalid Post"]
      render :edit
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @all_comments = @post.comments_by_parent_id
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    if @post && @post.destroy
      redirect_to subs_url(@post.sub_id)
    else
      flash[:errors] = ["You cannot destroy what is not there"]
      redirect_to post_url(@post)
    end
  end

  private

  def is_author?
    post = Post.find_by(id: params[:id])
    if post.author_id != current_user.id
      flash[:errors] = ["Not authorized to change post"]
      redirect_to post_url(post)
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
