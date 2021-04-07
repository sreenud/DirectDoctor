# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.findmydirectdoctor.com/"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  # add root_path, priority: 0.5, changefreq: 'daily'
  add blogs_path, priority: 0.5, changefreq: "daily"
  Topic.published.find_each do |topic|
    add blog_path(topic.slug), lastmod: topic.updated_at, priority: 0.5
  end

  add tips_path, priority: 0.5, changefreq: "daily"
  Tip.published.find_each do |tip|
    add "/blogs/#{tip&.slug}/#{tip&.code}", lastmod: tip.updated_at, priority: 0.5
  end
end
