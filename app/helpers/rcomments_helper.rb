module RcommentsHelper
  def nested_rcomments(rcomments)
    rcomments.map do |rcomment, sub_rcomments|
      render(rcomment) + content_tag(:div, nested_rcomments(sub_rcomments), :class => "nested_rcomments")
    end.join.html_safe
  end
end
