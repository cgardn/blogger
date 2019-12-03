class ArticlesController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  include ArticlesHelper

  def index
    if (params[:format] == "all" || params[:format] == nil)
      @articles = Article.all
    else
      @articles = Article.all.select{ |a| a.created_at.strftime("%B") == params[:format] }
    end

  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article_id
    if @article.views == nil
      @article.views = 0
    end
    @article.views += 1
    @article.save
  end

  def edit
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    if logged_in?
      @article.created_by = current_user.email
      flash.notice = "Article created by #{current_user.email}"
    end
    @article.save

    #flash.notice = "Article '#{@article.title}' Created!"
    

    redirect_to article_path(@article)
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article '#{@article.title}' Updated!"
    
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash.notice = "Article '#{@article.title}' Deleted!"

    redirect_to articles_path
  end

  def tag_list
    tags.join(', ')
  end

end
