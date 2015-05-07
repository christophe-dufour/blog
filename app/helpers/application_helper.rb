module ApplicationHelper
  if ENV['HOME'] == '/app'
    require 'rubypython'
    RubyPython.start(:python_exe => "python2.6")
  end
  class HTMLwithPygments < Redcarpet::Render::HTML
    def block_code(code, language)
      Albino.colorize(code, language)
    end
  end


  def markdown
    @@markdown ||= Redcarpet::Markdown.new(HTMLwithPygments, autolink: true, tables: true, with_toc_data: true, prettify: true, fenced_code_blocks: true, disable_indented_code_blocks: true)
  end
end
