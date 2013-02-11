class Admin::WorldLocationTranslationsController < Admin::BaseController
  before_filter :load_world_location
  helper_method :translation_locale

  def index
    @translations = @world_location.translations
  end

  def new
  end

  def create
    if @world_location.update_attributes(params[:world_location])
      redirect_to admin_world_location_translations_path(@world_location)
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @world_location.update_attributes(params[:world_location])
      redirect_to admin_world_location_translations_path(@world_location)
    else
      render action: 'edit'
    end
  end

  private

  def load_world_location
    @world_location = LocaleWrapper.new(WorldLocation.find(params[:world_location_id]), translation_locale)
  end

  def translation_locale
    @translation_locale ||= params[:translation_locale] || params[:id]
  end

  class LocaleWrapper < BasicObject
    def initialize(model, locale)
      @model = model
      @locale = locale
    end

    def method_missing(method, *args, &block)
      original_locale = ::I18n.locale
      ::I18n.locale = @locale
      @model.__send__ method, *args, &block
    ensure
      ::I18n.locale = original_locale
    end
  end
end
