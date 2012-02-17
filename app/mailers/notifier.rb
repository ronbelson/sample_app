class Notifier < ActionMailer::Base
  default from: "ronbelson@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.send_test.subject
  #
  def send_test
    @greeting = "Hi"

    mail to: "ronibelson@gmail.com",
         subject: "hi ron",
         from: "ronbelson@gmail.com"
  end
  
  def welcome(name)
    @greeting = "Hi #{name},"

    mail to: "ronibelson@gmail.com",
         subject: "#{name}, welcome to sampleapp",
         from: "ronbelson@gmail.com"
  end
end
