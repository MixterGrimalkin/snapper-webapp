require_relative '../helpers/application_helper'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  PAGE_SIZE = 10

  def drops
    page = 1
    if params[:page]
      page = params[:page].to_i
      page = 1 if page == 0
    end

    drop_query = Drop.order(created_at: :desc)

    unless params[:show_all] && params[:show_all].upcase == 'TRUE'
      drop_query = drop_query.where(status: 'PENDING')
    end

    @drops = drop_query.offset((page-1)*PAGE_SIZE).limit(PAGE_SIZE)

    render 'drops.html.erb'
  end

  def drop
    begin
      @drop = Drop.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render status: 404
    end
  end

  def save_drop
    puts params

    drop = Drop.find(params[:id])
    drop.name = params[:name]
    if (snap_id = params[:new_primary_snap_id].to_i) > 0
      drop.primary_snap = Snap.find snap_id
    end
    drop.save

    redirect_to "/drop/#{params[:id]}"
  end

end
