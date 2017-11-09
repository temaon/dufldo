class HomeController < ApplicationController
  before_action :set_main_banner
  before_action :set_latest_news
  before_action :set_latest_tournaments
  before_action :set_recent_videos
  # before_action :set_top_players
  before_action :set_recent_results
  before_action :set_future_games
  before_action :set_main_tournaments
  before_action :set_banners


  def index
    render 'home/index', locals: {
        main_banner: @main_banner,
        latest_news: @latest_news,
        tournaments: @latest_tournaments,
        videos: @recent_videos,
        top_players: @top_players,
        recent_results: @recent_results,
        future_games: @future_games,
        main_tournaments: @main_tournaments,
        left_banners: @left_banners,
        right_banners: @right_banners,
    }
  end

  def set_main_banner
    @main_banner = MainBanner.for_showing.try(:decorate)
  end

  def set_latest_news
    @latest_news = News.main_scope(7).decorate
  end

  def set_latest_tournaments
    @latest_tournaments = Tournament.main_scope.latest.decorate
  end

  def set_recent_videos
    @recent_videos = Video.latest(3)
  end

  def set_top_players
    @top_players = Player.top_players.decorate
  end

  def set_recent_results
    @recent_results = Tournament.get_recent_results.decorate
  end

  def set_future_games
    @future_games = Tournament.get_future_games.decorate
  end

  def set_main_tournaments
    @main_tournaments = Tournament.main_scope.decorate
  end

  def set_banners
    @left_banners = SmallBanner.left.decorate
    @right_banners = SmallBanner.right.decorate
  end

end