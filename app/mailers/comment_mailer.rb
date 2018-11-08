class CommentMailer < ApplicationMailer

  def comment_to_writer(comment)
    @comment = comment
    admin_emails = User.where(super_admin: true).pluck(:email)
    mail to: comment.article.user.email, subject: "[Qiitan] #{comment.article.title}", bcc: admin_emails
  end
end
