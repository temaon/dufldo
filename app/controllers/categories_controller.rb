class CategoriesController <  ApplicationController
  before_action :finder
  before_action :get_template_path, only: :show
  before_action :set_tags, :set_popular_news, :set_categories, only: [:show]

  def show
    respond_to do |format|
      format.html do
        render @template, locals: {object: @object, posts: @posts, tags: @tags, categories: @categories, popular_news: @popular_news}
      end
      format.js do
        render "#{@template}_filtered_posts", locals: {object: @object, posts: @posts}
      end
    end

  end

  private

  def finder
    @object = Category.slugable.finder(params[:id])
    @object = @object.first.try(:decorate) if (@object.present?)
    @posts = is_filter? ? @object.posts.by_date(params[:day], params[:month], params[:year]).page(params[:page]) : @object.posts.page(params[:page])
  end

  def get_template_path
    @template = @object.present? ? "#{@object.object.class.to_s.tableize}/show" : 'categpories/show'
  end

  def set_tags
    @tags = ActsAsTaggableOn::Tag.joins(:taggings).most_used
  end

  def set_popular_news
    @popular_news = News.popular_news.decorate
  end

  def set_categories
    @categories = Category.where(type: @object.object.class.name).roots.all.decorate
  end

  def is_filter?
    params[:day] || params[:year] || params[:month]
  end

end