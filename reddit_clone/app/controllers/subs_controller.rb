class SubsController < ApplicationController
  before_action :is_moderator?, only: [:edit, :update, :destroy]
  before_action :require_logged_in
  
  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find_by(id: params[:id])
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
  end

  def update
    @sub = Sub.find_by(id: params[:id])

    if @sub && @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = ["Invalid sub"]
      render :edit
    end
  end

  def destroy
    @sub = Sub.find_by(id: params[:id])
    if @sub
      @sub.destroy
      redirect_to subs_url
    else
      flash[:errors] = ["Cannot destroy what is not there.."]
      redirect_to subs_url
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def is_moderator?
    current_sub = Sub.find_by(id: params[:id])
    if current_sub.moderator_id != current_user.id
      flash[:errors] = ["Not authorized to change this sub"]
      redirect_to sub_url(current_sub)
    end
  end
end
