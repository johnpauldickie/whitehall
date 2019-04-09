# Note that announcement pages are rendered by the `government-frontend` application.
class StatisticsAnnouncementsController < PublicFacingController
  enable_request_formats(index: [:js])

  def index
    redirect_to_research_and_statistics
  end

private

  def redirect_to_research_and_statistics
    base_path = "#{Plek.new.website_root}/search/research-and-statistics"
    redirect_to("#{base_path}?#{research_and_statistics_query_string}")
  end

  def research_and_statistics_query_string
    {
      content_store_document_type: 'statistics_upcoming',
      keywords: params['keywords'],
      level_one_taxon: params['taxons'].try(:first),
      people: params['people'],
      organisations: params['departments'],
      public_timestamp: {
        from: params['from_date'],
        to: params['to_date']
      }.compact.presence,
    }.compact.to_query
  end
end
