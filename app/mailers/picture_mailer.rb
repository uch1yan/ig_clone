class PictureMailer < ApplicationMailer
  def picture_mail(picture)
    @picture = picture

    mail to: "manayou1125@outlook.jp", subject: "投稿確認メール"
  end
end
