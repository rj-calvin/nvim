(fn setup []
  (let [diagnostic vim.diagnostic
        telescope (require :telescope.builtin)
        terminal (. (require :nvim-terminal) :DefaultTerminal)]
    (vim.keymap.set :t :<c-\><c-\> :<c-\><c-n> {})
    (vim.keymap.set :t :<c-h> :<c-\><c-n><c-w><c-h> {})
    (vim.keymap.set :t :<c-j> :<c-\><c-n><c-w><c-j> {})
    (vim.keymap.set :t :<c-k> :<c-\><c-n><c-w><c-k> {})
    (vim.keymap.set :t :<c-l> :<c-\><c-n><c-w><c-l> {})
    (vim.keymap.set :n :<leader>e diagnostic.open_float {:silent true})
    (vim.keymap.set :n :<leader>q diagnostic.setloclist {:silent true})
    (vim.keymap.set :n "[d" diagnostic.goto_prev {:silent true})
    (vim.keymap.set :n "]d" diagnostic.goto_next {:silent true})
    (vim.keymap.set :n :<leader>ff telescope.find_files {})
    (vim.keymap.set :n :<leader>fg telescope.live_grep {})
    (vim.keymap.set :n :<leader>fb telescope.buffers {})
    (vim.keymap.set :n :<leader>fh telescope.help_tags {})
    (vim.keymap.set :n :<leader>tt #(: terminal :toggle) {:silent true})
    (vim.keymap.set :n :<leader>t1 #(: terminal :open 1) {:silent true})
    (vim.keymap.set :n :<leader>t2 #(: terminal :open 2) {:silent true})
    (vim.keymap.set :n :<leader>t3 #(: terminal :open 3) {:silent true})
    (vim.keymap.set :n :<leader>t4 #(: terminal :open 4) {:silent true})
    (vim.keymap.set :n :<leader>t5 #(: terminal :open 5) {:silent true})))

(fn on_attach [client buffer]
  (let [opts {:noremap true :silent true : buffer}
        {: declaration
         : definition
         : implementation
         : references
         : hover
         : signature_help
         : add_workspace_folder
         : remove_workspace_folder
         : list_workspace_folders
         : type_definition
         : rename
         : code_action
         : format} vim.lsp.buf]
    (vim.keymap.set :n :gD declaration opts)
    (vim.keymap.set :n :gd definition opts)
    (vim.keymap.set :n :gi implementation opts)
    (vim.keymap.set :n :gr references opts)
    (vim.keymap.set :n :K hover opts)
    (vim.keymap.set :n :<c-k> signature_help opts)
    (vim.keymap.set :n :<leader>wa add_workspace_folder opts)
    (vim.keymap.set :n :<leader>wr remove_workspace_folder opts)
    (vim.keymap.set :n :<leader>wl
                    #(print (vim.inspect (list_workspace_folders))))
    (vim.keymap.set :n :<leader>D type_definition opts)
    (vim.keymap.set :n :<leader>rn rename opts)
    (vim.keymap.set :n :<leader>ca code_action opts)
    (vim.keymap.set :n :<leader>f format opts)))

(fn completion []
  (let [luasnip (require :luasnip)
        cmp (require :cmp)]
    {:<c-b> (cmp.mapping.scroll_docs -4)
     :<c-f> (cmp.mapping.scroll_docs 4)
     :<c-space> (cmp.mapping.complete)
     :<cr> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Replace
                                 :select true})
     :<tab> (cmp.mapping (lambda [fallback]
                           (if (cmp.visible) (cmp.select_next_item)
                               (luasnip.expand_or_jumpable) (luasnip.expand_or_jump)
                               (fallback))) [:i :s])
     :<s-tab> (cmp.mapping (lambda [fallback]
                             (if (cmp.visible) (cmp.select_prev_item)
                                 (luasnip.jumpable -1) (luasnip.jump -1)
                                 (fallback)))
                           [:i :s])}))

{: setup : on_attach : completion}
