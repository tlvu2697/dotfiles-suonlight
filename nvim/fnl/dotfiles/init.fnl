(module dotfiles.init
  {autoload {nvim aniseed.nvim
             nvim-util aniseed.nvim.util
             util dotfiles.util
             telescope telescope
             actions telescope.actions
             orgmode orgmode
             compe compe
             which-key which-key
             autopairs nvim-autopairs
             lsp lspconfig}
   require-macros [dotfiles.macros]})

;; Plugins to be managed by packer.
(util.use
  :Olical/aniseed {}
  :Olical/nvim-local-fennel {}
  :Olical/conjure {}

  ; defaults
  :editorconfig/editorconfig-vim {}
  :folke/which-key.nvim {}
  :nvim-lua/popup.nvim {}
  :nvim-lua/plenary.nvim {}
  :nvim-telescope/telescope.nvim {}
  :mhinz/vim-startify {}
  :windwp/nvim-autopairs {}
  :yggdroot/indentLine {}
  :danro/rename.vim {}
  :phaazon/hop.nvim {} ; easy motion
  :tpope/vim-commentary {}
  :tpope/vim-endwise {}

  ; tmux
  :christoomey/vim-tmux-navigator {}
  :benmills/vimux {}

  ; text objects
  :kana/vim-textobj-user {}
  :kana/vim-textobj-indent  {}
  :kana/vim-textobj-line  {}
  :kana/vim-textobj-entire  {}
  :tpope/vim-surround {}

  ; git
  :tpope/vim-fugitive {}
  :tpope/vim-rhubarb {}

  ; ui
  :romgrk/doom-one.vim {}
  :kyazdani42/nvim-web-devicons {}
  :itchyny/lightline.vim {}
  ; :glepnir/galaxyline.nvim {:branch :main}

  ; lisp
  :guns/vim-sexp {}

  ; linter
  :dense-analysis/ale {}

  ; javascript
  :prettier/vim-prettier {}
  :pangloss/vim-javascript {}
  :maxmellon/vim-jsx-pretty {}
  :alvan/vim-closetag {}

  ; ruby
  :tpope/vim-projectionist {}
  :janko-m/vim-test {}

  ; lsp
  :neovim/nvim-lspconfig {}

  ; notes
  :kristijanhusak/orgmode.nvim {}

  ; completion
  :hrsh7th/nvim-compe {}

  ; config
  :dstein64/vim-startuptime {}

  ;; TODO research each plugin
  ; :tpope/vim-abolish {}
  ; :tpope/vim-dadbod {}
  ; :tpope/vim-dispatch {}
  ; :tpope/vim-eunuch {}
  ; :tpope/vim-repeat {}
  ; :tpope/vim-sexp-mappings-for-regular-people {}
  ; :tpope/vim-sleuth {}
  ; :tpope/vim-unimpaired {}
  ; :tpope/vim-vinegar {}
  ; :Olical/vim-enmasse {}
  ; :PeterRincker/vim-argumentative {}
  ; :airblade/vim-gitgutter {}
  ; :clojure-vim/vim-jack-in {}
  ; :dag/vim-fish {}
  ; :hylang/vim-hy {}
  ; :lambdalisue/suda.vim {}
  ; :liuchengxu/vim-better-default {:mod :better-default}
  ; :mbbill/undotree {:mod :undotree}
  ; :norcalli/nvim-colorizer.lua {:mod :colorizer}
  ; :radenling/vim-dispatch-neovim {}
  ; :wlangstroth/vim-racket {}
  )

;; default
(_: colorscheme :doom-one)
(set nvim.o.termguicolors true)
(set nvim.o.clipboard :unnamed)
(set nvim.o.autoindent true)
(set nvim.o.smartindent true)
(set nvim.o.expandtab true)
(set nvim.o.softtabstop 2)
(set nvim.o.shiftwidth 2)
(set nvim.o.number false)
(set nvim.o.relativenumber false)
(set nvim.o.encoding :UTF-8)
(set nvim.o.hlsearch false) ; disable search result highlighting
(set nvim.o.ignorecase true)
(set nvim.o.smartcase true)
(set nvim.o.wrap false) ; nowrap

;; ale
(set nvim.g.ale_linters
  {:javascript [:eslint]
   :ruby [:rubocop]
   :clojure [:clj-kondo :joker]})

(set nvim.g.ale_fixers
  {:javascript ["prettier" "eslint"]
   :ruby [:rubocop]})

(set nvim.g.ale_linters_explicit 1)
(set nvim.g.ale_completion_enabled 1)
(set nvim.g.ale_lint_on_save 1)
(set nvim.g.ale_lint_on_text_changed "never")
(set nvim.g.ale_echo_cursor 1)
(set nvim.g.ale_echo_msg_error_str "E")
(set nvim.g.ale_echo_msg_warning_str "W")
(set nvim.g.ale_echo_msg_format "[%linter%] %s [%severity%]")
(set nvim.g.ale_set_highlights 0)
(set nvim.g.ale_set_loclist 0)
(set nvim.g.ale_set_quickfix 1)
(set nvim.g.ale_fix_on_save 1)

;; indentLine
(set nvim.g.indentLine_enabled 0)
(set nvim.g.indentLine_concealcursor "inc")
(set nvim.g.indentLine_conceallevel 2)

;; telescope
(telescope.setup {:defaults {:mappings {:i {"<esc>" actions.close}}}})

;; sexp
(set nvim.g.sexp_filetypes "clojure,scheme,lisp,fennel")

;; orgmode
(orgmode.setup {})

;; textobj-entire
; (nvim.command "call textobj#user#plugin('entire', {
; \      '-': {
; \        'select-a': 'ag',  'select-a-function': 'textobj#entire#select_a',
; \        'select-i': 'ig',  'select-i-function': 'textobj#entire#select_i'
; \      }
; \    })
; ")

;; prettier
(vim.schedule
  (fn []
    (autocmd
      :BufWritePre
      "*.js,*.jsx,*.mjs,*.ts,*.tsx,*.less,*.json,*.graphql,*.md,*.vue"
      "Prettier")))

;; lightline
(fn->viml :dotfiles.util :filename :LightlineFilename)
(fn->viml :dotfiles.util :readonly :LightlineReadonly)

(set nvim.g.lightline
     {:colorscheme :default
      :component_function {:filename :LightlineFilename
                           :readonly :LightlineReadonly}
      :active {:left [[:mode :paste]
                      [:readonly :filename :modified]]
               :right [[:lineinfo]
                       [:percent]]}
      :inactive {:left [[:filename]]
                 :right []}})

;; closetag
(set nvim.g.closetag_filenames "*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js")
(set nvim.g.closetag_xhtml_filenames "*.xhtml,*.jsx,*.erb,*.js")
(set nvim.g.closetag_emptyTags_caseSensitive 1)
(set nvim.g.closetag_close_shortcut "<leader>>") ; Add > at current position without closing the current tag, default is ''

;; Startify
(set nvim.g.startify_change_to_vcs_root 1)

;; tmux
(set nvim.g.tmux_navigator_no_mappings 1)
(set nvim.g.tmux_navigator_save_on_switch 1)

;; vim-test
(set nvim.g.test#strategy "vimux")
(set nvim.g.test#preserve_screen 1)

(set nvim.test#enabled_runners ["ruby#rspec"])
(set nvim.test#ruby#minitest#file_pattern "_spec.rb")

;; lsp javascript
(local file-types {:typescript "eslint" :javascript "eslint"})

(local linters {:eslint {:sourceName :eslint
                         :command :eslint_d
                         :rootPatterns [".eslintrc.js" "package.json"]
                         :debounce 100
                         :args ["--stdin" "--stdin-filename" "%filepath" "--format" "json"]
                         :parseJson {:errorsRoot "[0].messages"
                                     :line :line
                                     :column :column
                                     :endLine :endLine
                                     :endColumn :endColumn
                                     :message "${message} [${ruleId}]"
                                     :security "severity"}
                         :securities {[2] "error"
                                      [1] "warning"}}})

(local formatters {:prettier {:command :prettier :args ["--stdin-filepath" "%filepath"]}})

(local format-file-types {:typescript "prettier" :javascript "prettier"})

(defn on-attach [client bufnr]
  (_: "command! LspDef lua vim.lsp.buf.definition()")
  (_: "command! LspHover lua vim.lsp.buf.hover()")
  (noremap-buffer bufnr :n :gd "<cmd>LspDef<CR>")
  (noremap-buffer bufnr :n :K "<cmd>LspHover<CR>"))

; (nvim.command "lua require('lspconfig').tsserver.setup{}")

; (lsp.diagnosticls.setup {:on_attach (fn [client bufnr]
;                                       ; (local client.resolved_capabilities.document_formatting false)
;                                       (on-attach client bufnr))
;                          :filetypes [:typescript :javascript]
;                          :init_options {:filetypes file-types
;                                         :linters linters
;                                         :formatters formatters
;                                         :formatFiletypes format-file-types}})

(lsp.tsserver.setup {:on_attach (fn [client bufnr]
                                  (set client.resolved_capabilities.document_formatting false)
                                  (on-attach client bufnr))})

;; nvim-compe
(set nvim.o.completeopt "menuone,noselect")

(compe.setup
  {:enabled true
   :autocomplete true
   :debug false
   :min_length 1
   :preselect "enable"
   :throttle_time 80
   :source_timeout 200
   :incomplete_delay 400
   :max_abbr_width 100
   :max_kind_width 100
   :max_menu_width 100
   :documentation true
   :source {:path true
            :buffer true
            :calc true
            :nvim_lsp true
            :nvim_lua true
            :conjure true
            :vsnip true}})

(autopairs.setup {})
(let [autopairs-compe (require :nvim-autopairs.completion.compe)]
  (autopairs-compe.setup {:map_cr true :map_complete true }))

;; bindings
(which-key.register
  {:/ ["<cmd>Telescope live_grep<CR>" "Search project"]
   :* ["<cmd>Telescope grep_string<CR>" "Search at point"]
   :<tab> ["<C-^>" "Switch to last buffer"]
   :q {:name "+quit/session"
       :q ["<cmd>q<CR>" "Quit vim"]}
   :p {:name "+projects"
       :f ["<cmd>Telescope find_files<CR>" "Find file"]
       :a ["<cmd>A<CR>" "Toggle implementation and test"]}
   :f {:name "+files"
       :s ["<cmd>update<CR>" "File save"]
       :f ["<cmd>Telescope file_browser<CR>" "Find file in directory"]
       :R [":Rename " "Rename file"]
       :c [":saveas <C-R>=expand(\"%:p:h\")<CR>/" "Copy file"]
       :r ["<cmd>Telescope oldfiles<CR>" "Recent files"]}
   :g {:name "+git"
       :oo ["<cmd>Gbrowse<CR>" "Git browse"]
       :s ["<cmd>Git<CR>" "Git status"]
       :b ["<cmd>Git blame<CR>" "Git blame"]}
   :b {:name "+buffers"
       :b ["<cmd>Telescope buffers<CR>" "Find buffer"]
       :d ["<cmd>bdelete<CR>" "Delete buffer"]
       :n ["<cmd>bdelete<CR>" "Next buffer"]
       :p ["<cmd>bdelete<CR>" "Previous buffer"]
       :h ["<cmd>Startify<CR>" "Home buffer"]}
   :w {:name "+windows"
       :h ["<cmd>wincmd h<CR>" "Window left"]
       :l ["<cmd>wincmd l<CR>" "Window right"]
       :j ["<cmd>wincmd j<CR>" "Window down"]
       :k ["<cmd>wincmd k<CR>" "Window up"]
       :<S-h> ["<cmd>wincmd <S-h><CR>" "Move window far left"]
       :<S-l> ["<cmd>wincmd <S-l><CR>" "Move window far right"]
       :<S-j> ["<cmd>wincmd <S-j><CR>" "Move window very down"]
       :<S-k> ["<cmd>wincmd <S-k><CR>" "Move window very top"]
       :w ["<cmd>wincmd w<CR>" "Other window"]
       := ["<cmd>wincmd =<CR>" "Window balance area"]
       :r ["<cmd>wincmd r<CR>" "Rotate window"]
       :s ["<cmd>wincmd s<CR>" "Window split"]
       :v ["<cmd>wincmd v<CR>" "Window vsplit"]
       :c ["<cmd>close<CR>" "Window close"]}
   :s {:name "+search"
       :p ["<cmd>Telescope find_files<CR>" "Search in project"]
       :s ["<cmd>Telescope current_buffer_fuzzy_find<CR>" "Search in buffer"]}
   :j {:name "+jump"
       :j ["<cmd>HopChar1<CR>" "Jump to char"]
       :w ["<cmd>HopWord<CR>" "Jump to word"]
       :l ["<cmd>HopLine<CR>" "Jump to line"]}
   :r {:name "+registers"
       :e ["<cmd>Telescope registers<CR>" "Registers"]}
   :t {:name "+toggle"
       :l ["<cmd>set nu! rnu!<CR>" "Toggle Line Number"]
       :i ["<cmd>IndentLinesToggle<CR>" "Toggle indent line"]}
   :h {:name "+help"
       :? ["<cmd>Telescope help_tags<CR>" "Help tags"]
       :e ["<cmd>messages<CR>" "View messages"]
       :df ["<cmd>Telescope commands<CR>" "Help Commands"]
       :t ["<cmd>Telescope colorscheme<CR>" "Load theme"]}}
  {:prefix "<leader>"})

;; Generic mapping configuration.
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

(noremap :n :<space> :<nop>)
(noremap :n :<M-s> "<cmd>update<CR>")
(noremap :n :<M-b> "<cmd>Telescope buffers<CR>")
(noremap :n :<M-w> "<cmd>close<CR>")
(noremap :n :<C-p> "<cmd>Telescope find_files<CR>")
(noremap :n :<C-h> "<cmd>TmuxNavigateLeft<CR>")
(noremap :n :<C-j> "<cmd>TmuxNavigateDown<CR>")
(noremap :n :<C-k> "<cmd>TmuxNavigateUp<CR>")
(noremap :n :<C-l> "<cmd>TmuxNavigateRight<CR>")

(noremap :n :<Space>! "yy:let cliptext = getreg('*') | :VimuxPromptCommand(cliptext)<CR><CR>")
(noremap :v :<Space>! "y:let cliptext = getreg('*') | :VimuxPromptCommand(cliptext)<CR><CR>")

(noremap :n :<f5> ":TestNearest<CR>:TmuxNavigateDown<CR>")

(nmap :s "<cmd>HopChar1<CR>")
(nmap :gy "yygccp")

(augroup
  :FileFugitive
  (autocmd :FileType :fugitive "nmap <buffer> q gq")
  (autocmd :FileType :fugitive "nmap <buffer> pp :Git push<CR>")
  (autocmd :FileType :fugitiveblame "nmap <buffer> q gq")
  (autocmd :FileType :gitcommit "nmap <buffer> <C-c><C-c> :wq<CR>")
  (autocmd :FileType :gitcommit "nmap <buffer> <C-c><C-k> :q!<CR>"))

(augroup
  :FileRuby
  (autocmd :FileType :ruby "noremap <f5> :TestNearest<CR>:TmuxNavigateDown<CR>")
  (autocmd :FileType :ruby "nnoremap <LocalLeader>tt :TestNearest<CR>:TmuxNavigateDown<CR>")
  (autocmd :FileType :ruby "nnoremap <LocalLeader>tb :TestFile<CR>:TmuxNavigateDown<CR>"))

(inoremap "<silent><expr> <C-Space> compe#complete()")
(inoremap "<silent><expr> <C-e> compe#close('<C-e>')")
(inoremap "<silent><expr> <C-f> compe#scroll({ 'delta': +4 })")
(inoremap "<silent><expr> <C-d> compe#scroll({ 'delta': -4 })")
