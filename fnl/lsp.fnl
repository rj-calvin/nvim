(fn setup_handler [on_attach capabilities server]
  (let [{: setup} (. (require :lspconfig) server)]
    (setup {: on_attach : capabilities})))

(fn setup [on_attach capabilities]
  (let [{: setup_handlers} (require :mason-lspconfig)]
    (setup_handler on_attach capabilities :unison)
    (setup_handler on_attach capabilities :hls)
    (setup_handlers {1 (partial setup_handler on_attach capabilities)})))

{: setup}

