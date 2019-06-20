require_relative '../helpers/application_helper'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  PAGE_SIZE = 8

  def last_drop
    drop = Drop.last
    @location = drop ? drop.src : ''
    render 'last_drop.html.erb'
  end

  def last_drop_image
    if (@drop = Drop.last)
      render plain: @drop.src
    else
      render plain: ''
    end
  end

  def drops
    @page = 1
    if params[:page]
      @page = params[:page].to_i
      @page = 1 if @page == 0
    end

    drop_query = Drop.order(created_at: :desc)

    unless params[:show_all] && params[:show_all].upcase == 'TRUE'
      drop_query = drop_query.where(status: 'PENDING')
    end

    @pages = (drop_query.count / PAGE_SIZE) + (drop_query.count % PAGE_SIZE == 0 ? 0 : 1)

    @drops = drop_query.offset((@page-1)*PAGE_SIZE).limit(PAGE_SIZE)

    last_drop = Drop.last
    @last_drop_src = last_drop ? last_drop.src : ''

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
    drop = Drop.find(params[:id])
    drop.name = params[:name]
    drop.email = params[:email]
    drop.twitter = params[:twitter]
    drop.send_by_email = params[:send_by_email]
    drop.share_by_twitter = params[:share_by_twitter]
    drop.tag_twitter_user = params[:tag_twitter_user]

    if drop.send_by_email
      drop.send_email
      drop.sent_at = DateTime.now
      drop.status = 'COMPLETE'
    end

    drop.save


    redirect_to "/drops"
  end

  def discard_drop
    drop = Drop.find(params[:id])
    File.delete(drop.image_location)
    drop.destroy
  end

end
