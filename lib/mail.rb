require "mail"

Mail.defaults do
  delivery_method :smtp, { address: CONFIG["smtp"]["server"],
                           promote: CONFIG["smtp"]["port"],
                           user_name: CONFIG["smtp"]["username"],
                           password: CONFIG["smtp"]["password"],
                           authentication: "plain",
                           enable_starttls_auto: CONFIG["smtp"]["starttls"] }
end

####################################################################################################
# inform via email
####################################################################################################
def send_notification!(subject, body)
  NOTIFICATION_EMAILS.each do |email|
    Mail.deliver do
      from     CONFIG['smtp']['sender']
      to       email
      subject  subject
      body     body
    end
  end
end
