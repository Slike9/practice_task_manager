$ ->
  $('form.new_comment').on 'ajax:success', ->
    location.reload();