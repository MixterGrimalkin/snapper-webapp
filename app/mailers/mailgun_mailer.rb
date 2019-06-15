class MailgunMailer < ApplicationMailer
  default from: 'loki@amarantha.net'

  def email_image(drop)
    @drop = drop
    mg_client = Mailgun::Client.new ENV['MG_KEY']
    message_params = {:from    => 'loki@amarantha.net',
                      :to      => @drop.email,
                      :subject => 'Hello from Greenpeace',
                      :text    => 'You rode the drop slide, wooooooo!'}
    puts message_params
    mg_client.send_message ENV['MG_DOMAIN'], message_params
  end

end

#https://launchschool.com/blog/handling-emails-in-rails
#https://github.com/mailgun/mailgun-ruby