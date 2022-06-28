class InvitationNotifierMailer < ApplicationMailer
  def invite(user, party)
    @user = User.find(user)
    @party = party
    @host = User.find(@party.host)

    mail(
      reply_to: @host.email,
      to: @user.email,
      subject: "You're being invited to a Movie Night!"
    )
  end
end
