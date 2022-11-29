(fn setup []
  (let [{: setup : load_extension} (require :telescope)
        fzf_path (.. (vim.fn.stdpath :config)
                     :/pack/plugin/start/telescope-fzf-native.nvim)]
    (if (> (-> (.. fzf_path :/build) vim.fn.glob vim.fn.empty) 0)
        (do
          (print "building fzf...")
          (vim.fn.system [:make :-C fzf_path])))
    (setup {})
    (load_extension :fzf)))

{: setup}
