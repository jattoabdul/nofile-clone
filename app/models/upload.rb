class Upload < ApplicationRecord
  include Referenceable
  include Rails.application.routes.url_helpers

  has_many_attached :files

  belongs_to :user

  validates :reference, uniqueness: { case_sensitive: true }
  before_create :set_upload_share_link

  private

  def set_upload_share_link
    self.link = uploads_url(self, only_path: false, host: ENV.fetch('APPLICATION_HOST'))
  end
end
