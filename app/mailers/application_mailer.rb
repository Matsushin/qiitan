class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@qiitan.jp', reply_to: 'support@qiitan.jp'
  layout 'mailer'
end
