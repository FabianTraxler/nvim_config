--[[ init.lua ]]

-- Impatient for faster loading 
require('impatient')

-- LEADER
-- These keybindings need to be defined before the first / is called; otherwise, it will default to "\"
vim.g.mapleader = " "		-- works across all nvim files
vim.g.localleader = "\\"	-- for specific file type


-- Color theme
require('monokai').setup { palette = require('monokai').pro }

-- Highlight colors 
vim.cmd([[
hi CursorLineNr guifg=#57a5e5
hi FoldColumn guifg=#4a4f54 guibg=#26292c
hi GitSignsAdd guibg=#193549 guifg=#3ad900
hi GitSignsChange guibg=#193549 guifg=#ffc600
hi GitSignsDelete guibg=#193549 guifg=#ff2600
hi ColorColumn guifg=NONE guibg=#204563 gui=NONE
]]) 

-- Lua line
require('lualine').setup{
    options = {
        fmt = string.lower,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
    }
}


-- IMPORTS 
require('vars')		-- Variables
require('opts')		-- Options
require('keys')	    -- Keymaps
require('plug')	    -- Plugins


----------------------------------------
-- PLUGINS initialization           ---- 
----------------------------------------


-- Better escape 
require("better_escape").setup {
    mapping = {"jk", "kj"}, -- a table with mappings to use
    timeout = vim.o.timeoutlen, -- the time in which the keys must be hit in ms. Use option timeoutlen by default
    clear_empty_lines = false, -- clear line after escaping if there is only whitespace
    keys = "<Esc>", -- keys used for escaping, if it is a function will use the result everytime
    -- example(recommended)
    -- keys = function()
    --   return vim.api.nvim_win_get_cursor(0)[2] > 1 and '<esc>l' or '<esc>'
    -- end,
}


-- FTerm 
require'FTerm'.setup({
    border = 'double',
    cmd = os.getenv('FISH'),
    blend = 15,
    dimensions  = {
        height = 0.9,
        width = 0.9,
    },
})
vim.keymap.set('n', 't', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- null-ls
require("null-ls").setup({
  sources = {
    require("null-ls").builtins.diagnostics.vale,
    require("null-ls").builtins.diagnostics.selene,
    require("null-ls").builtins.diagnostics.markdownlint.with({
        diagnostics_format =  "[#{c}] #{m} (#{s})",
        filter = function(diagnostic)
            return diagnostic.code ~= "MD013/line-length"
        end,
    }),
  },
})

-- Headlines for Markdown
require"headlines".setup()

-- Fidget - show status of LSP progress 
require"fidget".setup{
    window = {
        relative = "editor",
        blend = 10,
    },
}

-- Zen mode 
require("zen-mode").setup {

}

-- Specs -  Find the cursor (beacon update in Lua)
require('specs').setup{ 
    show_jumps  = true,
    min_jump = 10,
    popup = {
        delay_ms = 0, -- delay before popup displays
        inc_ms = 10, -- time increments used for fade/resize effects 
        blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
        width = 10,
        winhl = "PMenu",
        fader = require('specs').exp_fader,
        resizer = require('specs').shrink_resizer
    },
    ignore_filetypes = {},
    ignore_buftypes = {
        nofile = true,
    },
}

-- Vale prose lint 
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.diagnostics.vale,
    },
})


-- Hop 
require'hop'.setup{
    keys = 'etovxqpdygfblzhckisuran',
    jump_on_sole_occurrence = false,
    -- multi_windows = true,
    -- hint_offset = -1, 
}

-- Ident Lines
vim.cmd [[highlight IndentBlanklineIndent1 guifg=#504945 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#504945 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#504945 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#504945 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#504945 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#504945 gui=nocombine]]

require("indent_blankline").setup {
    char = '┆', 
    use_treesitter = true,
    use_treesitter_scope = true, 
    show_first_indent_level = true,
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}

-- Todo Comments Setup
require('todo-comments').setup{
 colors = {
    error = { "DiagnosticError", "ErrorMsg", "#de5d68" },
    warning = { "DiagnosticWarning", "WarningMsg", "#eeb927" },
    info = { "DiagnosticInfo", "#57a5e5" },
    hint = { "DiagnosticHint", "#bb70d2" },
    default = { "Identifier", "#de5d68" },
  },   
}

-- Trouble Setup
require('trouble').setup{
    position = "right",
    width = 75,
    padding = true,
    auto_preview = false,
}

-- Nvim Tree Setup
require('nvim-tree').setup{
  sort_by = "case_sensitive",
  view = {
    adaptive_size = false,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
    icons = {
      git_placement = "after",
      glyphs = {
          git = {
            unstaged = "-",
            staged = "s",
            untracked = "u",
            renamed = "r",
            deleted = "d",
            ignored = "i",
          },
      },
    },
  },
    filters = {
    dotfiles = false,
  },
}

-- Telescope Setup
require('telescope').setup{
    defaults = {
        file_ignore_patterns = { 
            "^./.git/", 
            "./target/",
            "LICENSE*"
        },
    },
    extensions = {
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = {"png", "webp", "jpg", "jpeg", "ppm", "pdf"},
          find_cmd = "rg", -- find command (defaults to `fd`)
        },
    },
}
-- lod extension to support previw of media files
require('telescope').load_extension('media_files');
-- Get fzf loaded and working with extension 
require('telescope').load_extension('fzf')


-- Autopairs Setup
require'nvim-autopairs'.setup{}


-- Mason Setup
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup()


-- Comment Setup
require('Comment').setup({
    mappings = {
        basic = false,
        extra = false,
        extended = false,
    },
})



----------------------------------------
-- LSP Server Configurations        ---- 
----------------------------------------

-- LSP Config 
local nvim_lsp = require'lspconfig'

-- RUST 
-- -------------------------------------

--local codelldb_path = '/home/rsdlt/.vscode/extensions/vadimcn.vscode-lldb-1.7.3/adapter/codelldb'
--local liblldb_path = '/home/rsdlt/.vscode/extensions/vadimcn.vscode-lldb-1.7.3/lldb/lib/liblldb.so'
local rt = {
    server = {
        settings = {
            on_attach = function(_, bufnr)
                -- Hover actions
               -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                -- Code action groups
                vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

                require 'illuminate'.on_attach(client)

            end,
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                }, 
            },
        }
    },
    dap = {   -- Configure DAP Debugger in case I need it in the future 
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    }
}
require('rust-tools').setup(rt)



-- LUA 
-- -------------------------------------
require'lspconfig'.sumneko_lua.setup{
  settings = {
      Lua = {
        runtime = {
          version = 'Lua 5.4',
          path = {
            '?.lua',
            '?/init.lua',
            vim.fn.expand'~/.luarocks/share/lua/5.4/?.lua',
            vim.fn.expand'~/.luarocks/share/lua/5.4/?/init.lua',
            '/usr/share/5.4/?.lua',
            '/usr/share/lua/5.4/?/init.lua'
          }
        },
        workspace = {
          library = {
            vim.fn.expand'~/.luarocks/share/lua/5.4',
            '/usr/share/lua/5.4'
          }
        }
      }
    }
}


-- LatEx with TexLab
require'lspconfig'.texlab.setup{
    texlab = {
        auxDirectory = ".",
        bibtexFormatter = "texlab",
        build = {
          args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
          executable = "latexmk",
          forwardSearchAfter = false,
          onSave = false
        },
        chktex = {
          onEdit = false,
          onOpenAndSave = false
        },
        diagnosticsDelay = 300,
        formatterLineLength = 80,
        forwardSearch = {
          args = {}
        },
        latexFormatter = "latexindent",
        latexindent = {
          modifyLineBreaks = false
        }
  }
}


-- Marksman 
require'lspconfig'.marksman.setup{
}




----------------------------------------
-- COMPLETION Setup                 ---- 
----------------------------------------

require('lspkind').init({
    -- mode = 'symbol_text'
})


vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 350) 

local lspkind = require('lspkind')
local cmp = require'cmp'

cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For 'vsnip' users. 
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm { select = false }
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                                              -- file paths
    { name = 'nvim_lsp', keyword_length = 1, priority = 10 },       -- from language server
    { name = 'luasnip', keyword_length = 1, priority = 8 },         -- for lua users
    { name = 'nvim_lsp_signature_help', priority = 8},               -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 1, priority =9},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 1, priority =7 },        -- source current buffer
    -- { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = {
          cmp.config.window.bordered(),
          col_offset = 3,
          side_padding = 1,
      },
      documentation = cmp.config.window.bordered(),

  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      -- format = function(entry, item)
      --     local menu_icon ={
      --         nvim_lsp = 'λ',
      --         luasnip = '⋗',
      --         buffer = 'Ω',
      --         path = '🖫',
      --     }
      --     item.menu = menu_icon[entry.source.name]
      --     return item
      -- end,
       
        format = lspkind.cmp_format({
          mode = 'symbol_text', -- show only symbol annotations
          maxwidth = 60, -- prevent the popup from showing more than provided characters 
          -- The function below will be called before any actual modifications from lspkind:
          before = function (entry, vim_item)
            local menu_icon ={
                  nvim_lsp = 'λ ',
                  luasnip = '⋗ ',
                  buffer = 'Ω ',
                  path = '🖫 ',
              }
              vim_item.menu = menu_icon[entry.source.name]
            return vim_item
          end,
        })

  },
  preselect = cmp.PreselectMode.None,
  confirmation = {
      get_commit_characters = function(commit_characters)
          return {}
      end
  },
})

-- `/` cmdline setup.
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})
-- `:` cmdline setup.
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})



----------------------------------------
-- TREE-SITTER Setup                ---- 
----------------------------------------

require('nvim-treesitter.configs').setup {
  ensure_installed = { "bash", "c", "cmake", "css", "dockerfile", "go", "gomod", "gowork", "hcl", "help", "html", "http", "javascript", "json", "lua", "make", "markdown", "python", "regex", "ruby", "rust", "toml", "vim", "yaml", "zig" },
  auto_install = true,
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<S-Tab>", -- normal mode
      node_incremental = "<Tab>", -- visual mode
      node_decremental = "<S-Tab", -- visual mode
    },
  },
  ident = { enable = true },
  rainbow = {
    enable = true,
  }
}


------------------------------------
-- Nvim UFO - GOOD FOLDING      ----
--https://github.com/kevinhwang91/nvim-ufo
-- ---------------------------------
vim.cmd([[
augroup MyColors
autocmd!
augroup end
]])



vim.o.foldcolumn = '1'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- Option 3: treesitter as a main provider instead
-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
-- require('ufo').setup({
--     provider_selector = function(bufnr, filetype, buftype)
--         return {'treesitter', 'indent'}
--     end
-- })
local handler = function(virtText, lnum, endLnum, width, truncate)
local newVirtText = {}
local suffix = ('  %d '):format(endLnum - lnum)
local sufWidth = vim.fn.strdisplaywidth(suffix)
local targetWidth = width - sufWidth
local curWidth = 0
for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
    else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, {chunkText, hlGroup})
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
        end
        break
    end
    curWidth = curWidth + chunkWidth
end
table.insert(newVirtText, {suffix, 'MoreMsg'})
return newVirtText
end

-- global handler
require('ufo').setup({
    fold_virt_text_handler = handler,

    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
})

-- buffer scope handler
-- will override global handler if it is existed
local bufnr = vim.api.nvim_get_current_buf()
require('ufo').setFoldVirtTextHandler(bufnr, handler)


vim.opt.foldcolumn = '6'
