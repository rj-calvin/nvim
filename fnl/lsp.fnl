(fn setup []
  (let [configs (require :lspconfig.configs)]
    nil))

(fn fallback [on_attach capabilities server]
  (let [{: setup} (. (require :lspconfig) server)]
    (setup {: on_attach : capabilities})))

(fn sumneko_lua [on_attach capabilities]
  (let [{: setup} (. (require :lspconfig) :sumneko_lua)]
    (setup {: on_attach
            : capabilities
            :settings {:Lua {:diagnostics {:globals [:vim]}
                             :workspace {:library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                                   (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}}}}})))

{: setup : fallback : sumneko_lua}
