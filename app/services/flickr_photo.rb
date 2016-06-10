class FlickrPhoto

  def self.render(search_string, photo_count = 10)
    photos(search_string, photo_count).in_groups_of(2)
    
    # rescue Exception
    #   render :partial => '/cards/unavailable'
  end

  private

  def self.photos(search_string, photo_count = 10)
    init_hash = {:key => ENV['FLICKR_KEY'], :secret => ENV['FLICKR_SECRET']}
    flickr = Flickr.new(init_hash)
    flickr.photos.search(tags: search_string, per_page: photo_count)
  end
end
