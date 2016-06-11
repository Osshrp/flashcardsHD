class FlickrPhoto
  class << self
    def render(search_string, photo_count = 10)
      photos(search_string, photo_count).in_groups_of(2)

      # rescue Exception
      #   render :partial => '/cards/unavailable'
    end

    def photos(search_string, photo_count = 10)
      init_hash = { key: Rails.application.secrets.flickr_key,
                    secret: Rails.application.secrets.flickr_secret }
      flickr = Flickr.new(init_hash)
      flickr.photos.search(tags: search_string, per_page: photo_count)
    end
  end
end
