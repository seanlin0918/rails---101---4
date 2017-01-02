class PostsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def edit
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

  def destroy
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])

    if @post.destroy
      redirect_to account_posts_path(@group), alert: "Post deleted"
    else
      render :edit
    end
  end

  def update
    @group = Group.find(params[:group_id])
    @post = Post.find(params[:id])
    @post.update(post_params)
    flash[:notice] = "Update success"

    redirect_to account_posts_path(@group)
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

end
