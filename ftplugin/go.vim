" (aagg) Wed Oct 16 16:38:34 BST 2019
"TODO TEST: this seems to work for golang -kinda breaks for anything that's not a func (ex: structs, imports, consts)
let g:limelight_bop='\(\_^func .*(\(\n\?.*\(,\|)\)\)*.*{\|\_^type .* struct {\|\_^import (\|\_^const (\)' " function, type, import or const.
" ^func .*(\(\n\?.*\(,\|)\)\)*.*{
let g:limelight_eop='\(\_^}\|\_^)\)$' " } or )
