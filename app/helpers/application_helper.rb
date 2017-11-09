module ApplicationHelper

  #Asset helpers
  def controller_js
    "controllers/#{controller_name}.js"
  end

  def controller_css
    "controllers/#{controller_name}.css"
  end

  def asset_exists? asset
    !!Rails.application.assets.find_asset(asset)
  end

  def format_query_url(url)
    query_hash = Rack::Utils.parse_nested_query(url)
    query_hash.present? ? '?' + query_hash.to_query : ''
  end

end
