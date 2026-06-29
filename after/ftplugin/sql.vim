" g:sql_type_default is a global and lives in lua/config/options.lua (set once
" at startup), not here -- an ftplugin re-setting it on every SQL buffer leaked
" beyond buffer scope.
setlocal commentstring=--\ %s
