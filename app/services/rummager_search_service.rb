class RummagerSearchService
  
  def filter_by_topical_event(topical_event, additional_options = {})
    options = { filter_topical_events: topical_event }
    options.merge(default_search_options).merge(additional_options)
    search(options)
  end

  def default_search_options
    {
      count: 3,
      order: "-public_timestamp",
      fields: %w[display_type title link public_timestamp format description content_id]
    }
  end

  def search(options = {})
    search_response = Whitehall.search_client.search(options)
    search_response["results"].map! { |res| RummagerDocumentPresenter.new(res) }

    search_response
  end
end
