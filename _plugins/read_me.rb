module Jekyll
  
  class Post
    alias_method :original_to_liquid, :to_liquid
    def to_liquid
      original_to_liquid.deep_merge({
        'readmore' => content.match('<!--more-->') ? content.split('<!--more-->').first : nil
      })
    end
  end
  
  module ReadMe
    
    def truncate content
      more_tag = '<!--more-->'
      if content.match more_tag
        content = content.match(more_tag) ? content.split('<!--more-->').first : nil
        content += '... '
      end
      content
    end
  end
end

Liquid::Template.register_filter(Jekyll::ReadMe)