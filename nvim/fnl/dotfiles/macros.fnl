{
  :_:
  (fn [name ...]
    `((. nvim.ex ,(tostring name)) ,...))

  :autocmd
  (fn [...]
    `(nvim.ex.autocmd ,...))

  :noremap
  (fn [mode from to]
    `(nvim.set_keymap ,mode ,from ,to {:noremap true}))

  :nmap
  (fn [from to]
    `(noremap :n ,from ,to))

  :noremap-buffer
  (fn [buffer mode from to]
    `(nvim.buf_set_keymap ,buffer ,mode ,from ,to {:noremap true}))

  :defer
  (fn
    [timeout func]
    `(vim.defer_fn ,func ,timeout))

  :fn->viml
  (fn [mod from to]
    `(nvim-util.fn-bridge ,to ,mod ,from {:return true}))
}
