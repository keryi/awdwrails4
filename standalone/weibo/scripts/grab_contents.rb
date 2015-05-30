require_relative '../config/environment.rb'

Post.delete_all if Post.count > 0

10.times { Post.create content: 'hello' }

posts = Post.all
contents = posts.map { |p| p.content }
contents.each { |c| puts c }
