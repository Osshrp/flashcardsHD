class FlickrPhoto
  def self.render(search_string, photo_count = 10)
    init_hash = { key: Rails.application.secrets.flickr_key,
                  secret: Rails.application.secrets.flickr_secret }
    flickr = Flickr.new(init_hash)
    Rails.cache.fetch("flickr_photo#{search_string}", expires_in: 6.hours) do
      flickr.photos.search(tags: search_string, per_page: photo_count)
    end
  end
end
