module ApplicationHelper
  def markdown
    @@markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
  end

end
