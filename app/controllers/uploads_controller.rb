class UploadsController < ApplicationController
  before_action :set_upload, only: %i[show edit update destroy]

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
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create
    # new_uploads = create_upload_params[:files].map do |file|
    #   file[:user_id] = current_or_guest_user.id
    #   file
    # end
    new_uploads = create_upload_params[:files]
    new_uploads.each { |u_file| u_file[:user_id] = current_or_guest_user.id }
    puts(new_uploads, 'create_upload_params[:files]::new_uploads')

    @upload = Upload.new(new_uploads)

    respond_to do |format|
      if @upload.save
        format.html { redirect_to @upload, notice: 'Upload was successfully created.' }
        format.json { render :show, status: :created, location: @upload }
      else
        format.html { render :new }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    respond_to do |format|
      if @upload.update(upload_params)
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { render :show, status: :ok, location: @upload }
      else
        format.html { render :edit }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
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
    params.require(:upload).permit(:link, :reference, :archived, :user_id)
  end

  def create_upload_params
    params.require(:upload).permit(files: %i[file])
  end
end
