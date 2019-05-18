class UploadsController < ApplicationController
  before_action :set_upload, only: %i[show edit update destroy]
  before_action :confirm_files_attached, only: %i[create]

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.where(user_id: current_or_guest_user.id)
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
          files << { file: file }
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
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url, notice: 'Upload was successfully destroyed.' }
      format.json { head :no_content }
    end
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
