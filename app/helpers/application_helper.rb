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
      datap = modal ? {modal: true} : {}
      all_icons['edit'] = content_tag :span, "", {class: 'icon icon_edit', item_id: element.id, 'data-modal'=> modal}
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


  def chosen_src( id, collection, obj = nil, options = {})
    p_name    = options[:p_name].nil? ? 'name' : options[:p_name]
    order     = options[:order].nil? ? p_name : options[:order]
    nil_value = options[:nil_value].nil? ? 'Выберите...' : options[:nil_value]
    add_name  = options[:add_name]

  	coll = collection.class.ancestors.include?(ActiveRecord::Relation) ? collection : collection
    coll = coll.collect{ |u| [u[p_name], u.id] } if coll.class.name != 'Array'
    coll.insert(0,[nil_value,0,{class: 'def_value'}]) if nil_value != ''
    coll.insert(1,[options[:special_value],-1]) if !options[:special_value].nil?

    if !options[:selected].nil?
      sel = options[:selected]
    else
  		is_attr = (obj.class != Fixnum && obj.class != String && !obj.nil?)
      sel = is_attr ? obj[id] : obj
    end 
    
    n = is_attr ? obj.model_name.singular+'['+ id.to_s+']' : id
    n = [add_name,'[',n,']',].join if !add_name.nil?

    def_cls = coll.count < 8 ? 'chosen' : 'schosen'
    cls       = options[:class].nil? ? def_cls : options[:class]
    cls = cls + ' '+ options[:add_class] if !options[:add_class].nil?
    cls = cls+" has-error" if is_attr && ( obj.errors[id].any? || obj.errors[id.to_s.gsub('_id','')].any? )
    l = label_tag options[:label]
    s = select_tag n, options_for_select(coll, :selected => sel), class: cls
    options[:label].nil? ? s : l+s
  end


end
