class SightsController < ApplicationController
  def index
    @sight_kinds = Sight.sight_kinds
    @sights_by_kind = Sight.sights_by_kind
  end

  def show
    @sight = Sight.find(params[:id])
  end

  def edit
    @sight = Sight.find(params[:id])
  end

  def update
    @sight = Sight.find(params[:id])
    if @sight.update(image_file_name: params[:filename],
                     image_file_size: params[:filesize],
                     image_content_type: params[:filetype],
                     image_updated_at: params[:lastModifiedDate])
        # UserNotifier.send_upload_photo_confirm(current_user).deliver if current_user
      render :js => "window.location.href='"+sights_path+"'"
    else
      render :edit
    end
  end
end
