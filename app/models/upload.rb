class Upload < ApplicationRecord
  include Referenceable

  has_many_attached :files

  belongs_to :user

  validates :reference, uniqueness: { case_sensitive: true }
  before_create :set_upload_share_link

  private

  def set_upload_share_link
    self.link = 'http://amazon.com'
  end
end
