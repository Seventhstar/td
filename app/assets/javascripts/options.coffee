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
  $(document).on 'click', '.toggle', ->
			task_id = $(this).closest('li').attr('data-id')
			done = $(this).is( ":checked" )
			$.ajax
        type: 'POST'
        url: '/ajax/set_check'
        data: {'task_id':task_id,'done': done}
			return
  return