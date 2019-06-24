require_relative '../helpers/application_helper'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  PAGE_SIZE = 8

  GDPR = 'I would like to receive emails from Greenpeace on how to get involved through petitions, campaigning, volunteering and donating.'

  def last_drop
    drop = Drop.where(status: 'PENDING').last
    @location = drop ? drop.src : ''
    render 'last_drop.html.erb'
  end

  def last_drop_image
    if (@drop = Drop.where(status: 'PENDING').last)
      render json: {
          src: @drop.src,
          id: @drop.id
      }
    else
      render json: '[]'
    end
  end

  def drops
    @page = 1
    if params[:page]
      @page = params[:page].to_i
      @page = 1 if @page == 0
    end

    drop_query = Drop.order(created_at: :desc)

    unless (@show_all = params[:show_all] && params[:show_all].upcase == 'TRUE')
      drop_query = drop_query.where(status: 'PENDING')
    end

    @pages = (drop_query.count / PAGE_SIZE) + (drop_query.count % PAGE_SIZE == 0 ? 0 : 1)

    @drops = drop_query.offset((@page-1)*PAGE_SIZE).limit(PAGE_SIZE)

    last_drop = Drop.where(status: 'PENDING').last
    @last_drop_src = last_drop ? last_drop.src : ''

    render 'drops.html.erb'
  end

  def drop
    begin
      @drop = Drop.find(params[:id])
      @gdpr = GDPR
    rescue ActiveRecord::RecordNotFound
      render status: 404
    end
  end

  def save_drop
    if (drop = Drop.find(params[:id]))

      puts params

      drop.name = params[:name]
      drop.email = params[:email]
      drop.gdpr_consent = params[:gdpr_consent] || false
      drop.gdpr_text = params[:gdpr_text]
      drop.send_by_email = params[:send_by_email] || false
      drop.happy_to_share = params[:happy_to_share] || false

      if drop.status=='PENDING'
        if drop.send_by_email
          drop.status = 'WAITING'
        else
          drop.status = 'COMPLETE'
        end
      end

      drop.save
    end
    redirect_to '/'
  end

  def discard_drop
    if (drop = Drop.find(params[:id]))
      File.delete(drop.image_location)
      drop.destroy
    end
  end

end
