class Upload < ApplicationRecord
  include Referenceable
  include Rails.application.routes.url_helpers

  has_many_attached :files

  belongs_to :user

  validates :reference, uniqueness: { case_sensitive: true }
  before_create :set_upload_share_link
  before_validation :sanitize_list

  private

  def set_upload_share_link
    self.link = uploads_url(self, only_path: false, host: ENV.fetch('APPLICATION_HOST'))
  end

  def sanitize_list
    return if files.size < 2

    # get all uploads with files for current user
    Upload.with_attached_files
          .where(user_id: user.id)
          .each do |upload|
            upload.files.each do |file|
              # add them to the current list of file to be uploaded
              files << file
            end
          end

    file_set = {}

    files.each do |file|
      check = file.blob.checksum

      file.purge if file_set[check].present?

      file_set[check] = file.blob
    end
  end
end
