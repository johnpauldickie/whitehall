class Admin::DashboardController < Admin::BaseController
  def index
    if current_user.organisation
      @draft_documents = Edition.authored_by(current_user).where(state: 'draft').includes(:translations, :versions).in_reverse_chronological_order

      @force_published_documents = Edition.
        joins("INNER JOIN edition_organisations on editions.id = edition_organisations.id INNER JOIN edition_translations on edition_translations.id = editions.id").
        where("edition_organisations.organisation_id = ?", current_user.organisation.id).
        order("editions.public_timestamp desc, editions.document_id desc, editions.id desc").
        limit(5)
    end
  end
end
