local M = {}

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

M.options = {
  default = { noremap = true, silent = true },
  term_opts = { silent = true },
}

M.keymaps = {
  n = {
    -- Save like a normal IDE
    ["<C-s>"] = "<cmd>w<cr>",

    -- Vertical Navigation
    ["<C-d>"] = "<C-d>zz",
    ["<C-u>"] = "<C-u>zz",

    -- Window Navigation
    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",

    -- Resize Windows
    ["<C-Up>"] = "<cmd>resize +2<CR>",
    ["<C-Down>"] = "<cmd>resize -2<CR>",
    ["<C-Right>"] = "<cmd>vertical resize -2<CR>",
    ["<C-Left>"] = "<cmd>vertical resize +2<CR>",

    -- Move text up and down
    ["<A-k>"] = "<cmd>move .-2<CR>==",
    ["<A-j>"] = "<cmd>move .+1<CR>==",

    -- Buffer navigation
    ["<Tab>"] = "<cmd>BufferLineCycleNext<cr>",
    ["<S-Tab>"] = "<cmd>BufferLineCyclePrev<cr>",

    -- Substitute the every ocurrence of the word your on
    ["<leader>s"] = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  },
  i = {
    -- Save like a normal IDE
    ["<C-s>"] = "<cmd>w<cr>",

    -- Vertical Navigation
    ["<C-d>"] = "<C-d>zz",
    ["<C-u>"] = "<C-u>zz",

    -- Move text up and down
    ["<A-k>"] = "<Esc><cmd>m .-2<CR>==gi",
    ["<A-j>"] = "<Esc><cmd>m .+1<CR>==gi",
  },
  v = {
    -- Move text up and down
    ["<A-j>"] = "<cmd>m .+1<CR>==",
    ["<A-k>"] = "<cmd>m .-2<CR>==",

    -- Stay in indent mode after adding or removing tabs
    ["<"] = "<gv",
    [">"] = ">gv",

    -- Substitute the selected text with clipboard text
    ["p"] = '"_dP',
  },
  x = {
    -- Move text up and down
    ["<A-j>"] = ":move '>+1<CR>gv=gv",
    ["<A-k>"] = ":move '<-2<CR>gv=gv",
  },
  t = {
    -- Toggle Terminal
    ["<C-\\>"] = "<cmd>lua require('nvterm.terminal').toggle('horizontal') <cr>",

    -- Resize Windows
    ["<C-Up>"] = "<cmd>resize +2<CR>",
    ["<C-Down>"] = "<cmd>resize -2<CR>",

    -- Better terminal navigation
    ["<C-h>"] = "<C-\\><C-N><C-w>h",
    ["<C-l>"] = "<C-\\><C-N><C-w>l",
    ["<C-j>"] = "<C-\\><C-N><C-w>j",
    ["<C-k>"] = "<C-\\><C-N><C-w>k",
  },
}

return M
