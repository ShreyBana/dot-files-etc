local servers = { 'tsserver', 'jsonls', 'purescriptls', 'sourcekit', 'jdtls', 'rust_analyzer', 'pylsp' }

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float({ border = "double" })<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.goto_prev({ float = { border = "double" } })<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>D', '<cmd>lua vim.diagnostic.goto_next({ float = { border = "double" } })<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lsp_config = require('lspconfig')
for _, server in pairs(servers) do
  lsp_config[server].setup {
    capabilities = capabilties,
    on_attach = on_attach,
     handlers = {
       ["textDocument/publishDiagnostics"] = vim.lsp.with(
         vim.lsp.diagnostic.on_publish_diagnostics, {
          -- Disable virtual_text
          virtual_text = false
         }
      ),
      ["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = "double"
        }
      )
    },
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

lsp_config.groovyls.setup {
  cmd = { "java", "-jar", "/Users/shrey.bana/.lsp/groovy-language-server/build/libs/groovy-language-server-all.jar" },
  capabilities = capabilties,
  on_attach = on_attach,
   handlers = {
       ["textDocument/publishDiagnostics"] = vim.lsp.with(
         vim.lsp.diagnostic.on_publish_diagnostics, {
          -- Disable virtual_text
          virtual_text = false
         }
      ),
      ["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = "double"
        }
      )
    },
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  },
  filetypes = { "groovy", "Jenkinsfile" }
}

lsp_config.hls.setup {
  settings = {
    haskell = {
      formattingProvider = "stylish-haskell"
    }
  },
  capabilities = capabilties,
  on_attach = on_attach,
   handlers = {
     ["textDocument/publishDiagnostics"] = vim.lsp.with(
       vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Disable virtual_text
        virtual_text = false,
        border = "double"
       }
    ),
     ["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = "double"
        }
    )
  },
  flags = {
    -- This will be the default in neovim 0.7+
    debounce_text_changes = 150,
  },
}

local function lspSymbol(name, icon)
vim.fn.sign_define(
	'DiagnosticSign' .. name,
	{ text = icon, numhl = 'DiagnosticDefault' .. name, texthl = 'DiagnosticSign' .. name }
)
end
lspSymbol('Error', '')
lspSymbol('Information', '')
lspSymbol('Hint', '')
lspSymbol('Info', '')
lspSymbol('Warning', '')
