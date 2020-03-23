class BaseMailer < ActionMailer::Base
  default from: 'admin@test.com'

  def admin
    'admin@test.com'
  end
end
