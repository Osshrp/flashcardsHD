class Dashboard::CardsController < Dashboard::BaseController
  before_action :set_card, only: [:destroy, :edit, :update]
  respond_to :html, :json

  def index
    @cards = current_user.cards.all.order('review_date')
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = current_user.cards.build(card_params)
    if @card.save
      @card.update(remote_image_url: card_params[:remote_image_url])
      redirect_to cards_path
    else
      respond_with @card
    end
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else
      respond_with @card
    end
  end

  def destroy
    @card.destroy
    respond_with @card
  end

  def search_photo
    render layout: false
  end

  def remote
    render
  end

  def remote_create
    if RemoteWordsJob.perform_now(remote_params, current_user)
      redirect_to cards_path
    else
      render
    end
  end

  private

  def set_card
    @card = current_user.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date,
                                 :image, :image_cache, :remove_image, :block_id,
                                 :search_string, :id, :remote_image_url, :photo)
  end

  def remote_params
    params.permit :remote_url, :row_selector, :original_selector, :translate_selector
  end
end
