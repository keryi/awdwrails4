# Preview all emails at http://localhost:3000/rails/mailers/system_notifier
class SystemNotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/system_notifier/error
  def error
    SystemNotifier.error
  end

end
