require "rubygems"
require "rake"

task :default => :server

desc "Build site with jekyll"
task :build do
  jekyll
end

desc "Start server with --auto"
task :server do
  jekyll('--server --auto')
end

desc "Remove all the build files."
task :clean do
  sh 'rm -rf _site'
end

desc "Deploy to codeography.com"
task :deploy do
  jekyll
  sh "scp -r _site/* root@cbbfactura.com:/var/www/blog/"
end

desc "Creates a new _posts file using TITLE='the title' and today's date. JEKYLL_EXT=markdown by default"
task :post do
  ext = ENV['JEKYLL_EXT'] || "markdown"
  unless title = ENV['TITLE']
    puts "USAGE: rake post TITLE='the post title'"
    exit(1)
  end
  post_title = "#{Time.now.strftime("%Y-%m-%d")}-#{title.downcase.gsub(/[^\w]+/, '-')}"
  post_file = File.dirname(__FILE__) + "/_posts/#{post_title}.#{ext}"
  File.open(post_file, "w") do |f|
    f << <<-EOS.gsub(/^ /, '')
---
layout: post
title: #{title}
---
EOS
  end
  if (ENV['EDITOR'])
    system ("vim #{post_file}")
    system ("git add #{post_file}")
  end
end

def jekyll(opts = '')
  Rake::Task['clean'].execute
  sh 'jekyll ' + opts
end