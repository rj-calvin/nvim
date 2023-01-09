(tset vim.o :mouse nil)

(let [{: setup} (require :mason)]
  (setup))

(let [{: setup} (require :mason-lspconfig)]
  (setup))

(let [{: setup} (require :formatter)]
  (setup (require :config.formatter)))

(let [{: setup} (require :nvim-terminal)]
  (setup {:disable_default_keymaps true}))

(let [{: setup} (require :neo-tree)]
  (tset vim.g :neo_tree_remove_legacy_commands 1)
  (setup (require :config.neo-tree)))

(let [{: setup} (require :nvim-treesitter.configs)]
  (setup (require :config.nvim-treesitter)))

(let [{: setup} (require :keymaps)]
  (setup))

(let [{: setup} (require :lsp)]
  (setup))

(let [{: setup} (require :fzf)]
  (setup))

(let [{: nvim_create_autocmd : nvim_create_augroup} vim.api
      group (nvim_create_augroup :hotpot-ft {})
      callback #(pcall require (.. :ftplugin. (vim.fn.expand :<amatch>)))]
  (nvim_create_autocmd :FileType {: callback : group}))

(let [{: setup_handlers} (require :mason-lspconfig)
      {: on_attach} (require :keymaps)
      capabilities ((. (require :cmp_nvim_lsp) :default_capabilities))
      {: setup_handler : sumneko_lua} (require :lsp)]
  (setup_handler on_attach capabilities :ucm)
  (setup_handlers {1 (partial setup_handler on_attach capabilities)
                   :sumneko_lua #(sumneko_lua on_attach capabilities)}))

(let [luasnip (require :luasnip)
      cmp (require :cmp)
      {: completion} (require :keymaps)]
  (cmp.setup {:snippet {:expand (lambda [{: body}]
                                  (luasnip.lsp_expand body))}
              :mapping (cmp.mapping.preset.insert (completion))
              :sources [{:name :nvim_lsp} {:name :luasnip}]}))

