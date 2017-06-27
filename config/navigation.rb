# -*- coding: utf-8 -*-
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'selected active'
  navigation.active_leaf_class = 'active'
  navigation.items do |primary|

    main_class = (request.url==root_url || request.url==tasks_url) ? "selected active" : ""
    primary.item :tasks, 'Задачи', root_path, html: {class: main_class}
    

    primary.item :logout,  content_tag(:span,' '), logout_path, method: :delete, html: {class: 'li-right logout', title: 'Выйти'}
    if current_user.admin? 
      primary.item :options, content_tag(:span,' '), options_path, html: {class: 'li-right options', title: 'Настройки'}
    end
    

    primary.dom_class = 'nav'
  end
end

