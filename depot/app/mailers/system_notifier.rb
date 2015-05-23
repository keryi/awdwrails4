class SystemNotifier < ApplicationMailer
  default from: 'system@depot.com'
  def error(message)
    @message = message
    mail to: 'support@depot.com', subject: 'System Error'
  end
end
