class OrderMailer < ApplicationMailer
  default from: "ecomerce45.framgia@gmail.com"

  def approved_email user
    @user = user
    mail to: @user.email, subject: "Sample Email"
  end

  def rejected_email user
    @user = user
    mail to: @user.email, subject: "Sample Email"
  end
end
