class UserNotifier < ActionMailer::Base
  default from: "info@example.com"

  def send_upload_photo_confirm(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Your photo has been uploaded')
  end
end
