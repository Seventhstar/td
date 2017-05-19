@upd_param = (param)->
  $.ajax
      url: '/ajax/upd_param'
      data: param
      type: 'POST'
      beforeSend: (xhr) ->
        xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
        return
      success: ->
        # disable_input(false)
        show_ajax_message('Успешно обновлено')
     return

@apply_opt_change = (item_id)->
  model = $('#todo-list').attr('model')
  # item_id = item.attr('data-id')
  inputs = $('input[name^=upd'+item_id+']').serialize()
  upd_param(inputs+'&model='+model+'&id='+item_id)  
  sortable_query({})
  return

@sortable_query = (params)->
  l = window.location.toString().split('?');
  p = q2ajx(l[1])
  ser = $('.index_filter').serialize()
  if ser == ""
    ser = $('.index_filter select').serialize()
  p_params = q2ajx(ser)
  
  url = { }
  each p, (i, a) ->
    if ['search','page','_'].include? i 
      url[i] = a
    return
  each p_params, (i, a) ->
    url[i] = a
    return

  if params!=undefined
    each params, (i, a) -> 
      url[i] = a
      return
  
  controller =  $('#search').attr('cname')
  controller = '' if controller == undefined
  $.get '/'+controller, url, null, 'script'
  setLoc(""+controller+"?"+ajx2q(url));
  return


$(document).ready ->
  $('#new_task_name').focus()
  $(document).on 'keyup', '#new_task_name', (e) ->
    params = undefined
    if e.keyCode == 13
      params = $('[name^=new_task]').serialize()
      $.ajax
        type: 'POST'
        url: '/ajax/add_task'
        data: params
        success: ->
          $.get 'tasks', '', null, 'script'
          return
    return
  $('input').on 'blur', ->
    $('.editing').closest('li').removeClass 'editing'
  $(document).on 'keyup', 'input.edit', (e) ->
    if (e.which == 13)
        apply_opt_change(e.target.closest('li').getAttribute('data-id'))
        e.target.blur()
    if (e.which == 27)
        $(e.target).closest('li').removeClass('editing')
  $(document).on 'dblclick', 'label',(e) ->  
    $('.editing').closest('li').removeClass 'editing'
    $input = $(e.target).closest('li').addClass('editing').find('.edit');
    $input.val($input.val()).focus();
  $(document).on 'click', '.toggle', ->
			task_id = $(this).closest('li').attr('data-id')
			done = $(this).is( ":checked" )
			$.ajax
        type: 'POST'
        url: '/ajax/set_check'
        data: {'task_id':task_id,'done': done}
			return
  return

$(document).on 'click', '#btn-send', (e) ->
  valuesToSubmit = $('form').serialize()
  values = $('form').serialize()
  url = '/options'+$('form').attr('action')
  #alert url
  empty_name = false
  #alert values
  each q2ajx(values), (i, a) ->
    if i.indexOf('[name]') > 0 and a == ''
      empty_name = true
      return false
    return
  if !empty_name
    $.ajax
      type: 'POST'
      url: url
      data: valuesToSubmit
      dataType: 'JSON'
      beforeSend: (xhr) ->
        xhr.setRequestHeader 'X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')
        return
      success: (xhr, data, response) ->
        $.get url, null, null, 'script'
        show_ajax_message 'Успешно записано'
        return
      error: (evt, xhr, status, error) ->
        show_ajax_message(evt.responseText,'error')
    return
  return

# удаляем элемент справочника
$(document).on 'click', ' span.icon_remove', ->
    item_id = $(this).attr('item_id')
    url = document.URL.replace('#', '') #$('form').attr('action')
    attr_url = $(this).parents('table').attr('action') 
    if attr_url!=undefined
      del_url = '/'+attr_url + '/' + item_id
    else
      del_url = url + '/' + item_id
    if url.indexOf('edit')<1 && url.indexOf('options')<1 then url = url + '/edit'
   # url = url.replace('options/','')  
    del = confirm('Действительно удалить?')
    if !del
      return
    $.ajax
      url: del_url
      data: '_method': 'delete'
      dataType: 'json'
      type: 'POST'
      complete: ->
        $.get url, null, null, 'script'
        show_ajax_message('Успешно удалено')
        return
    return