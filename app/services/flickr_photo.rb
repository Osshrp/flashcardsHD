class FlickrPhoto
  def initialize(search_string)
    @search_string = search_string
  end

  def flickr_photos(photo_count = 10)
    flickr = Flickr.new('config/flickr.yml')
    flickr.photos.search(tags: @search_string).values_at(0..(photo_count - 1))
  end
  
  def render_flickr_widget(photo_count = 10)
    flickr_photos(photo_count).in_groups_of(2)
    
    # rescue Exception
    #   render :partial => '/cards/unavailable'
  end
end
