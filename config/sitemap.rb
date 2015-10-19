SitemapGenerator::Sitemap.default_host = AppConfig.host()

SitemapGenerator::Sitemap.create include_root:false do
  Board.find_each do |board|
    add board_path(board), lastmod:board.topics.maximum(:bumped_at), changefreq:'always'
  end

  Topic.find_each do |topic|
    add topic_path(board:topic.board.seo_name, id:topic), lastmod:topic.bumped_at, changefreq:'daily'
  end
end
