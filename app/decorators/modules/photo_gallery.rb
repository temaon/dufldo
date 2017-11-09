module Modules::PhotoGallery

  def main_image(format = :gallery)
    object.images.try(:first).try(:url, format).to_s.presence || 'default.jpg'
  end

  def second_image
    (has_video? ? object.video.url_thumb : object.images.try(:second).try(:url, :gallery).to_s).presence || 'default.jpg'
  end

  def get_video
    (object.videos.first.video_player if has_video?).to_s
  end

  def has_video?
    object.videos.present?
  end

end
