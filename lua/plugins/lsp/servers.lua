-- ~/.config/nvim/lua/plugins/lsp/servers.lua

return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>lm", "<cmd>Mason<CR>", desc = "Mason" } },
    opts = {
      ui = {
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
        border = "rounded",
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls", "pyright", "ts_ls", "rust_analyzer", "gopls",
        "html", "cssls", "jsonls", "yamlls", "bashls", "dockerls", "marksman",
      },
      automatic_installation = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local function on_attach(client, bufnr)
        -- Don't attach to read-only or special buffers (neo-tree, help, etc.)
        if not vim.bo[bufnr].modifiable or vim.bo[bufnr].buftype ~= "" then
          return
        end

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "gd",  vim.lsp.buf.definition,    "Go to definition")
        map("n", "gD",  vim.lsp.buf.declaration,   "Go to declaration")
        map("n", "gi",  vim.lsp.buf.implementation,"Go to implementation")
        map("n", "gr",  vim.lsp.buf.references,    "References")
        map("n", "K",   vim.lsp.buf.hover,         "Hover docs")
        map("i", "<C-s>", vim.lsp.buf.signature_help, "Signature help")
        map("n",        "<leader>lr", vim.lsp.buf.rename,      "Rename")
        map({ "n","v" },"<leader>la", vim.lsp.buf.code_action, "Code action")
        map("n",        "<leader>lf", function()
          vim.lsp.buf.format({ async = true })
        end, "Format")
        map("n", "<leader>ld", vim.diagnostic.open_float, "Diagnostic float")
        map("n", "[d",         vim.diagnostic.goto_prev,  "Prev diagnostic")
        map("n", "]d",         vim.diagnostic.goto_next,  "Next diagnostic")
      end

      -- Server configs -------------------------------------------------------

      vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
        on_attach = on_attach, capabilities = capabilities,
      })

      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
        settings = {
          python = {
            analysis = {
              autoSearchPaths    = true,
              useLibraryCodeForTypes = true,
              diagnosticMode     = "workspace",
            },
          },
        },
        on_attach = on_attach, capabilities = capabilities,
      })

      vim.lsp.config("ts_ls", {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
        init_options = {
          preferences = { includeCompletionsForModuleExports = true },
        },
        on_attach = on_attach, capabilities = capabilities,
      })

      vim.lsp.config("rust_analyzer", {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", ".git" },
        settings = { ["rust-analyzer"] = { checkOnSave = { command = "clippy" } } },
        on_attach = on_attach, capabilities = capabilities,
      })

      vim.lsp.config("gopls", {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.mod", ".git" },
        settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
        on_attach = on_attach, capabilities = capabilities,
      })

      vim.lsp.config("html", {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html" },
        root_markers = { "package.json", ".git" },
        on_attach = on_attach, capabilities = capabilities,
      })

      vim.lsp.config("cssls", {
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less" },
        root_markers = { "package.json", ".git" },
        on_attach = on_attach, capabilities = capabilities,
      })

      vim.lsp.config("jsonls", {
        cmd = { "vscode-json-language-server", "--stdio" },
        filetypes = { "json", "jsonc" },
        root_markers = { "package.json", ".git" },
        on_attach = on_attach, capabilities = capabilities,
      })

      vim.lsp.config("yamlls", {
        cmd = { "yaml-language-server", "--stdio" },
        filetypes = { "yaml", "yml" },
        root_markers = { ".git" },
        settings = { yaml = { keyOrdering = false } },
        on_attach = on_attach, capabilities = capabilities,
      })

      vim.lsp.config("bashls", {
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "bash" },
        root_markers = { ".git" },
        on_attach = on_attach, capabilities = capabilities,
      })

      vim.lsp.config("dockerls", {
        cmd = { "docker-langserver", "--stdio" },
        filetypes = { "dockerfile" },
        root_markers = { ".git" },
        on_attach = on_attach, capabilities = capabilities,
      })

      vim.lsp.config("marksman", {
        cmd = { "marksman" },
        filetypes = { "markdown" },
        root_markers = { ".git", ".marksman.toml" },
        on_attach = on_attach, capabilities = capabilities,
      })

      vim.lsp.enable({
        "lua_ls", "pyright", "ts_ls", "rust_analyzer", "gopls",
        "html", "cssls", "jsonls", "yamlls", "bashls", "dockerls", "marksman",
      })
    end,
  },
}
