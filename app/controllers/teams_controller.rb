class TeamsController < ApplicationController
  # before_action :set_news, only: [:show, :edit, :update, :destroy]
  before_action :finder, only: [:show]
  # GET /news
  # GET /news.json
  def index
    @teams = Team.all
  end

  # GET /news/1
  # GET /news/1.json
  def show
    render 'teams/show', locals: {team: @object}
  end

  private

  def finder
    @object = Team.finder(params[:id]).try(:first)
    unless @object.present?
      raise ActionController::RoutingError.new('Not Found')
    end
    @object = @object.decorate if @object.present?
  end

end
