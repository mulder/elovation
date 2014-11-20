module ApplicationHelper
  MARKDOWN = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)

  def markdown(text)
    MARKDOWN.render(text.to_s).html_safe
  end

  def gravatar_url(player, options = {})
    options.assert_valid_keys :size
    size = options[:size] || 32
    digest = player.email.blank? ? "0" * 32 : Digest::MD5.hexdigest(player.email)
    "http://www.gravatar.com/avatar/#{digest}?d=mm&s=#{size}"
  end

  def format_time(time)
    "#{time_ago_in_words(time)} ago"
  end
end
