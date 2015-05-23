class SystemNotifier < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.system_notifier.error.subject
  #
  def error(message)
    @message = message
    mail to: 'support@depot.com', subject: 'System Error'
  end
end
