# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@disable_input_row = () ->
 $('.icon_hide_edit').each ->
  item_id = $(this).attr('item_id')
  $('#new_pgt_item'+item_id).hide()
  $('.new_row').hide()
  $('.btn_add').show()
  $('#pgt_item'+item_id).show()

@disable_input = (cancel=true) -> 
 item_id = $('.icon_apply').attr('item_id')
 item_rm_id = $('.icon_cancel').attr('item_id')
 $cells = $('.editable')
 $cells.each ->
  _cell = $(this)
  _cell.removeClass('editable')
  if cancel
    _cell.html _cell.attr('last_val')
  else
    _cell.html _cell.find('input').val()    
  return

 $cell = $('td.app_cancel')  
 $cell.removeClass('app_cancel')
 if item_rm_id == 'undefined' || item_rm_id == ''  
  del_span = '<span class="icon icon_remove_disabled"></span>' 
 else 
  del_span = '<span class="icon icon_remove" item_id="'+item_id+'"></span>'
 $cell.html ('<span class="icon icon_edit" item_id="'+item_id+'"></span>'+del_span)

@update_task = ->
	cat_id = $('#new_task_cat_id').val()
	prm = {'cat_id':cat_id}
	$.get "/",prm,null, 'script'
	setLoc "?"+ajx2q(prm)
	apply_mask()

@apply_mask = ->
	$('.schosen').chosen(width: '99.5%').on 'change', ->
		update_task()
	$('input').on 'blur', ->
    $('.editing').closest('li').removeClass 'editing'

@cell_to_edit = (cl)->
  cl.addClass('editable')
  table = cl.closest('table')
  val = cl.html()      
  cl.data('text', val).html ''
  cl.attr('last_val',val)  
  fld = table.find('th:eq('+cl.index()+')').attr('fld')
  cl.attr('ind', fld)
  type = cl.attr('type')
  type = if type == undefined then 'text' else type      
  $input = $('<input type="'+type+'" name=upd['+fld+'] />').val(cl.data('text')).width(cl.width() )
  cl.append $input
  cl.context.firstChild.focus()


$(document).ready ->
	apply_mask()
	NProgress.configure
	  showSpinner: false
	  ease: 'ease'
	  speed: 200

	$(document).ajaxStart ->
	  NProgress.start()
	  return
	$(document).ajaxStop ->
	  $('[data-toggle="tooltip"]').tooltip
	    'placement': 'top'
	    fade: false
	  NProgress.done()
	  apply_mask()
	  return
# редактирование данных в таблице
  $('.container').on 'click', 'span.icon_edit', ->
    item_id = $(this).attr('item_id')
    item_rm_id= $(this).next().attr('item_id')
    $row = $(this).parents('')
    disable_input()
    $cells = $row.children('td').not('.edit_delete,.state')    
    $cells.each ->
      cell_to_edit($(this))
      return

    $cell = $row.children('td.edit_delete')  
    $cell.addClass('app_cancel')
    $cell.html '<span class="icon icon_apply" item_id="'+item_id+'"></span><span class="icon icon_cancel" item_id="'+item_rm_id+'"></span>'

   # отмена редактирования
  $('.container').on 'click', 'span.icon_cancel', ->   
     disable_input()
     return

  # отправка новых данных
  $('.container').on 'click', 'span.icon_apply', -> 
    apply_opt_change($(this))
