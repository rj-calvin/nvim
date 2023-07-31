(fn current_file []
  (let [util (require :formatter.util)]
    (-> (util.get_current_buffer_file_path) util.escape_path)))

(fn clangformat []
  (let [defaults (require :formatter.defaults.clangformat)
        {: apply_defaults} (require :plenary.tbl)]
    (apply_defaults {:args [:--assume-filename (current_file)]} (defaults))))

(let [defaults (require :formatter.defaults)]
  {:filetype {:typescript [defaults.prettier]
              :typescriptreact [defaults.prettier]
              :javascript [defaults.prettier]
              :javascriptreact [defaults.prettier]
              :svelte [defaults.prettier]
              :lua [defaults.stylua]
              :rust [defaults.rustfmt]
              :c [clangformat]
              :cpp [clangformat]
              :java [clangformat]
              :purescript [#{:exe :purs-tidy :args [:format] :stdin true}]
              :elixir [#{:exe :mix :args [:format (current_file)] :stdin false}]
              :fennel [#{:exe :fnlfmt :args [(current_file)] :stdin true}]
              :tex [#{:exe :latexindent
                      :args [:-m :-l :-g :/dev/null "-"]
                      :stdin true}]
              :context [#{:exe :latexindent
                          :args [:-m :-l :-g :/dev/null "-"]
                          :stdin true}]}})

