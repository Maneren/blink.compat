local context = {}

function context.empty()
  return {
    id = '',
    prev_context = {},
    option = { reason = 'none' },
    cache = { entries = {} },
    filetype = '',
    time = vim.uv.now(),
    bufnr = -1,
    cursor = {
      row = -1,
      col = -1,
      line = -1,
      character = '',
    },
    cursor_line = '',
    cursor_after_line = '',
    cursor_before_line = '',
    aborted = false,
  }
end

--- @module 'blink.cmp'
--- @param ctx blink.cmp.Context
function context.new(ctx)
  return {
    id = tostring(ctx.id),
    -- NOTE: prev_context is just an empty context. AFAIK this is fine because nothing actually uses it.
    prev_context = context.empty(),
    option = { reason = 'none' },
    cache = { entries = {} },
    filetype = vim.api.nvim_get_option_value('filetype', { buf = ctx.bufnr }),
    time = vim.uv.now(),
    bufnr = ctx.bufnr,
    cursor = {
      row = ctx.cursor[1],
      col = ctx.cursor[2] + 1,
      line = ctx.cursor[1] - 1,
      character = vim.str_utfindex(
        ctx.line,
        vim.api.nvim_get_option_value('fileencoding', { buf = ctx.bufnr }),
        ctx.cursor[2]
      ),
    },
    cursor_line = ctx.line,
    cursor_after_line = string.sub(ctx.line, ctx.cursor[2] + 1),
    cursor_before_line = string.sub(ctx.line, 1, ctx.cursor[2]),
    aborted = false,
  }
end

return context