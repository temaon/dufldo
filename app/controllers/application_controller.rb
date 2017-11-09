class ApplicationController < ActionController::Base

  SEARCHABLE_CLASSES = [News, Team]

  after_filter :set_impressionist, only: [:show]

  # impressionist actions: [:show], unique: [:impressionable_type, :impressionable_id, :session_hash]

  protect_from_forgery with: :exception

  before_action :build_menu, :build_second_menu
  before_action :configure_permitted_parameters, if: :devise_controller?

  def file_download
    asset = Attachment.find(params[:asset_id])
    send_file(
        asset.file.path,
        filename: asset.file.original_filename,
        type: asset.file_content_type
    )
  end

  def file_show
    asset = Attachment.find(params[:asset_id])
    send_file(
        asset.file.path,
        filename: asset.file.original_filename,
        type: asset.file_content_type,
        disposition: :inline
    )
  end

  def search
    @search = Sunspot.search(SEARCHABLE_CLASSES) do
      fulltext params[:searching_params]
      paginate page: params[:page] || 1, per_page: 20
    end
    @popular_news = News.popular_news.decorate
    render 'search/search', locals: {items: @search.results, popular_news: @popular_news}
  end

  def set_impressionist
    @current_user = current_frontend_user
    impressionist @object, '', unique: [:session_hash] if @object
  end


  def contact
    render 'templates/contact'
  end

  private

  def build_menu
    @menu_tournaments = TournamentCategory.roots.slugable.includes(:children).all.decorate
  end

  def build_second_menu
    @secondary_menu = Category.where(type: %w(NewsCategory StaticPage)).roots.slugable.decorate
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email,:password,:password_confirmation, :username])
  end

end
