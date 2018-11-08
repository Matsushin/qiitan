module ApplicationHelper
  def qiita_markdown(markdown)
    processor = Qiita::Markdown::Processor.new(hostname: 'qiitan.test')
    processor.call(markdown)[:output].to_s.html_safe
  end

  def qiita_toc(markdown)
    greenmat = Greenmat::Markdown.new(Qiita::Markdown::Greenmat::HTMLToCRenderer.new())
    greenmat.render(markdown).to_s.html_safe
  end

  def add_unread_style(unread)
    'is-unread' if unread
  end
end
