class PlayersController <  ApplicationController
  before_action :finder, only: [:show]

  def show
    render 'players/show', locals: {player: @object, tags: @tags, categories: @categories}
  end

  private

  def finder
    @object = Player.finder(params[:id]).try(:first)
    unless @object.present?
      raise ActionController::RoutingError.new('Not Found')
    end
    @object = @object.decorate if @object.present?
  end


end