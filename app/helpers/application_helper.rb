module ApplicationHelper

  def attr_boolean?(item,attr)
    item.class.column_types[attr.to_s].class == ActiveRecord::Type::Boolean
  end

  def attr_date?(item,attr)
  #   item.class.column_types[attr.to_s].class == ActiveRecord::ConnectionAdapters::PostgreSQL::OID::Date
   false
  end

  # def is_admin?
  #   current_user.admin?
  # end


  def option_li( page,title )
    css_class = @page == page ? "active" : nil
    content_tag :li, {:class =>css_class } do
      link_to title, '#',{:class =>"list-group-item #{css_class}", :controller => page}
    end
  end

  def tool_icons(element,params = nil)

    all_icons = {} #['edit','delete','show'] tag='span',subcount=nil
    params ||= {}
    params[:tag] ||= 'href'
    params[:icons] ||= 'edit,delete'
    icons = params[:icons].split(',')
    params[:subcount] ||= 0
    params[:class] ||= ''
    params[:content_class] ||= ''
    params[:content_tag] ||= :td
    content = params[:content_tag]
    modal = params[:modal] ||= false
    dilable_cls = params[:subcount]>0 ? '_disabled' : ''
    if params[:tag] == 'span'
      all_icons['edit'] = content_tag :span, "", {class: 'icon icon_edit', item_id: element.id}
      all_icons['delete'] = content_tag( :span,"",{class: ['icon icon_remove',dilable_cls,' ',params[:class]].join, item_id: params[:subcount]>0 ? '' : element.id})
     else
      datap = modal ? {modal: true} : {}

      all_icons['edit'] = link_to "", edit_polymorphic_path(element), class: "icon icon_edit " + params[:class], data: datap
      all_icons['show'] = link_to "", polymorphic_path(element), class: "icon icon_show", data: { modal: true }
      all_icons['delete'] = link_to "", element, method: :delete, data: { confirm: 'Действительно удалить?' }, class: "icon icon_remove " + params[:class] if params[:subcount]==0
      all_icons['delete'] = content_tag(:span,"",{class: 'icon icon_remove_disabled'}) if params[:subcount]>0
    end
    content_tag content,{:class=>["edit_delete",' ',params[:content_class]].join} do
      icons.collect{ |i| all_icons[i] }.join.html_safe
    end
  end


end
