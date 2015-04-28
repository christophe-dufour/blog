module PostsHelper

  def truncate_post(post)
    truncate(strip_tags(markdown.render(post.body||'')), length: 80, separator: '.', escape: false) { link_to '...', post }
  end
end
