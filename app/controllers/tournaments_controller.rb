class TournamentsController < ApplicationController
  before_action :finder, only: [:show]
  before_action :set_tags, :set_categories, only: [:index, :show]

  def index
    @tournaments = Tournament.all
  end

  def show
    commontator_thread_show(@object) if @object.is_commentable?
    render 'tournaments/show', locals: {tournament: @object, tags: @tags, categories: @categories}
  end

  private

  def finder
    @object = Tournament.finder(params[:id]).try(:first)
    unless @object.present?
      raise ActionController::RoutingError.new('Not Found')
    end
    @object = @object.decorate if @object.present?
  end

  def set_tags
    @tags = ActsAsTaggableOn::Tag.most_used
  end

  def set_categories
    @categories = TournamentCategory.roots.slugable.decorate
  end

end
