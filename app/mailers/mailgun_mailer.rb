class MailgunMailer < ApplicationMailer
  default from: 'loki@amarantha.net'

  def email_image(drop)
    @drop = drop
    mg_client = Mailgun::Client.new 'd3dc4dde5ac09d66e1b9ac6f21ea0bcc-16ffd509-db2290f2'
    message_params = {:from    => 'loki@amarantha.net',
                      :to      => @drop.email,
                      :subject => 'Hello from Greenpeace',
                      :text    => 'You rode the drop slide, wooooooo!'}
    puts message_params
    mg_client.send_message 'sandboxc53823b453d54323aa1f6bc6eaa532cb.mailgun.org', message_params
  end

end

#https://launchschool.com/blog/handling-emails-in-rails
#https://github.com/mailgun/mailgun-ruby