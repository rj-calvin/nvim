(let [util (require :formatter.util)
      filetypes (require :formatter.filetypes)]
  {:filetype {:typescript [(. filetypes.typescript :prettier)]
              :lua [(. filetypes.lua :stylua)]
              :fennel [#{:exe :fnlfmt
                         :args [(-> (util.get_current_buffer_file_path)
                                    util.escape_path)]
                         :stdin true}]}})

