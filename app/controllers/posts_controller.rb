class PostsController < ApplicationController
  before_action :finder, only: [:show]
  before_action :set_default_category, only: [:index]
  before_action :set_tags, :set_categories, :set_popular_news, only: [:index, :show]
  # GET /news
  # GET /news.json
  def index
    render 'news_categories/show', locals: {object: @object, posts: @posts, decorated_posts: @decorated_posts, tags: @tags, categories: @categories}
  end

  # GET /news/1
  # GET /news/1.json
  def show
    commontator_thread_show(@object) if @object.is_commentable?
    render 'posts/show', locals: {post: @object, tags: @tags, categories: @categories, popular_news: @popular_news}
  end

  private

  def finder
    @object = Post.finder(params[:id]).try(:first)
    unless @object.present?
      raise ActionController::RoutingError.new('Not Found')
    end
    @object = @object.decorate if @object.present?
  end

  def set_tags
    @tags = ActsAsTaggableOn::Tag.joins(:taggings).most_used
  end


  def set_popular_news
    @popular_news = News.popular_news.decorate
  end

  def set_categories
    @categories = NewsCategory.eager_load(:slug, :main_image).joins(:posts).roots.decorate
  end

  def set_default_category
    @object = CategoryDecorator.decorate NewsCategory.build_default_object
    @posts = News.eager_load(:images, :slug, thread: :comments).latest.page(params[:page])
    @decorated_posts = @posts.decorate
  end

end
