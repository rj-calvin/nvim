(fn current_file []
  (let [util (require :formatter.util)]
    (-> (util.get_current_buffer_file_path) util.escape_path)))

(let [filetypes (require :formatter.filetypes)]
  {:filetype {:typescript [(. filetypes.typescript :prettier)]
              :lua [(. filetypes.lua :stylua)]
              :rust [(. filetypes.rust :rustfmt)]
              :elixir [#{:exe :mix :args [:format (current_file)] :stdin false}]
              :fennel [#{:exe :fnlfmt :args [(current_file)] :stdin true}]}})

