module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    path_arrow = column == sort_column && sort_direction == "asc" ? "M23 14c-0.278 0-0.555-0.116-0.753-0.341l-6.247-7.14-6.247 7.14c-0.364 0.416-0.995 0.458-1.411 0.094s-0.458-0.995-0.094-1.411l7-8c0.19-0.217 0.464-0.341 0.753-0.341s0.563 0.125 0.753 0.341l7 8c0.364 0.416 0.322 1.047-0.094 1.411-0.19 0.166-0.424 0.247-0.658 0.247z" : "M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"
    tag1 = content_tag(:span) do
      link_to title, sort: column, direction: direction
    end
    tag2 = content_tag(:span) do
      content_tag :svg, class: "pointer-down" do
        if column == params[:sort]
          "<path d='#{path_arrow}'></path>".html_safe
        end
      end
    end
    (tag1 + tag2).html_safe
  end
end
