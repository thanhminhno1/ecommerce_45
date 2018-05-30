namespace :email do
  desc "send monthly email to admin"
  task send_monthly_email: :environment do
    AdminMailer.monthly_email(User.admin).deliver_now
  end
end
