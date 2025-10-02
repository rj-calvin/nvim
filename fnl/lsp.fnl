(fn default_config [server]
  (. (require (.. :lspconfig.configs. server)) :default_config))

(fn setup_handler [on_attach capabilities server]
  (let [{: setup} (. (require :lspconfig) server)]
    (setup {: on_attach : capabilities})))

(fn setup [on_attach capabilities]
  (let [{: setup} (require :mason-lspconfig)]
    (setup {:automatic_enable []})))

{: setup}

