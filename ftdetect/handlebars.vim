if has("autocmd")
  au BufNewFile,BufRead *.{handlebars,hb,hbs,hbt,t}{,.erb} set ft=html syntax=handlebars | runtime! ftplugin/handlebars.vim ftplugin/handlebars*.vim ftplugin/handlebars/*.vim
endif
