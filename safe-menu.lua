--[[
    Made by:
    SomeoneIdfk#4763

    Credits:
    The Stand Devs

    Getting errors while everything is already working?
    Then this is for you.
    This lua has all menu. commands in it so go ham, it only errors in the log quietly.
    Note that debugging becomes basically impossible if you start using this before having made your lua.
    If there are any errors hit me up in Discord DMs, I'll gladly throw a fix at it.
]]

local functions, cache, safe_menu = {empty = function() end}, {[1] = {}, [2] = {}}, {}

function safe_menu.my_root()
    local succes, output = pcall(menu.my_root)
    if not succes then util.log("Error; "..output.." in my_root.") end
    return succes and output or nil
end

function safe_menu.player_root(player_id)
    local succes, output = pcall(menu.player_root, player_id)
    if not succes then util.log("Error; "..output.." in player_root.") end
    return succes and output:isValid() and output or nil
end

function safe_menu.shadow_root()
    local succes, output = pcall(menu.shadow_root)
    if not succes then util.log("Error; "..output.." in shadow_root.") end
    return succes and output or nil
end

function safe_menu.ref_by_path(path, tree_version)
    tree_version = tree_version or 0
    if not cache[1][path] then
        local succes, output = pcall(menu.ref_by_path, path, tree_version)
        if not succes then util.log("Error; "..output.." in ref_by_path.") end
        if succes and output:isValid() then
            cache[1][path] = output
        else util.log("Error; bad argument #1 to 'ref_by_path' in ref_by_path.") return nil end
    end
    if not cache[1][path]:isValid() then
        cache[1][path] = safe_menu.ref_by_path(path, tree_version)
    end
    return cache[1][path] or nil
end

function safe_menu.ref_by_rel_path(base, path)
    if not cache[2][base] then
        if base and base:isValid() then
            cache[2][base] = {}
        else util.log("bad argument #1 to 'ref_by_rel_path' (CommandRef expected, got nil)") return nil end
    end
    if not cache[2][base][path] or not cache[2][base][path]:isValid() then
        local succes, output = pcall(menu.ref_by_rel_path, base, path)
        if not succes then util.log("Error; "..output.." in ref_by_rel_path.") end
        if succes and output:isValid() then
            cache[2][base][path] = output
        else return nil end
    end
    return cache[2][base][path] or nil
end

function safe_menu.ref_by_command_name(command_name)
    local succes, output = pcall(menu.ref_by_command_name, command_name)
    if not succes then util.log("Error; "..output.." in ref_by_command_name.") end
    return succes and output:isValid() and output or nil
end

function safe_menu.list(parent, menu_name, command_names, help_text, on_click, on_back)
    command_names, on_click, on_back = command_names or {""}, on_click or functions.empty, on_back or functions.empty
    local succes, output = pcall(menu.list, parent, menu_name, command_names, help_text, on_click, on_back)
    if not succes then util.log("Error; "..output.." in list.") end
    return succes and output or nil
end

function safe_menu.action(parent, menu_name, command_names, help_text, on_click, on_command, syntax, perm)
    command_names, on_click, on_command, perm = command_names or {""}, on_click or functions.empty, on_command or functions.empty, perm or COMMANDPERM_USERONLY
    local succes, output = pcall(menu.action, parent, menu_name, command_names, help_text, on_click, on_command, syntax, perm)
    if not succes then util.log("Error; "..output.." in action.") end
    return succes and output or nil
end

function safe_menu.toggle(parent, menu_name, command_names, help_text, on_change, default_on)
    command_names, on_change = command_names or {""}, on_change or functions.empty
    local succes, output = pcall(menu.toggle, parent, menu_name, command_names, help_text, on_change, default_on)
    if not succes then util.log("Error; "..output.." in toggle.") end
    return succes and output or nil
end

function safe_menu.toggle_loop(parent, menu_name, command_names, help_text, on_tick, on_stop)
    command_names, on_tick, on_stop = command_names or {""}, on_tick or functions.empty, on_stop or functions.empty
    local succes, output = pcall(menu.toggle_loop, parent, menu_name, command_names, help_text, on_tick, on_stop)
    if not succes then util.log("Error; "..output.." in toggle_loop.") end
    return succes and output or nil
end

function safe_menu.slider(parent, menu_name, command_names, help_text, min_value, max_value, default_value, step_size, on_change)
    command_names, on_change = command_names or {""}, on_change or functions.empty
    local succes, output = pcall(menu.slider, parent, menu_name, command_names, help_text, min_value, max_value, default_value, step_size, on_change)
    if not succes then util.log("Error; "..output.." in slider.") end
    return succes and output or nil
end

function safe_menu.slider_float(parent, menu_name, command_names, help_text, min_value, max_value, default_value, step_size, on_change)
    command_names, on_change = command_names or {""}, on_change or functions.empty
    local succes, output = pcall(menu.slider_float, parent, menu_name, command_names, help_text, min_value, max_value, default_value, step_size, on_change)
    if not succes then util.log("Error; "..output.." in slider_float.") end
    return succes and output or nil
end

function safe_menu.click_slider(parent, menu_name, command_names, help_text, min_value, max_value, default_value, step_size, on_click)
    command_names, on_click = command_names or {""}, on_click or functions.empty
    local succes, output = pcall(menu.click_slider, parent, menu_name, command_names, help_text, min_value, max_value, default_value, step_size, on_click)
    if not succes then util.log("Error; "..output.." in click_slider.") end
    return succes and output or nil
end

function safe_menu.click_slider_float(parent, menu_name, command_names, help_text, min_value, max_value, default_value, step_size, on_click)
    command_names, on_click = command_names or {""}, on_click or functions.empty
    local succes, output = pcall(menu.click_slider_float, parent, menu_name, command_names, help_text, min_value, max_value, default_value, step_size, on_click)
    if not succes then util.log("Error; "..output.." in click_slider_float.") end
    return succes and output or nil
end

function safe_menu.list_select(parent, menu_name, command_names, help_text, options, default_value, on_change)
    command_names, options, on_change = command_names or {""}, options or {""}, on_change or functions.empty
    local succes, output = pcall(menu.list_select, parent, menu_name, command_names, help_text, options, default_value, on_change)
    if not succes then util.log("Error; "..output.." in list_select.") end
    return succes and output or nil
end

function safe_menu.list_action(parent, menu_name, command_names, help_text, options, on_item_click)
    command_names, options, on_item_click = command_names or {""}, options or {""}, on_item_click or functions.empty
    local succes, output = pcall(menu.list_action, parent, menu_name, command_names, help_text, options, on_item_click)
    if not succes then util.log("Error; "..output.." in list_action.") end
    return succes and output or nil
end

function safe_menu.text_input(parent, menu_name, command_names, help_text, on_change, default_value)
    command_names, on_change, default_value = command_names or {""}, on_change or functions.empty, default_value or ""
    local succes, output = pcall(menu.text_input, parent, menu_name, command_names, help_text, on_change, default_value)
    if not succes then util.log("Error; "..output.." in text_input.") end
    return succes and output or nil
end

function safe_menu.colour(parent, menu_name, command_names, help_text, default, transparency, on_change)
    command_names, default, on_change = command_names or {""}, default or nil, on_change or functions.empty
    local succes, output = pcall(menu.colour, parent, menu_name, command_names, help_text, default, transparency, on_change)
    if not succes then util.log("Error; "..output.." in colour.") end
    return succes and output or nil
end

function safe_menu.colour_rbga(parent, menu_name, command_names, help_text, default_r, default_g, default_b, default_a, on_change)
    command_names, default_r, default_g, default_b, default_a, on_change = command_names or {""}, default_r or 1, default_g or 1, default_b or 1, default_a or 1, on_change or functions.empty
    local succes, output = pcall(menu.colour, parent, menu_name, command_names, help_text, default_r, default_g, default_b, default_a, on_change)
    if not succes then util.log("Error; "..output.." in colour_rbga.") end
    return succes and output or nil
end

function safe_menu.rainbow(colour_command)
    local succes, output = pcall(menu.rainbow, colour_command)
    if not succes then util.log("Error; "..output.." in rainbow.") end
    return succes and output:isValid() and output or nil
end

function safe_menu.divider(parent, menu_name)
    local succes, output = pcall(menu.divider, parent, menu_name)
    if not succes then util.log("Error; "..output.." in divider.") end
    return succes and output or nil
end

function safe_menu.readonly(parent, menu_name, value)
    value = value or ""
    local succes, output = pcall(menu.readonly, parent, menu_name, value)
    if not succes then util.log("Error; "..output.." in readonly.") end
    return succes and output or nil
end

function safe_menu.hyperlink(parent, menu_name, link, help_text)
    help_text = help_text or ""
    local succes, output = pcall(menu.hyperlink, parent, menu_name, link, help_text)
    if not succes then util.log("Error; "..output.." in hyperlink.") end
    return succes and output or nil
end

function safe_menu.action_slider(parent, menu_name, command_names, help_text, options, on_click)
    command_names, options, on_click = command_names or {""}, options or {""}, on_click or functions.empty
    local succes, output = pcall(menu.action_slider, parent, menu_name, command_names, help_text, options, on_click)
    if not succes then util.log("Error; "..output.." in action_slider.") end
    return succes and output or nil
end

function safe_menu.slider_text(parent, menu_name, command_names, help_text, options, on_click)
    command_names, options, on_click = command_names or {""}, options or {""}, on_click or functions.empty
    local succes, output = pcall(menu.slider_text, parent, menu_name, command_names, help_text, options, on_click)
    if not succes then util.log("Error; "..output.." in slider_text.") end
    return succes and output or nil
end

function safe_menu.apply_command_states()
    local succes, output = pcall(menu.apply_command_states)
    if not succes then util.log("Error; "..output.." in apply_command_states.") end
    return succes and output or nil
end

function safe_menu.delete(command)
    local succes, output = pcall(menu.delete, command)
    if not succes then util.log("Error; "..output.." in delete.") end
    return succes and output or nil
end

function safe_menu.replace(old, new)
    local succes, output = pcall(menu.replace, old, new)
    if not succes then util.log("Error; "..output.." in replace.") end
    return succes and output or nil
end

function safe_menu.detach(command)
    local succes, output = pcall(menu.detach, command)
    if not succes then util.log("Error; "..output.." in detach.") end
    return succes and output or nil
end

function safe_menu.attach(parent, command)
    local succes, output = pcall(menu.attach, parent, command)
    if not succes then util.log("Error; "..output.." in attach.") end
    return succes and output or nil
end

function safe_menu.attach_after(anchor, command)
    local succes, output = pcall(menu.attach_after, anchor, command)
    if not succes then util.log("Error; "..output.." in attach_after.") end
    return succes and output or nil
end

function safe_menu.attach_before(anchor, command)
    local succes, output = pcall(menu.attach_before, anchor, command)
    if not succes then util.log("Error; "..output.." in attach_before.") end
    return succes and output or nil
end

function safe_menu.is_ref_valid(ref)
    local succes, output = pcall(menu.is_ref_valid, ref)
    if not succes then util.log("Error; "..output.." in is_ref_valid.") end
    return succes and output or nil
end

function safe_menu.focus(command)
    local succes, output = pcall(menu.focus, command)
    if not succes then util.log("Error; "..output.." in focus.") end
    return succes and output or nil
end

function safe_menu.is_focused(command)
    local succes, output = pcall(menu.is_focused, command)
    if not succes then util.log("Error; "..output.." in is_focused.") end
    return succes and output or nil
end

function safe_menu.get_applicable_players(command, include_user)
    local succes, output = pcall(menu.get_applicable_players, command, include_user)
    if not succes then util.log("Error; "..output.." in get_applicable_players.") end
    return succes and output or nil
end

function safe_menu.get_parent(command)
    local succes, output = pcall(menu.get_parent, command)
    if not succes then util.log("Error; "..output.." in get_parent.") end
    return succes and output or nil
end

function safe_menu.get_type(command)
    local succes, output = pcall(menu.get_type, command)
    if not succes then util.log("Error; "..output.." in get_type.") end
    return succes and output or nil
end

function safe_menu.get_children(list)
    local succes, output = pcall(menu.get_children, list)
    if not succes then util.log("Error; "..output.." in get_children.") end
    return succes and output or nil
end

function safe_menu.collect_garbage()
    local succes, output = pcall(menu.collect_garbage)
    if not succes then util.log("Error; "..output.." in collect_garbage.") end
    return succes and output or nil
end

function safe_menu.is_open()
    local succes, output = pcall(menu.is_open)
    if not succes then util.log("Error; "..output.." in is_open.") end
    return succes and output or nil
end

function safe_menu.get_position()
    local succes, output = pcall(menu.get_position)
    if not succes then util.log("Error; "..output.." in get_position.") end
    return succes and output or nil
end

function safe_menu.get_main_view_position_and_size()
    local succes, output = pcall(menu.get_main_view_position_and_size)
    if not succes then util.log("Error; "..output.." in get_main_view_position_and_size.") end
    return succes and output or nil
end

function safe_menu.get_current_ui_list()
    local succes, output = pcall(menu.get_current_ui_list)
    if not succes then util.log("Error; "..output.." in get_current_ui_list.") end
    return succes and output or nil
end

function safe_menu.get_current_menu_list()
    local succes, output = pcall(menu.get_current_menu_list)
    if not succes then util.log("Error; "..output.." in get_current_menu_list.") end
    return succes and output or nil
end

function safe_menu.get_active_list_cursor_text(even_when_disabled, even_when_inappropriate)
    local succes, output = pcall(menu.get_active_list_cursor_text, even_when_disabled, even_when_inappropriate)
    if not succes then util.log("Error; "..output.." in get_active_list_cursor_text.") end
    return succes and output or nil
end

function safe_menu.are_tabs_visible()
    local succes, output = pcall(menu.are_tabs_visible)
    if not succes then util.log("Error; "..output.." in are_tabs_visible.") end
    return succes and output or nil
end

function safe_menu.show_command_box(prefill)
    local succes, output = pcall(menu.show_command_box, prefill)
    if not succes then util.log("Error; "..output.." in show_command_box.") end
    return succes and output or nil
end

function safe_menu.show_command_box_click_based(click_type, prefill)
    local succes, output = pcall(menu.show_command_box_click_based, click_type, prefill)
    if not succes then util.log("Error; "..output.." in show_command_box_click_based.") end
    return succes and output or nil
end

function safe_menu.trigger_commands(input)
    local succes, output = pcall(menu.trigger_commands, input)
    if not succes then util.log("Error; "..output.." in trigger_commands.") end
    return succes and output or nil
end

function safe_menu.trigger_command(command, arg)
    arg = arg or ""
    local succes, output = pcall(menu.trigger_command, command, arg)
    if not succes then util.log("Error; "..output.." in trigger_command.") end
    return succes and output or nil
end

function safe_menu.command_box_is_open()
    local succes, output = pcall(menu.command_box_is_open)
    if not succes then util.log("Error; "..output.." in command_box_is_open.") end
    return succes and output or nil
end

function safe_menu.command_box_get_dimensions()
    local succes, output = pcall(menu.command_box_get_dimensions)
    if not succes then util.log("Error; "..output.." in command_box_get_dimensions.") end
    return succes and output or nil
end

function safe_menu.is_in_screenshot_mode()
    local succes, output = pcall(menu.is_in_screenshot_mode)
    if not succes then util.log("Error; "..output.." in is_in_screenshot_mode.") end
    return succes and output or nil
end

function safe_menu.on_tick_in_viewport(command, callback)
    local succes, output = pcall(menu.on_tick_in_viewport, command, callback)
    if not succes then util.log("Error; "..output.." in on_tick_in_viewport.") end
    return succes and output or nil
end

function safe_menu.on_focus(command, callback)
    local succes, output = pcall(menu.on_focus, command, callback)
    if not succes then util.log("Error; "..output.." in on_focus.") end
    return succes and output or nil
end

function safe_menu.on_blur(command, callback)
    local succes, output = pcall(menu.on_blur, command, callback)
    if not succes then util.log("Error; "..output.." in on_blur.") end
    return succes and output or nil
end

function safe_menu.remove_handler(command, handler_id)
    local succes, output = pcall(menu.remove_handler, command, handler_id)
    if not succes then util.log("Error; "..output.." in remove_handler.") end
    return succes and output or nil
end

function safe_menu.get_menu_name(command)
    local succes, output = pcall(menu.get_menu_name, command)
    if not succes then util.log("Error; "..output.." in get_menu_name.") end
    return succes and output or nil
end

function safe_menu.get_command_names(command)
    local succes, output = pcall(menu.get_command_names, command)
    if not succes then util.log("Error; "..output.." in get_command_names.") end
    return succes and output or nil
end

function safe_menu.get_help_text(command)
    local succes, output = pcall(menu.get_help_text, command)
    if not succes then util.log("Error; "..output.." in get_help_text.") end
    return succes and output or nil
end

function safe_menu.get_name_for_config(command)
    local succes, output = pcall(menu.get_name_for_config, command)
    if not succes then util.log("Error; "..output.." in get_name_for_config.") end
    return succes and output or nil
end

function safe_menu.get_visible(command)
    local succes, output = pcall(menu.get_visible, command)
    if not succes then util.log("Error; "..output.." in get_visible.") end
    return succes and output or nil
end

function safe_menu.get_value(command)
    local succes, output = pcall(menu.get_value, command)
    if not succes then util.log("Error; "..output.." in get_value.") end
    return succes and output or nil
end

function safe_menu.get_min_value(command)
    local succes, output = pcall(menu.get_min_value, command)
    if not succes then util.log("Error; "..output.." in get_min_value.") end
    return succes and output or nil
end

function safe_menu.get_max_value(command)
    local succes, output = pcall(menu.get_max_value, command)
    if not succes then util.log("Error; "..output.." in get_max_value.") end
    return succes and output or nil
end

function safe_menu.get_step_size(command)
    local succes, output = pcall(menu.get_step_size, command)
    if not succes then util.log("Error; "..output.." in get_step_size.") end
    return succes and output or nil
end

function safe_menu.get_state(command)
    local succes, output = pcall(menu.get_state, command)
    if not succes then util.log("Error; "..output.." in get_state.") end
    return succes and output or nil
end

function safe_menu.get_default_state(command)
    local succes, output = pcall(menu.get_default_state, command)
    if not succes then util.log("Error; "..output.." in get_default_state.") end
    return succes and output or nil
end

function safe_menu.set_menu_name(command, menu_name)
    local succes, output = pcall(menu.set_menu_name, command, menu_name)
    if not succes then util.log("Error; "..output.." in set_menu_name.") end
    return succes and output or nil
end

function safe_menu.set_command_names(command, command_names)
    local succes, output = pcall(menu.set_command_names, command, command_names)
    if not succes then util.log("Error; "..output.." in set_command_names.") end
    return succes and output or nil
end

function safe_menu.set_help_text(command, help_text)
    local succes, output = pcall(menu.set_help_text, command, help_text)
    if not succes then util.log("Error; "..output.." in set_help_text.") end
    return succes and output or nil
end

function safe_menu.set_name_for_config(command, name_for_config)
    local succes, output = pcall(menu.set_name_for_config, command, name_for_config)
    if not succes then util.log("Error; "..output.." in set_name_for_config.") end
    return succes and output or nil
end

function safe_menu.set_visible(command, visible)
    local succes, output = pcall(menu.set_visible, command, visible)
    if not succes then util.log("Error; "..output.." in set_visible.") end
    return succes and output or nil
end

function safe_menu.set_value(command, value)
    local succes, output = pcall(menu.set_value, command, value)
    if not succes then util.log("Error; "..output.." in set_value.") end
    return succes and output or nil
end

function safe_menu.set_min_value(command, min_value)
    local succes, output = pcall(menu.set_min_value, command, min_value)
    if not succes then util.log("Error; "..output.." in set_min_value.") end
    return succes and output or nil
end

function safe_menu.set_max_value(command, max_value)
    local succes, output = pcall(menu.set_max_value, command, max_value)
    if not succes then util.log("Error; "..output.." in set_max_value.") end
    return succes and output or nil
end

function safe_menu.set_step_size(command, step_size)
    local succes, output = pcall(menu.set_step_size, command, step_size)
    if not succes then util.log("Error; "..output.." in set_step_size.") end
    return succes and output or nil
end

function safe_menu.set_list_action_options(command, options)
    options = options or {""}
    local succes, output = pcall(menu.set_list_action_options, command, options)
    if not succes then util.log("Error; "..output.." in set_list_action_options.") end
    return succes and output or nil
end

function safe_menu.set_action_slider_options(command, options)
    options = options or {""}
    local succes, output = pcall(menu.set_action_slider_options, command, options)
    if not succes then util.log("Error; "..output.." in set_action_slider_options.") end
    return succes and output or nil
end

function safe_menu.show_warning(command, click_type, message, proceed_callback, cancel_callback, skippable)
    proceed_callback, cancel_callback = proceed_callback or functions.empty, cancel_callback or functions.empty
    local succes, output = pcall(menu.show_warning, command, click_type, message, proceed_callback, cancel_callback, skippable)
    if not succes then util.log("Error; "..output.." in show_warning.") end
    return succes and output or nil
end

function safe_menu.get_activation_key_hash()
    local succes, output = pcall(menu.get_activation_key_hash)
    if not succes then util.log("Error; "..output.." in get_activation_key_hash.") end
    return succes and output or nil
end

function safe_menu.get_edition()
    local succes, output = pcall(menu.get_edition)
    if not succes then util.log("Error; "..output.." in get_edition.") end
    return succes and output or nil
end

return safe_menu
