class UploadsController < ApplicationController
  before_action :set_upload, only: %i[show edit update]
  before_action :confirm_files_attached, only: %i[create]

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = [].tap do |files|
      Upload.with_attached_files
            .where(user_id: current_or_guest_user.id)
            .each do |upload|
              upload.files.each do |file|
                files << { id: upload.id, file: file }
              end
            end
    end
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
    @uploads = [].tap do |files|
      Upload.with_attached_files
            .where(user_id: current_or_guest_user.id)
            .each do |upload|
              upload.files.each do |file|
                files << { id: upload.id, file: file }
              end
            end
    end
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create
    new_uploads = create_upload_params
    new_uploads[:user_id] = current_or_guest_user.id

    @upload = Upload.new(new_uploads)

    if @upload.save
      flash[:success] = 'File upload successful!'
    else
      flash[:danger] = 'An error occurred. Please try again!'
      flash[:error] = @upload.errors.full_messages.to_sentence
    end
    redirect_to root_path
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload = @upload = Upload.find_by(id: params[:id], user_id: current_or_guest_user.id)
    @file = ActiveStorage::Attachment.find(params[:file])
    @file&.purge
    @upload.destroy unless @upload.files.present?
    flash[:success] = 'File deleted successful!'
    redirect_to root_path
  rescue StandardError => error
    flash[:danger] = 'File does not exist!'
    flash[:error] = error.message
    redirect_to root_path
  end

  private

  def set_upload
    @upload = Upload.find(params[:id] || params[:upload_id])
  end

  def upload_params
    params.require(:upload).permit(:link, :archived)
  end

  def create_upload_params
    params.require(:upload).permit(files: [])
  end

  def confirm_files_attached
    return if create_upload_params[:files].present?
    redirect_to new_upload_path
    flash[:warning] = 'No files attached for upload!'
  end
end
