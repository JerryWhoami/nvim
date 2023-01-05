local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	return
end

local status_comment_integration, comment_integration =
	pcall(require, "ts_context_commentstring.integrations.comment_nvim")
if not status_comment_integration then
	return
end

comment.setup({
  pre_hook = comment_integration.create_pre_hook(),
})
