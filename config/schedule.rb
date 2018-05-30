every "0 0 1 * *" do
  rake "email:send_monthly_email"
end
