(fn setup []
  (let [configs (require :lspconfig.configs)
        {: root_pattern} (require :lspconfig.util)]
    (tset configs :ucm {:default_config {:cmd [:netcat :localhost :5757]
                                         :filetypes [:unison]
                                         :root_dir (root_pattern :.unison/)
                                         :settings {}}})))

(fn setup_handler [on_attach capabilities server]
  (let [{: setup} (. (require :lspconfig) server)]
    (setup {: on_attach : capabilities})))

(fn sumneko_lua [on_attach capabilities]
  (let [{: setup} (. (require :lspconfig) :sumneko_lua)]
    (setup {: on_attach
            : capabilities
            :settings {:Lua {:diagnostics {:globals [:vim]}
                             :workspace {:checkThirdParty false
                                         :library {(vim.fn.expand :$VIMRUNTIME/lua) true
                                                   (vim.fn.expand :$VIMRUNTIME/lua/vim/lsp) true}}}}})))

{: setup : setup_handler : sumneko_lua}

