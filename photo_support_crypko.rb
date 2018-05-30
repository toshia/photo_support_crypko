# -*- coding: utf-8 -*-

Plugin.create(:photo_support_crypko) do
  # crypko
  defimageopener('crypko', %r<\Ahttps://s\.crypko\.ai/c/\d+>) do |display_url|
    connection = HTTPClient.new
    connection.transparent_gzip_decompression = true
    page = connection.get_content(display_url)
    next nil if page.empty?
    doc = Nokogiri::HTML(page)
    result = doc.css('meta[property="og:image"]').lazy.map{ |dom|
      dom.attribute('content')
    }.first
    open(result) if result
  end
end
