class OrderMailer < ApplicationMailer
  default from: Settings.order.mail_default

  def approved_email user
    @user = user
    mail to: @user.email, subject: t("mailer.order.subject_approved")
  end

  def rejected_email user
    @user = user
    mail to: @user.email, subject: t("mailer.order.subject_rejected")
  end
end
