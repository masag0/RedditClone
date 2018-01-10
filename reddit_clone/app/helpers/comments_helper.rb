module CommentsHelper
  def display_comments(parent_comment)
    "<ul>".html_safe
    parent_comment.child_comments.each do |child|
      if child.child_comments.empty?

      end
    end
    "</ul>".html_safe
  end

  # <% @post.comments.each do |comment| %>
  #   <ul>
  #     <li>
  #       <% if comment.parent_comment_id.nil? %>
  #       <%= link_to comment.content, comment_url(comment) %>
  #
  #       <% end %>
  #     </li>
  #   </ul>
  # <% end %>
end
