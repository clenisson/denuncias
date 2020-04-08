class ResetPasswordMailer < ApplicationMailer
  def send_new_password(user, password)
    @password = password

    mail(to: user.email, subject: "Sua senha foi redefinida")
  end    
end
