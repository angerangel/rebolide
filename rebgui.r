REBOL[version: 117]
if system/version < 1.3.2[make error! "RebGUI requires View 1.3.2 or greater"]
unless value? 'viewed?[
find-window: make function![
"Find a face's window face." 
face[object!]
][
while[face/parent-face][face: face/parent-face]
face
]
viewed?: make function![
"Returns TRUE if face is displayed." 
face[object!]
][
found? find system/view/screen-face/pane find-window face
]
]
system/locale: make system/locale[
colors:[black navy blue violet forest maroon coffee purple reblue coal oldrab red brick crimson leaf brown aqua teal magenta sienna water olive papaya mint gray rebolor green orange pewter base-color khaki cyan tan silver pink sky gold wheat yellow yello beige snow linen ivory white]
words:[]
language: "English" 
dictionary: none 
dict: none
]
ctx-rebgui: make object![
build: 117 
view*: system/view 
locale*: system/locale 
find-face: make function![pnt[pair!]f[object! block!]/local p result][
all[
object? :f 
f/show? 
within? pnt win-offset? f f/size 
return f
]
p: either object? :f[get in f 'pane][:f]
either block? :p[
result: none 
foreach face head reverse copy p[
if all[object? :face face/show? face: find-face pnt face][
result: face 
break
]
]
result
][
all[object? :p find-face pnt :p]
]
]
subface: make system/standard/face[
color: edge: font: para: feel: none
]
all-chars: make string! 256 
repeat i 256[insert tail all-chars to char! i - 1]
font?: make function![
font-name[string!]
][
all[font-name = font-sans-serif return true]
(size-text make subface[text: all-chars font: make view*/screen-face/font[name: font-sans-serif]]) <> 
(size-text make subface[text: all-chars font: make view*/screen-face/font[name: font-name]])
]
gui-error: make function![
error[string!]
/continue
][
write/append/lines %rebgui.log reform[now/date now/time error]
unless continue[make error! error]
]
span-resize: make function![face[object!]delta[pair!]][
if face/span[
face/old-size: face/size 
all[find face/span #X face/offset/x: face/offset/x + delta/x]
all[find face/span #Y face/offset/y: face/offset/y + delta/y]
all[find face/span #W face/size/x: face/size/x + delta/x]
all[find face/span #H face/size/y: face/size/y + delta/y]
all[face/old-size <> face/size object? get in face 'action face/action/on-resize face]
]
any[
if block? get in face 'pane[foreach f face/pane[span-resize f delta]]
if object? get in face 'pane[span-resize face/pane delta]
]
]
span-size: make function![face[object!]size[pair!]margin[pair!]][
if face/span[
all[
find face/span #L 
face/size/x: size/x - face/offset/x - margin/x 
all[find[drop-list edit-list]face/type face/pane/offset/x: face/size/x - sizes/line + 1]
]
all[find face/span #V face/size/y: size/y - face/offset/y - margin/y]
all[face/old-size <> face/size object? get in face 'action face/action/on-resize face]
if find face/span #O[
face/offset/x: either any[zero? face/offset/y size/y = (face/offset/y + face/size/y)][
size/x - face/size/x
][
size/x - face/size/x - margin/x
]
]
]
if block? get in face 'pane[
either face/type = 'tab-panel[
foreach f face/pane[span-size f face/size 0x0]
][
foreach f face/pane[span-size f face/size face/pane/1/offset]
]
]
if object? get in face 'pane[span-size face/pane face/size face/pane/offset]
]
unview-keep: make function![num[integer!]/local pane][
pane: head view*/screen-face/pane 
while[(length? pane) > num][remove back tail pane]
show view*/screen-face
]
words:[after at bold button-size data do edge effect feel field-size font indent italic label-size margin on on-alt-click on-away on-click on-dbl-click on-edit on-focus on-key on-over on-resize on-scroll on-unfocus options pad para rate return reverse space text-color text-size tight tip underline]
select-face: make function![face][
face/color: colors/state-light 
face/font/color: colors/page 
show face
]
deselect-face: make function![face /fill][
face/color: either fill[colors/page][none]
face/font/color: colors/text 
show face
]
colors: construct/with either exists? %ui.dat[pick load %ui.dat 3][[]]make object![
page: ivory 
text: coal 
theme-light: 195.221.127 
theme-dark: 136.187.0 
state-light: 255.204.127 
state-dark: 255.153.0 
outline-light: 204.204.204 
outline-dark: 136.136.136
]
sizes: construct/with either exists? %ui.dat[pick load %ui.dat 6][[]]make object![
cell: 4 
edge: 1 
font: 12 
font-height: none 
gap: 2 
line: cell * 5 
margin: 4 
slider: cell * 4
]
behaviors: construct/with either exists? %ui.dat[pick load %ui.dat 9][[]]make object![
action-on-enter:[drop-list edit-list field password spinner]
action-on-tab:[field]
caret-on-focus:[area]
cyclic:[group-box panel sheet tab-panel]
hilight-on-focus:[edit-list field password spinner]
tabbed:[area button drop-list drop-tree edit-list field grid password spinner]
]
effects: construct/with either exists? %ui.dat[pick load %ui.dat 12][[]]make object![
arrows-together: false 
radius: 5 
font: either font? "arial"["verdana"][font-sans-serif]
fonts: sort reduce[font-sans-serif font-fixed font-serif "verdana"]
splash-delay: 1 
tooltip-delay: 0:00:01 
webdings: font? "webdings" 
window: none
]
on-fkey: make object![
f1: f2: f3: f4: f5: f6: f7: f8: f9: f10: f11: f12: none
]
edit: make object![
siblings: none 
caret: none 
letter: make bitset![#"A" - #"Z" #"a" - #"z" #"'"]
capital: make bitset![#"A" - #"Z"]
other: negate letter 
edits: make function![
words[block!]
/local result ln w
][
result: copy[]
foreach word words[
repeat n ln: length? word[
insert tail result head remove at copy word n
]
repeat n ln - 1[
insert tail result head change change at copy word n pick word n + 1 pick word n
]
foreach ch "abcdefghijklmnopqrstuvwxyz"[
repeat n ln[
poke w: copy word n ch 
insert tail result w
]
repeat n ln + 1[
insert tail result head insert at copy word n ch
]
]
]
result
]
lookup-word: make function![
word[string!]
/local result
][
any[
not empty? result: intersect locale*/dict make hash! word: reduce[word]
not empty? result: intersect locale*/dict make hash! edits word 
result: word
]
sort result
]
insert?: true 
keymap:[
#"^H" back-char 
#"^~" del-char 
#"^M" enter 
#"^A" all-text 
#"^C" copy-text 
#"^X" cut-text 
#"^V" paste-text 
#"^T" clear-tail 
#"^Z" undo 
#"^Y" redo 
#"^[" undo-all 
#"^S" spellcheck 
#"^/" ctrl-enter
]
hilight-text: make function![start end][
view*/highlight-start: start 
view*/highlight-end: end
]
hilight-all: make function![face][
either empty? face/text[unlight-text][
view*/highlight-start: head face/text 
view*/highlight-end: tail face/text
]
]
unlight-text: make function![][
view*/highlight-start: view*/highlight-end: none
]
hilight?: make function![][
all[
object? view*/focal-face 
string? view*/highlight-start 
string? view*/highlight-end 
not zero? offset? view*/highlight-end view*/highlight-start
]
]
hilight-range?: make function![/local start end][
start: view*/highlight-start 
end: view*/highlight-end 
if negative? offset? start end[start: end end: view*/highlight-start]
reduce[start end]
]
tabbed?: make function![
face[object!]
][
all[
face/show? 
find behaviors/tabbed face/type 
not find face/options 'info 
face
]
]
cyclic?: make function![
face[object!]
][
all[find behaviors/cyclic face/type face]
]
unfocus: make function![/local face][
if face: view*/focal-face[
if all[face/type <> 'face get in face/action 'on-unfocus][
unless face/action/on-unfocus face[return false]
]
all[
view*/caret 
in face 'caret 
face/caret: index? view*/caret
]
all[
face/type = 'button 
face/feel/over face false none
]
]
view*/focal-face: view*/caret: none 
unlight-text 
all[face show face]
true
]
copy-selected-text: make function![/local start end][
if hilight?[
set[start end]hilight-range? 
write clipboard:// copy/part start end 
true
]
]
delete-selected-text: make function![/local start end][
if hilight?[
set[start end]hilight-range? 
remove/part start end 
view*/caret: start 
view*/focal-face/line-list: none 
unlight-text 
true
]
]
cut-text: make function![][
undo-add face 
copy-selected-text face 
delete-selected-text
]
paste-text: make function![][
undo-add face 
delete-selected-text 
face/line-list: none 
view*/caret: insert view*/caret read clipboard://
]
undo-max: 20 
undo-add: make function![face][
if in face 'undo[
insert clear face/undo at copy face/text index? view*/caret 
if all[undo-max undo-max < length? head face/undo][remove head face/undo]
face/undo: tail face/undo
]
]
undo-get: make function![face][
face/text: head view*/caret: first face/undo 
face/line-list: none 
remove face/undo
]
word-limits: make bitset! { 
^-^M/[](){}"} 
word-limits: reduce[word-limits complement word-limits]
current-word: make function![str /local s ns][
unless string? str[gui-error/continue reform["Current word trap" type? str str]exit]
set[s]word-limits 
s: any[all[s: find/reverse str s next s]head str]
set[ns]word-limits 
ns: any[find str ns tail str]
hilight-text s ns 
show view*/focal-face
]
next-word: make function![str /local s ns][
set[s ns]word-limits 
any[all[s: find str s find s ns]tail str]
]
back-word: make function![str /local s ns][
set[s ns]word-limits 
any[all[ns: find/reverse str ns ns: find/reverse ns s next ns]head str]
]
end-of-line: make function![str][
any[find str "^/" tail str]
]
beg-of-line: make function![str /local nstr][
either nstr: find/reverse str "^/"[next nstr][head str]
]
next-field: make function![face /wrap][
unless face/parent-face[return none]
unless find[object! block!]type?/word get in face/parent-face 'pane[
return none
]
siblings: compose[(face/parent-face/pane)]
unless wrap[siblings: find/tail siblings face]
foreach sibling siblings[
if target: any[
tabbed? sibling 
into-widget/forwards sibling
][
return target
]
]
all[
not cyclic? face/parent-face 
target: next-field face/parent-face 
return target
]
all[
target: next-field/wrap face 
return target
]
]
back-field: make function![face /wrap][
unless face/parent-face[return none]
unless find[object! block!]type?/word get in face/parent-face 'pane[
return none
]
siblings: reverse compose[(face/parent-face/pane)]
unless wrap[siblings: find/tail siblings face]
foreach sibling siblings[
if target: any[
tabbed? sibling 
into-widget/backwards sibling
][
return target
]
]
all[
not cyclic? face/parent-face 
target: back-field face/parent-face 
return target
]
all[
target: back-field/wrap face 
return target
]
]
into-widget: make function![
{Recursivly returns the first tabbable face in parent's face pane tree.} 
face[object!]
/forwards 
/backwards 
/local 
target children
][
unless find[object! block!]type?/word get in face 'pane[
return none
]
unless face/show?[
return none
]
children: compose[(face/pane)]
catch[
foreach child either backwards[reverse children][children][
if target: any[
tabbed? child 
either backwards[
into-widget/backwards child
][
into-widget child
]
][
throw target
]
]
]
]
keys-to-insert: make bitset! #{
01000000FFFFFFFFFFFFFFFFFFFFFF7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
} 
insert-char: make function![face char][
delete-selected-text 
unless any[insert? tail? view*/caret "^/" = first view*/caret][remove view*/caret]
insert view*/caret char 
view*/caret: next view*/caret
]
move: make function![event ctrl plain][
either event/shift[
any[view*/highlight-start view*/highlight-start: view*/caret]
][unlight-text]
view*/caret: either event/control ctrl plain 
if event/shift[
either view*/caret = view*/highlight-start[unlight-text][view*/highlight-end: view*/caret]
]
]
move-y: make function![face delta /local pos tmp tmp2][
tmp: offset-to-caret face 0x2 + delta + pos: caret-to-offset face view*/caret 
tmp2: caret-to-offset face tmp 
either tmp2/y <> pos/y[tmp][view*/caret]
]
edit-text: make function![
face event 
/local key edge para caret scroll page-up page-down face-size
][
face-size: face/size - either face/edge[2 * face/edge/size][0]
key: event/key 
if char? key[
either find keys-to-insert key[
undo-add face 
insert-char face key
][key: select keymap key]
]
if word? key[
page-up:[move-y face face-size - sizes/font-height - sizes/font-height * 0x-1]
page-down:[move-y face face-size - sizes/font-height * 0x1]
do select[
left[move event[back-word view*/caret][back view*/caret]]
right[move event[next-word view*/caret][next view*/caret]]
up[move event page-up[move-y face sizes/font-height * 0x-1]]
down[move event page-down[move-y face sizes/font-height * 0x1]]
page-up[move event[head view*/caret]page-up]
page-down[move event[tail view*/caret]page-down]
home[move event[head view*/caret][beg-of-line view*/caret]]
end[move event[tail view*/caret][end-of-line view*/caret]]
insert[either event/shift[paste-text][insert?: complement insert?]]
back-char[
undo-add face 
any[
delete-selected-text 
head? view*/caret 
either event/control[
tmp: view*/caret 
remove/part view*/caret: back-word tmp tmp
][remove view*/caret: back view*/caret]
]
]
del-char[
undo-add face 
either event/shift[unless face/type = 'password[cut-text]][
any[
delete-selected-text 
tail? view*/caret 
either event/control[
remove/part view*/caret back next-word view*/caret 
if tail? next view*/caret[remove back tail view*/caret]
][remove view*/caret]
]
]
]
enter[
either find behaviors/action-on-enter face/type[
all[face/type = 'spinner face/action/on-unfocus face]
set-focus face 
face/action/on-click face
][
undo-add face 
insert-char face "^/"
]
]
ctrl-enter[undo-add face insert-char face tab]
all-text[hilight-all face]
copy-text[unless face/type = 'password[copy-selected-text face unlight-text]]
cut-text[unless face/type = 'password[cut-text]]
paste-text[paste-text]
clear-tail[
undo-add face 
remove/part view*/caret end-of-line view*/caret
]
undo[
if all[in face 'undo not head? face/undo][
insert face/undo at copy face/text index? view*/caret 
face/undo: back face/undo 
undo-get face
]
]
redo[
if all[in face 'undo not tail? face/undo][
face/undo: insert face/undo at copy face/text index? view*/caret 
undo-get face
]
]
undo-all[
if in face 'esc[
clear face/text 
all[in face 'undo clear face/undo]
all[string? face/esc insert face/text face/esc]
view*/caret: tail face/text
]
]
spellcheck[
request-spellcheck face
]
]key
]
edge: face/edge 
para: face/para 
scroll: face/para/scroll 
if error? try[
caret: caret-to-offset face view*/caret 
if caret/y < (edge/size/y + para/origin/y + para/indent/y)[
scroll/y: round/to scroll/y - caret/y sizes/font-height
]
if caret/y > (face-size/y - sizes/font-height)[
scroll/y: round/to (scroll/y + ((face-size/y - sizes/font-height) - caret/y)) sizes/font-height
]
unless para/wrap?[
if caret/x < (edge/size/x + para/origin/x + para/indent/x)[
scroll/x: scroll/x - caret/x + (edge/size/x + para/origin/x + para/indent/x)
]
if caret/x > (face-size/x - para/margin/x)[
scroll/x: scroll/x + (face-size/x - para/margin/x - caret/x)
]
]
if scroll <> face/para/scroll[
face/para/scroll: scroll 
if face/type = 'area[face/key-scroll?: true]
]
][gui-error/continue reform["Caret trap" face/type face/para]]
show face
]
feel: make object![
redraw: detect: over: none 
engage: func[face act event /local txt][
do select[
key[
unless all[get in face/action 'on-key not face/action/on-key face event][
txt: copy face/text 
edit-text face event 
all[
get in face/action 'on-edit 
strict-not-equal? txt face/text 
face/action/on-edit face
]
]
]
down[
either event/double-click[
all[view*/caret not empty? view*/caret current-word view*/caret]
][
either face = view*/focal-face[
unlight-text 
view*/caret: offset-to-caret face event/offset 
show face
][
caret: offset-to-caret face event/offset 
set-focus face
]
]
]
over[
unless view*/caret = offset-to-caret face event/offset[
unless view*/highlight-start[view*/highlight-start: view*/caret]
view*/highlight-end: view*/caret: offset-to-caret face event/offset 
show face
]
]
alt-up[face/action/on-alt-click face]
scroll-line[face/action/on-scroll face event/offset]
scroll-page[face/action/on-scroll/page face event/offset]
]act
]
]
]
widgets: make object![
rebind: make function![][
default-edge/color: colors/text 
default-edge/size: as-pair sizes/edge sizes/edge 
theme-edge/color: colors/theme-dark 
theme-edge/size: default-edge/size 
outline-edge/color: colors/outline-light 
outline-edge/size: default-edge/size 
default-font/size: sizes/font 
default-font/name: effects/font 
default-font-bold: make default-font[style: 'bold]
default-font-heading: make default-font[style: 'bold color: colors/page align: 'center shadow: 1x1]
default-font-large: make default-font[size: sizes/font * 2]
default-font-right: make default-font[align: 'right]
default-font-top: make default-font[valign: 'top]
default-para-indented/origin/x: sizes/line 
default-text/text: copy "" 
sizes/font-height: second size-text default-text 
foreach w next find first self 'choose[
widgets/:w/rebind
]
]
default-edge: make object![
color: colors/text 
image: none 
effect: none 
size: as-pair sizes/edge sizes/edge
]
theme-edge: make default-edge[
color: colors/theme-dark
]
outline-edge: make default-edge[
color: colors/outline-light
]
default-font: make object![
name: effects/font 
style: none 
size: sizes/font 
color: colors/text 
offset: 0x0 
space: 0x0 
align: 'left 
valign: 'middle 
shadow: none
]
default-font-bold: make default-font[
style: 'bold
]
default-font-heading: make default-font[
style: 'bold 
color: colors/page 
align: 'center 
shadow: 1x1
]
default-font-large: make default-font[
size: sizes/font * 2
]
default-font-right: make default-font[
align: 'right
]
default-font-top: make default-font[
valign: 'top
]
default-para: make object![
origin: 2x2 
margin: 2x2 
indent: 0x0 
tabs: 0 
wrap?: false 
scroll: 0x0
]
default-para-wrap: make default-para[
origin: 2x0 
indent: 0x0 
wrap?: true
]
default-para-indented: make default-para[
origin: as-pair sizes/line 2
]
default-feel: make object![
redraw: 
detect: 
over: 
engage: none
]
default-action: make object![
on-alt-click: 
on-away: 
on-click: 
on-dbl-click: 
on-edit: 
on-focus: 
on-key: 
on-over: 
on-resize: 
on-scroll: 
on-unfocus: none
]
set 'rebface make subface[
feel: default-feel 
action: default-action 
options:[]
rebind: init: tip: none
]
default-text: make rebface[
size: 10000x10000 
text: "" 
font: default-font 
para: default-para
]
sizes/font-height: second size-text default-text 
date-spec:[
tight 
symbol 9x6 data 'rewind[face/parent-face/data/year: face/parent-face/data/year - 1 show face/parent-face]
symbol 9x6 data 'left[face/parent-face/data/month: face/parent-face/data/month - 1 show face/parent-face]
symbol 34x6[set-data face/parent-face first face/parent-face/options]
symbol 9x6 data 'right[face/parent-face/data/month: face/parent-face/data/month + 1 show face/parent-face]
symbol 9x6 data 'forward[face/parent-face/data/year: face/parent-face/data/year + 1 show face/parent-face]
return
]
foreach day locale*/days[
insert tail date-spec compose[label 10 (copy/part day 3) font[align: 'center]]
]
insert tail date-spec[return bar]
loop 6[
insert tail date-spec 'return 
loop 7[
insert tail date-spec[
box 10x6 font[align: 'center valign: 'middle]edge[size: 0x0 color: colors/state-dark]feel[
over: make function![face act pos][
either all[act face/text][
face/parent-face/data/day: to integer! face/text 
set-title face/parent-face form face/parent-face/data 
select-face face
][deselect-face face]
]
engage: make function![face act event][
all[
act = 'down 
face/text 
face/parent-face/data/day: to integer! face/text 
poke face/parent-face/options 1 face/parent-face/data 
face/parent-face/action/on-click face/parent-face
]
all[
find[up alt-up]act 
face/feel/over face false none
]
]
]
]
]
]
face-iterator: make rebface[
type: 'face-iterator 
pane:[]
data:[]
timeout: now/time/precise 
feel: make default-feel[
redraw: make function![face act pos][
if all[act = 'show face/size <> face/old-size][face/resize]
]
engage: make function![face act event /local i][
if act = 'time[
if (now/time/precise - face/timeout) > 0:00:00.2[
face/action face 
face/rate: none 
show face
]
]
if act = 'key[
do select[
#"^A"[
if find face/options 'multi[
clear face/picked 
repeat i face/rows[insert tail face/picked i]
face/action face
]
]
down[
i: 1 + last face/picked 
if i <= face/rows[
i: min face/rows i 
insert clear face/picked i 
if find[table text-list]face/parent-face/type[
face/timeout: now/time/precise 
face/rate: 60 
if i > (face/scroll + face/lines)[
face/pane/2/data: 1 / (face/rows - face/lines) * ((min (face/rows - face/lines + 1) (i - face/lines + 1)) - 1) 
face/scroll: face/scroll + 1
]
]
]
]
up[
i: -1 + last face/picked 
if i > 0[
i: max 1 i 
insert clear face/picked i 
if find[table text-list]face/parent-face/type[
face/timeout: now/time/precise 
face/rate: 60 
if i = face/scroll[
face/pane/2/data: 1 / (face/rows - face/lines) * ((min (face/rows - face/lines + 1) i) - 1) 
face/scroll: face/scroll - 1
]
]
]
]
#"^M"[
all[find[table text-list]face/parent-face/type face/action face]
]
]event/key 
show face
]
]
]
lines: none 
rows: none 
cols: 1 
widths: none 
aligns: none 
picked:[]
scroll: 0 
resize: make function![][
lines: to integer! size/y / sizes/line 
pane/2/show?: either rows > lines[
scroll: max 0 min scroll rows - lines 
true
][
scroll: 0 
false
]
]
redraw: make function![][
clear picked 
rows: either empty? data[0][(length? data) / cols]
resize 
pane/2/ratio: either zero? rows[1][lines / rows]
show self
]
selected: make function![/local blk][
if empty? picked[return none]
either any[find options 'multi parent-face/type = 'table][
all[rows = length? picked return data]
blk: copy[]
either cols = 1[
foreach row picked[insert tail blk pick data row]
][
foreach row picked[
repeat col cols[
insert tail blk pick data -1 + row * cols + col
]
]
]
blk
][
blk: pick data first picked
]
]
init: make function![/local p][
attempt[remove find span #X]
attempt[remove find span #Y]
lines: to integer! size/y / sizes/line 
rows: (length? data) / cols 
clear pane 
p: self 
insert pane make subface[
size: p/size 
span: p/span 
pane: make function![face index /local col-offset clr][
either integer? index[
if index <= min lines rows[
line/offset/y: index - 1 * sizes/line 
line/size/x: size/x 
index: index + scroll 
either p/parent-face/type = 'table[
col-offset: 0 
repeat i p/cols[
line/pane/:i/offset/x: col-offset 
line/pane/:i/size/x: p/widths/:i - sizes/cell 
all[
p/pane/2/show? 
i = p/cols 
line/pane/:i/size/x: line/pane/:i/size/x + (p/size/x - p/pane/2/size/x - (line/pane/:i/offset/x + line/pane/:i/size/x))
]
line/pane/:i/text: replace/all form pick p/data index - 1 * cols + i "^/" "¶" 
line/pane/:i/font/color: either find p/options 'no-action[
colors/text
][
either find picked index[colors/page][colors/text]
]
col-offset: col-offset + pick widths i
]
][
line/text: replace/all form pick face/parent-face/data index "^/" "¶" 
line/font/color: either find p/options 'no-action[
colors/text
][
either find picked index[colors/page][colors/text]
]
]
line/color: either find p/options 'no-action[none][if find picked index[colors/theme-light]]
if all[
line/color = colors/theme-light 
face/parent-face/type = 'choose
][face/parent-face/auto: pick face/parent-face/data index]
line/data: index 
line
]
][to integer! index/y / sizes/line + 1]
]
text: "" 
line: make rebface[
size: as-pair 0 sizes/line 
font: make default-font[]
feel: make default-feel[
over: make function![face into pos][
if find face/parent-face/parent-face/options 'over[
either into[insert clear picked data][clear picked]
show face
]
]
engage: make function![face act event /local p a b][
p: face/parent-face 
either event/double-click[
all[act = 'down p/parent-face/dbl-action p/parent-face]
][
if find[up alt-up]act[
view*/focal-face: p 
view*/caret: tail p/text 
either find p/parent-face/options 'multi[
unless any[event/control event/shift][clear picked]
either all[event/control find picked data][
remove find picked data
][
unless find picked data[insert tail picked data]
]
if all[event/shift 1 < length? picked][
clear next picked 
repeat i (max data first picked) - (a: min data first picked) + 1[
b: i + a - 1 
all[b <> first picked insert tail picked b]
]
]
][insert clear picked data]
show p 
unless find p/parent-face/options 'no-action[
either act = 'up[
p/parent-face/action p/parent-face
][
p/parent-face/alt-action p/parent-face
]
]
]
]
]
]
]
]
if find options 'table[
pane/1/line/pane: copy[]
repeat i cols[
insert tail pane/1/line/pane make subface[
size: as-pair 0 sizes/line 
font: make default-font[align: aligns/:i]
]
]
]
insert tail pane make slider[
tip: none 
offset: as-pair p/size/x - sizes/slider 0 
size: as-pair sizes/slider p/size/y 
span: case[
none? p/span[none]
all[find p/span #H find p/span #W][#XH]
find p/span #H[#H]
find p/span #W[#X]
]
options:[arrows]
show?: either rows > lines[true][false]
action: make default-action[
on-click: make function![face][
scroll: to integer! rows - lines * data 
show face/parent-face
]
]
ratio: either rows > 0[lines / rows][1]
]
pane/2/init
]
]
choose: make function![
parent[object!]"Widget to appear in relation to" 
width[integer!]"Width in pixels" 
xy[pair!]"Offset of choice box" 
items[block!]"Block of items to display" 
/local popup result
][
result: none 
popup: make face-iterator[
type: 'choose 
offset: xy 
size: as-pair width sizes/line * min length? items to-integer parent/parent-face/size/y - xy/y / sizes/line 
color: colors/page 
data: items 
edge: outline-edge 
feel: system/words/face/feel 
options:[over]
action: make function![face][result: pick data first picked hide-popup]
alt-action: none 
dbl-action: none 
auto: none
]
popup/init 
show-popup/window/away popup parent/parent-face 
do-events 
either parent/type = 'edit-list[popup/auto][result]
]
anim: make rebface[
tip:{USAGE:
anim data[%images/go-previous.png %images/go-next.png]
anim data[img1 img2 img3]rate 2
DESCRIPTION:
Cycles a set of images at a specified rate.}
size: -1x-1 
effect: 'fit 
feel: make default-feel[
engage: make function![face act event][
all[
act = 'time 
face/image: first face/data 
face/data: either tail? next face/data[head face/data][next face/data]
show face
]
]
]
rate: 1 
init: make function![][
repeat i length? data: reduce data[
all[file? pick data i poke data i load pick data i]
]
image: first data 
data: next data 
all[negative? size/x size/x: image/size/x]
all[negative? size/y size/y: image/size/y]
]
]
pill: make rebface[
tip:{USAGE:
pill red
DESCRIPTION:
A rectangular area with rounded corners.}
size: 10x10 
effect:[draw[pen none line-width sizes/edge fill-pen linear 0x0 0 0 90 1 1 none none none box 0x0 0x0 effects/radius]]
pen: none 
fill: make function![][effect/draw/fill-pen]
feel: make default-feel[
redraw: make function![face act pos][
if act = 'show[
all[
face/color 
poke face/effect/draw 13 face/color + 0.0.0.64 
poke face/effect/draw 14 face/color + 0.0.0.32 
poke face/effect/draw 15 face/color 
face/color: none
]
]
]
]
action: make default-action[
on-resize: make function![face][
poke face/effect/draw 8 to integer! face/size/y * 0.25 
poke face/effect/draw 9 to integer! face/size/y * 0.75 
poke face/effect/draw 18 face/size - 1x1 
poke face/effect/draw 19 either all[face/size/x > sizes/line face/size/y > sizes/line][effects/radius * 2][effects/radius]
]
]
init: make function![][
action/on-resize self
]
]
area: make rebface[
tip:{USAGE:
area
area "Text" -1
area "Text" 50x-1
DESCRIPTION:
Editable text area with wrapping and scroller.
OPTIONS:
'info specifies read-only}
size: 50x25 
text: "" 
color: colors/page 
edge: theme-edge 
font: default-font-top 
para: make default-para-wrap[margin: as-pair sizes/slider + 2 2]
feel: make edit/feel[
redraw: func[face act pos /local height total visible][
if act = 'show[
if face/size <> face/old-size[
face/pane/offset/x: max 0 face/size/x - face/pane/size/x 
face/pane/size/y: face/size/y
]
if any[
face/text-y <> height: second size-text face 
face/size <> face/old-size
][
face/text-y: height 
total: face/text-y 
visible: face/size/y - (edge/size/y * 2) - para/origin/y - para/indent/y 
face/pane/ratio: either total > 0[min 1 (visible / total)][1]
face/pane/step: either visible < total[min 1 (sizes/font-height / (total - visible))][0]
]
if all[face/pane/ratio < 1 face/key-scroll?][
do bind[
total: text-y 
visible: size/y - (edge/size/y * 2) - para/origin/y - para/indent/y 
pane/data: - para/scroll/y / (total - visible)
]face 
face/key-scroll?: false
]
]
]
]
esc: none 
caret: none 
undo: copy[]
text-y: none 
key-scroll?: false 
action: make default-action[
on-scroll: make function![face scroll /page /local total visible][
total: second size-text face 
visible: face/size/y - (face/edge/size/y * 2) - face/para/origin/y - face/para/indent/y 
face/para/scroll/y: either page[
min max face/para/scroll/y - (visible * sign? scroll/y) (visible - total) 0
][
min max face/para/scroll/y - (scroll/y * sizes/font-height) (visible - total) 0
]
all[face/pane/data: - face/para/scroll/y / (total - visible)]
show face
]
]
rebind: make function![][
color: colors/page 
para/margin/x: sizes/slider + 2
]
init: make function![/local p][
if find options 'info[
feel: make feel[engage: none]
all[color = colors/page color: colors/outline-light]
]
para: make para[]
p: self 
text-y: second size-text self 
all[negative? size/x size/x: 10000 size/x: 4 + first size-text self]
all[negative? size/y size/y: 10000 size/y: 8 + text-y]
pane: make slider[
tip: none 
offset: as-pair p/size/x - sizes/slider 0 
size: as-pair sizes/slider p/size/y 
span: case[
none? p/span[none]
all[find p/span #H find p/span #W][#XH]
find p/span #W[#X]
find p/span #H[#H]
true[none]
]
options:[arrows]
action: make default-action[
on-click: make function![face /local visible][
unless parent-face/key-scroll?[
visible: (parent-face/size/y - (parent-face/edge/size/y * 2) - parent-face/para/origin/y - parent-face/para/indent/y) 
parent-face/para/scroll/y: negate parent-face/text-y - visible * data 
if all[
view*/caret 
parent-face = view*/focal-face
][
]
show parent-face
]
parent-face/key-scroll?: false
]
]
ratio: p/size/y - 4 / text-y
]
pane/init
]
]
arrow: make rebface[
tip:{USAGE:
arrow
arrow 10
arrow data 'up
arrow data 'down
arrow data 'left
arrow data 'right
DESCRIPTION:
An arrow (default down) on a square button face with height set to width.}
size: 5x-1 
data: 'down 
feel: make default-feel[
redraw: make function![face act pos][
all[act = 'show face/color: either face/data[colors/state-light][colors/theme-light]]
]
engage: make function![face act event][
do select[
time[all[face/data face/action/on-click face]]
down[face/data: on]
up[face/data: off face/action/on-click face]
over[face/data: on]
away[face/data: off]
]act 
show face
]
]
effect: reduce['arrow colors/page 'rotate 0]
rebind: make function![][effect/arrow: colors/page]
init: make function![][
all[negative? size/y size/y: size/x]
effect/rotate: select[up 0 right 90 down 180 left 270]data 
data: off
]
]
bar: make rebface[
tip:{USAGE:
bar 100
DESCRIPTION:
A thin 3D bar used to separate widgets.
Defaults to maximum display width.}
size: -1x1 
color: colors/outline-light 
edge: make outline-edge[effect: 'bevel]
rebind: make function![][color: edge/color: colors/outline-light]
]
box: make rebface[
tip:{USAGE:
box red
DESCRIPTION:
The most basic of widgets, a rectangular area.}
size: 25x25
]
button: make pill[
tip:{USAGE:
button "Hello"
button -1 "Go!"
button "Click me!"[print "click"]
DESCRIPTION:
Performs action when clicked.
OPTIONS:
'info specifies read-only}
size: 15x5 
text: "" 
color: colors/theme-dark 
font: default-font-heading 
feel: make feel[
over: make function![face act pos][
set-color face either all[act not find face/options 'info][colors/theme-light][colors/theme-dark]
]
engage: make function![face act event /local f][
unless find face/options 'info[
do select[
down[set-color face colors/state-light]
alt-down[set-color face colors/state-light]
up[set-color face colors/theme-dark face/action/on-click face]
alt-up[set-color face colors/theme-dark face/action/on-alt-click face]
away[set-color face colors/theme-dark]
]act
]
]
]
rebind: make function![][
color: colors/theme-dark
]
init: make function![][
all[negative? size/x size/x: 10000 size/x: 8 + first size-text self]
all[find options 'info color = colors/theme-dark color: colors/outline-light]
action/on-resize self
]
]
calendar: make rebface[
tip:{USAGE:
calendar
calendar data 1-Jan-2000
DESCRIPTION:
Used to select a date, with face/data set to current selection.
Default selection is now/date.}
size: 70x48 
feel: make default-feel[
redraw: make function![face act pos /local date month][
if act = 'show[
date: face/data 
month: date/month 
date/day: 1 
date: date - date/weekday + 1 
foreach sub-face skip face/pane 13[
sub-face/edge/size: 0x0 
sub-face/text: either date/month = month[
all[date = first face/options sub-face/edge/size: 2x2]
form date/day
][none]
date: date + 1
]
face/pane/3/text: reform[pick locale*/months face/data/month face/data/year]
]
]
]
init: make function![][
insert options any[data now/date]
data: layout/only date-spec 
pane: data/pane 
size: data/size 
data: first options
]
]
chat: make rebface[
tip:{USAGE:
chat 120 data["Bob" blue "My comment." yello 14-Apr-2007/10:58]
DESCRIPTION:
Three column chat display as found in IM apps such as AltME.
Messages are appended, with those exceeding 'limit not shown.
OPTIONS:
[limit n]where n specifies number of messages to show (default 100)
[id n]where n specifies id column width (default 10)
[user n]where n specifies user column width (default 15)
[date n]where n specifies date column width (default 25)}
size: 200x100 
pane:[]
data:[]
edge: outline-edge 
action: make default-action[
on-resize: make function![face][
poke face/pane/2/para/tabs 3 face/pane/1/size/x - (sizes/cell * any[select face/options 'date 25]) 
face/redraw/no-show
]
]
height: 0 
rows: 0 
limit: none 
append-message: make function![
user[string!]
user-color[tuple! word! none!]
msg[string!]
msg-color[tuple! word! none!]
date[date!]
/no-show row 
/local p y t1 t2 t3
][
t1: pick pane/2/para/tabs 1 
t2: pick pane/2/para/tabs 2 
t3: pick pane/2/para/tabs 3 
y: max sizes/line 4 + second size-text make subface[
size: as-pair t3 - t2 10000 
text: msg 
font: default-font 
para: default-para-wrap
]
p: self 
insert tail pane/1/pane reduce[
make subface[
offset: as-pair 0 height 
size: as-pair t1 y 
text: form any[row rows: rows + 1]
color: colors/theme-dark 
edge: make outline-edge[size: 0x1]
font: default-font-heading
]
make subface[
offset: as-pair t1 height 
size: as-pair t2 - t1 y 
text: user 
edge: make outline-edge[size: 0x1]
font: make default-font-top[color: either word? user-color[get user-color][user-color]style: 'bold]
]
make subface[
offset: as-pair t2 height 
size: as-pair t3 - t2 y 
span: all[p/span find p/span #W #W]
text: form msg 
color: either word? msg-color[get msg-color][msg-color]
edge: make outline-edge[size: 0x1]
font: default-font 
para: default-para-wrap
]
make subface[
offset: as-pair t3 height 
size: as-pair p/size/x - t3 - sizes/slider y 
span: all[p/span find p/span #W #X]
text: form either now/date = date/date[date/time][date/date]
edge: make outline-edge[size: 0x1]
font: default-font-top
]
]
height: height + y - 1 
if ((length? pane/1/pane) / 4) > limit[
y: pane/1/pane/1/size/y - 1 
remove/part pane/1/pane 4 
foreach[i u m d]pane/1/pane[
i/offset/y: u/offset/y: m/offset/y: d/offset/y: i/offset/y - y
]
height: height - y
]
unless no-show[
insert tail data reduce[user user-color msg msg-color date]
pane/1/size/y: height 
pane/3/ratio: pane/3/size/y / height 
show p
]
show pane/1
]
set-user-color: make function![id[integer!]color[tuple! word! none!]/local idx][
if any[zero? id id > rows][exit]
poke data id * 5 - 3 color 
if limit > (rows - id)[
idx: either rows > limit[(id + limit - rows) * 4 - 2][id * 4 - 2]
pane/1/pane/:idx/font/color: either word? color[get color][color]
show pane/1/pane/:idx
]
]
set-message-text: make function![id[integer!]string[string!]/local idx][
if any[zero? id id > rows][exit]
poke data id * 5 - 2 string 
if limit > (rows - id)[
idx: either rows > limit[(id + limit - rows) * 4 - 1][id * 4 - 1]
insert clear pane/1/pane/:idx/text string 
redraw
]
]
set-message-color: make function![id[integer!]color[tuple! word! none!]/local idx][
if any[zero? id id > rows][exit]
poke data id * 5 - 1 color 
if limit > (rows - id)[
idx: either rows > limit[(id + limit - rows) * 4 - 1][id * 4 - 1]
pane/1/pane/:idx/color: either word? color[get color][color]
show pane/1/pane/:idx
]
]
redraw: make function![/no-show /local row][
clear pane/1/pane 
height: 0 
rows: (length? data) / 5 
row: max 0 rows - limit: any[select options 'limit 100]
foreach[user user-color msg msg-color date]skip data row * 5[
append-message/no-show user user-color msg msg-color date row: row + 1
]
pane/1/size/y: height 
pane/3/ratio: either zero? height[1][pane/3/size/y / height]
unless no-show[show self]
]
init: make function![/local p][
p: self 
limit: any[select options 'limit 100]
insert pane make subface[
offset: as-pair 0 sizes/line 
size: p/size - as-pair sizes/slider sizes/line 
span: all[p/span find p/span #W #W]
pane:[]
]
insert tail pane make subface[
size: as-pair p/size/x sizes/line 
text: {ID^-User^-Message^-Sent} 
span: all[p/span find p/span #W #W]
color: colors/theme-dark 
font: make default-font-heading[align: 'left]
para: make default-para[tabs:[0 0 0]]
]
poke pane/2/para/tabs 1 sizes/cell * any[select options 'id 10]
poke pane/2/para/tabs 2 sizes/cell * (any[select options 'user 15]) + pick pane/2/para/tabs 1 
poke pane/2/para/tabs 3 size/x - sizes/slider - (sizes/cell * any[select options 'date 25]) 
insert tail pane make slider[
tip: none 
offset: as-pair p/size/x - sizes/slider sizes/line 
size: as-pair sizes/slider p/size/y - sizes/line 
span: case[
none? p/span[none]
all[find p/span #H find p/span #W][#XH]
find p/span #H[#H]
find p/span #W[#X]
]
options:[arrows]
action: make default-action[
on-click: make function![face /local p][
p: face/parent-face 
p/pane/1/offset/y: sizes/line + negate (height - face/size/y) * face/data 
show p
]
]
]
pane/3/init 
action/on-resize self
]
]
check: make rebface[
tip:{USAGE:
check "Option"
check "Option" data true
check "Option" data false
DESCRIPTION:
Tristate check-box with a green tick for Yes, a red cross for No, and empty being Unknown.
Left and right mouse clicks alternate between Yes/No and Unknown respectively.
OPTIONS:
'info specifies read-only
'bistate disables right-click state}
size: -1x5 
text: "" 
effect:[draw[pen colors/outline-light fill-pen colors/page box 0x0 0x0]]
font: default-font 
para: default-para-indented 
feel: make default-feel[
p1: as-pair 2 sizes/cell + 2 
p2: -4x-4 + p1 + as-pair sizes/cell * 3 sizes/cell * 3 
redraw: make function![face act pos][
all[
act = 'show 
clear skip face/effect/draw 7 
unless none? face/data[
insert tail face/effect/draw reduce either face/data[
['pen colors/state-dark 'line-width sizes/cell / 3 'line as-pair 2 sizes/cell * 3 as-pair sizes/cell * 1.5 p2/y as-pair p2/x p1/y]
][
['pen colors/state-dark 'line-width sizes/cell / 3 'line p1 p2 'line as-pair p2/x p1/y as-pair p1/x p2/y]
]
]
]
]
over: make function![face act pos][
face/effect/draw/pen: either act[colors/state-dark][colors/outline-light]
show face
]
engage: make function![face act event][
do select[
down[face/data: either none? face/data[true][none]face/action/on-click face]
alt-down[
unless find face/options 'bistate[
face/data: either none? face/data[false][none]face/action/on-click face
]
]
away[face/feel/over face false 0x0]
]act
]
]
rebind: make function![][
feel/p1: as-pair 2 sizes/cell + 2 
feel/p2: -4x-4 + feel/p1 + as-pair sizes/cell * 3 sizes/cell * 3
]
init: make function![][
all[negative? size/x size/x: 10000 size/x: 4 + para/origin/x + first size-text self]
effect/draw/6/y: sizes/cell 
effect/draw/7: as-pair sizes/cell * 3 sizes/cell * 4 
if find options 'info[
feel/redraw self 'show none 
effect/draw/4: colors/outline-light 
feel: make default-feel[]
]
]
]
check-group: make rebface[
tip:{USAGE:
check-group data["Option-1" true "Option-2" false "Option-3" none]
DESCRIPTION:
Group of check boxes.
Alignment is vertical unless height is specified as line height.
At runtime face/data is a block of logic (or none) indicating state of each check box.
OPTIONS:
'info specifies read-only
'bistate disables right-click state}
size: 50x-1 
pane:[]
init: make function![/local off siz pos last-pane][
data: reduce data 
all[negative? size/y size/y: 0.5 * sizes/line * length? data]
off: either size/y > sizes/line[
siz: as-pair size/x sizes/line 
as-pair 0 sizes/line
][
siz: as-pair 2 * size/x / length? data sizes/line 
as-pair siz/x 0
]
pos: 0x0 
foreach[label state]data[
insert tail pane make check[
tip: none 
offset: pos 
size: siz 
text: label 
data: state
]
pos: pos + off 
last-pane: last pane 
last-pane/options: options 
last-pane/init 
last-pane/init: none
]
data: make function![/local states][
states: copy[]
foreach check pane[insert tail states check/data]
states
]
]
]
drop-list: make rebface[
tip:{USAGE:
drop-list "1" data[1 2 3]
drop-list data["One" "Two" "Three"]
drop-list data ctx-rebgui/locale*/colors
DESCRIPTION:
Single column modal selection list.
At runtime face/text contains current selection.}
size: 25x5 
text: "" 
color: colors/outline-light 
data:[]
edge: outline-edge 
font: default-font 
para: make default-para[margin: as-pair sizes/slider + 2 2]
feel: make default-feel[
engage: make function![face action event][
face/pane/feel/engage face/pane action event
]
]
action: make default-action[
on-unfocus: make function![face][
hide-popup 
face/hidden-text: face/hidden-caret: none 
true
]
]
options:[info]
hidden-caret: hidden-text: none 
picked: make function![][
index? find data text
]
rebind: make function![][
color: colors/outline-light 
para/margin/x: sizes/line + 2
]
init: make function![/local p][
unless block? data[gui-error "drop-list expected data block"]
para: make para[]
p: self 
pane: make arrow[
tip: none 
offset: as-pair p/size/x - p/size/y + 1 1 
size: as-pair p/size/y - 4 p/size/y - 4 
span: if all[p/span find p/span #W][#X]
edge: none 
action: make default-action[
on-click: make function![face /filter-data fd[block!]/local data p v lines oft][
unless filter-data[edit/unfocus]
p: face/parent-face 
all[find p/options 'no-click exit]
data: either fd[fd][p/data]
unless zero? lines: length? data[
oft: either (lines * sizes/line) < (p/parent-face/size/y - p/offset/y - p/size/y)[
p/offset + as-pair 0 p/size/y - 1
][
either (lines * sizes/line) <= (p/parent-face/size/y - 4)[
as-pair p/offset/x p/parent-face/size/y - 2 - (lines * sizes/line)
][
as-pair p/offset/x p/parent-face/size/y - 2 - (sizes/line * to integer! p/parent-face/size/y / sizes/line)
]
]
if v: choose p p/size/x oft data[
p/text: form v 
p/hidden-text: p/hidden-caret: none 
p/action/on-click p 
either p/type = 'drop-list[show p edit/unfocus][set-focus p]
]
]
]
]
]
pane/init
]
]
edit-list: make drop-list[
tip:{USAGE:
edit-list "1" data[1 2 3]
edit-list data["One" "Two" "Three"]
edit-list data ctx-rebgui/locale*/colors
DESCRIPTION:
Editable single column modal selection list.
At runtime face/text contains current selection.}
color: colors/page 
edge: theme-edge 
feel: make edit/feel bind[
engage: make function![face action event /local start end total visible fd pf][
switch action[
key[
if event/key = #"^M"[
edit-text face event 
hide-popup 
edit/unfocus 
exit
]
if event/key = 'down[
either view*/pop-face[set-focus view*/pop-face][face/pane/action/on-click face/pane]
exit
]
prev-caret: index? view*/caret 
face/text: any[face/hidden-text head view*/caret]
view*/caret: any[face/hidden-caret view*/caret]
all[view*/highlight-start view*/highlight-start: at face/text index? view*/highlight-start]
all[view*/highlight-end view*/highlight-end: at face/text index? view*/highlight-end]
edit-text face event 
face/hidden-text: copy face/text 
face/hidden-caret: at face/hidden-text index? view*/caret 
fd: copy[]
if find face/text edit/letter[
foreach ln sort face/data[
if find/match ln face/text[
face/text: copy ln 
view*/caret: at face/text index? view*/caret 
unless char? event/key[
view*/caret: at face/text prev-caret 
edit-text face event 
face/hidden-text: copy face/text 
face/hidden-caret: at face/hidden-text index? view*/caret
]
]
if find/match ln face/hidden-text[
insert tail fd ln
]
]
]
either not empty? fd[
either none? view*/pop-face[
face/pane/action/on-click/filter-data face/pane fd
][
pf: view*/pop-face 
pf/data: copy fd 
pf/pane/1/size/y: pf/size/y: sizes/line * (length? fd) 
pf/lines: to integer! pf/size/y / sizes/line 
pf/rows: length? fd 
show pf
]
][
hide-popup
]
show face
]
down[
either event/double-click[
all[view*/caret not empty? view*/caret current-word view*/caret]
][
either face <> view*/focal-face[set-focus face][unlight-text]
view*/caret: offset-to-caret face event/offset 
show face
]
]
over[
unless equal? view*/caret offset-to-caret face event/offset[
unless view*/highlight-start[view*/highlight-start: view*/caret]
view*/highlight-end: view*/caret: offset-to-caret face event/offset 
show face
]
]
]
]
]in edit 'self 
options:[]
caret: none 
rebind: make function![][color: colors/page]
]
field: make rebface[
tip:{USAGE:
field
field -1 "String"
DESCRIPTION:
Editable text field with no text wrapping.
OPTIONS:
'info specifies read-only}
size: 50x5 
text: "" 
color: colors/page 
edge: theme-edge 
font: default-font 
para: default-para 
feel: edit/feel 
rebind: make function![][color: colors/page]
init: make function![][
if find options 'info[
feel: none 
all[color = colors/page color: colors/outline-light]
]
para: make para[]
all[negative? size/x size/x: 10000 size/x: 4 + first size-text self]
]
esc: none 
caret: none 
undo: copy[]
]
group-box: make rebface[
tip:{USAGE:
group-box "Title" data[field field]
DESCRIPTION:
A static widget used to group widgets within a bounded container.}
size: -1x-1 
text: "Untitled" 
effect:[draw[pen colors/outline-dark line-width sizes/edge fill-pen none box 0x0 0x0 effects/radius pen colors/page line 0x0 0x0]]
font: make default-font-top[color: colors/outline-dark]
para: make default-para[origin: as-pair sizes/cell * 4 0]
feel: make default-feel[
redraw: make function![face act pos][
if act = 'show[
all[
face/color 
face/effect/draw/fill-pen: face/color 
poke face/effect/draw 12 colors/page 
face/color: none
]
face/effect/draw/15/x: sizes/cell * 5 + first size-text face
]
]
]
action: make default-action[
on-resize: make function![face][poke face/effect/draw 9 face/size - 1x1]
]
rebind: make function![][
font/name: effects/font 
font/size: sizes/font 
font/color: colors/outline-dark 
para/origin/x: sizes/cell * 4
]
init: make function![][
data: layout/only data 
pane: data/pane 
foreach face pane[face/offset: face/offset + as-pair 0 sizes/cell * sizes/gap]
all[negative? size/x size/x: max 16 + first size-text self data/size/x]
all[negative? size/y size/y: sizes/cell * sizes/gap + data/size/y]
effect/draw/box/y: effect/draw/14/y: effect/draw/15/y: sizes/cell * 2 
effect/draw/14/x: sizes/cell * 3 
data: none 
action/on-resize self
]
]
heading: make rebface[
tip:{USAGE:
heading "A text heading."
DESCRIPTION:
Large text.}
size: -1x-1 
text: "" 
font: default-font-large 
para: default-para-wrap 
init: make function![][
all[negative? size/x negative? size/y size: 10000x10000 size: 4x4 + size-text self]
all[negative? size/x size/x: 10000 size/x: 4 + first size-text self]
all[negative? size/y size/y: 10000 size/y: 4 + second size-text self]
all[size/y > sizes/line font/align <> 'center font: make font[valign: 'top]]
size/y: max size/y sizes/line
]
]
image: make rebface[
tip:{USAGE:
image %images/logo.png
image logo
image logo effect[crop 10x10 50x50]
DESCRIPTION:
An image.}
size: -1x-1 
effect: 'fit 
init: make function![][
all[negative? size/x size/x: image/size/x]
all[negative? size/y size/y: image/size/y]
]
]
label: make heading[
tip:{USAGE:
label "A text label."
DESCRIPTION:
Bold text.}
font: default-font-bold
]
led: make rebface[
tip:{USAGE:
led "Option"
led "Option" data true
led "Option" data false
led "Option" data none
DESCRIPTION:
Tristate indicator box with colors representing Yes & No, and empty being Unknown.}
size: -1x5 
effect:[draw[pen colors/outline-light fill-pen none box 0x0 0x0]]
font: default-font 
para: default-para-indented 
feel: make default-feel[
redraw: make function![face act pos][
all[
act = 'show 
face/effect/draw/4: select reduce[true colors/state-dark false colors/state-light]face/data
]
]
]
init: make function![][
if negative? size/x[size/x: 10000 size/x: 4 + para/origin/x + first size-text self]
effect/draw/6/y: sizes/cell 
effect/draw/7: as-pair sizes/cell * 3 sizes/cell * 2.5
]
]
led-group: make rebface[
tip:{USAGE:
led-group data["Option-1" true "Option-2" false "Option-3" none]
DESCRIPTION:
Group of LED indicators.
Alignment is vertical unless height is specified as line height.
At runtime face/data is a block of logic (or none) indicating state of each LED indicator.}
size: 50x-1 
pane:[]
feel: make default-feel[
redraw: make function![face act pos][
if act = 'show[
face/data: reduce face/data 
repeat i length? face/pane[
face/pane/:i/data: pick face/data i
]
]
]
]
init: make function![/local off siz pos last-pane][
data: reduce data 
all[negative? size/y size/y: 0.5 * sizes/line * length? data]
off: either size/y > sizes/line[
siz: as-pair size/x sizes/line 
as-pair 0 sizes/line
][
siz: as-pair 2 * size/x / length? data sizes/line 
as-pair siz/x 0
]
pos: 0x0 
foreach[label state]data[
insert tail pane make led[
tip: none 
offset: pos 
size: siz 
text: label 
data: state
]
pos: pos + off 
last-pane: last pane 
last-pane/init 
last-pane/init: none
]
clear data 
foreach led pane[insert tail data led/data]
]
]
link: make rebface[
tip:{USAGE:
link
link http://www.dobeash.com
link "RebGUI" http://www.dobeash.com/rebgui
DESCRIPTION:
Hypertext link.}
size: -1x5 
font: make default-font[color: blue style: 'underline]
para: default-para 
feel: make default-feel[
over: make function![face act pos][
face/font/color: either act[colors/state-light][blue]
show face
]
engage: make function![face act event][
all[
act = 'up 
browse face/data
]
]
]
rebind: make function![][
font/name: effects/font 
font/size: sizes/font
]
init: make function![][
unless text[text: either data[form data]["http://www.rebol.com"]]
unless data[data: to url! text]
all[negative? size/x size/x: 10000 size/x: 4 + first size-text self]
]
]
menu: make rebface[
tip:{USAGE:
menu data["Item-1"["Choice 1"[alert "1"]"Choice 2"[alert "2"]]"Item-2"[]]
DESCRIPTION:
Simple one-level text-only menu system.}
size: 100x5 
pane:[]
color: colors/outline-light 
rebind: make function![][color: colors/outline-light]
init: make function![/local item item-offset][
item-offset: 2x0 
foreach[label block]data[
insert tail pane make subface[
offset: item-offset 
size: as-pair 1 sizes/line 
text: label 
data: block 
font: make default-font[align: 'center]
para: default-para 
feel: make default-feel[
over: make function![face act pos][
either act[select-face face][deselect-face face]
]
engage: make function![face act event][
if act = 'up[
do select face/data choose face/parent-face face/options face/parent-face/offset + face/offset + as-pair 0 face/size/y extract face/data 2 
deselect-face face
]
]
]
]
item: last pane 
item/options: item/size/x: sizes/line + first size-text item 
item-offset/x: item-offset/x + item/size/x 
foreach i extract item/data 2[
default-text/text: i 
item/options: max item/options sizes/cell + first size-text default-text
]
]
data: first pane
]
]
panel: make pill[
tip:{USAGE:
panel sky data[after 1 field field]
DESCRIPTION:
A static widget used to group widgets within a container.}
size: -1x-1 
color: colors/outline-light + 32.32.32 
rebind: make function![][color: colors/outline-light + 32.32.32]
init: make function![][
data: layout/only data 
pane: data/pane 
all[negative? size/x size/x: data/size/x]
all[negative? size/y size/y: data/size/y]
data: none 
action/on-resize self
]
]
password: make field[
tip:{USAGE:
password
password "Secret"
DESCRIPTION:
Editable password field with text displayed as a series of large dots.}
size: 50x5 
color: colors/page 
font: make default-font[size: to integer! sizes/font * 1.5 name: font-fixed]
rebind: make function![][
color: colors/page 
font/size: to integer! sizes/font * 1.5
]
init: make function![/local p char-width radius][
p: self 
para: make para[]
pane: make subface[
color: colors/page 
effect:[draw[pen colors/text fill-pen colors/text]]
feel: make default-feel[]
span: all[p/span find p/span #W #W]
]
char-width: first size-text make rebface[
text: "M" font: make default-font[
size: to integer! sizes/font * 1.5 name: font-fixed
]
]
radius: to integer! char-width + 1 / 3 
pane/size: size 
pane/feel/redraw: make function![face act pos /local offset]compose/deep[
if act = 'show[
clear skip face/effect/draw 4 
either all[view*/focal-face = face/parent-face face/parent-face/text = head view*/caret][
repeat i length? head view*/caret[
insert tail face/effect/draw reduce['circle i * (as-pair char-width 0) + (as-pair 1 - radius sizes/line / 2) (radius)]
]
offset: (as-pair char-width 0) * index? view*/caret 
offset/x: offset/x - (char-width) 
insert tail face/effect/draw reduce[
'box offset + (as-pair 2 2) offset + (as-pair 3 sizes/line - 4)
]
][
repeat i length? face/parent-face/text[
insert tail face/effect/draw reduce['circle i * (as-pair char-width 0) + (as-pair 1 - radius sizes/line / 2) (radius)]
]
]
]
]
]
]
pie-chart: make rebface[
tip:{USAGE:
pie-chart data["Red" red 60 "Green" green 30 "Blue" blue 10]
DESCRIPTION:
A pie-chart.
OPTIONS:
'no-label to turn labels off
[start n]where n is the degrees value
[explode n]when n is the number of pixels}
size: 50x50 
feel: make default-feel[
redraw: make function![face act pos /local plot total angle pie-size label-offset label-distance label-size][
if act = 'show[
clear plot: skip last face/effect 4 
total: face/degrees 
pie-size: face/size / 2 - 1x1 - as-pair face/explode face/explode 
label-distance: pie-size * 0.75 
foreach[label color val]face/data[
angle: 360 * val / face/sum 
insert plot reduce[
'fill-pen color 
'arc face/size / 2 + as-pair face/explode * (cosine (total + (angle / 2))) - 1 face/explode * (sine (total + (angle / 2))) - 1 pie-size total angle 
'closed
]
unless find face/options 'no-label[
default-text/text: label 
label-size: size-text default-text 
label-offset: as-pair label-distance/x * (cosine (total + (angle / 2))) face/explode + label-distance/y * (sine (total + (angle / 2))) 
label-offset/x: label-offset/x - (label-size/x / 2) 
label-offset/y: label-offset/y - (label-size/y / 2) 
insert tail plot reduce['text 'anti-aliased form label face/size / 2 + label-offset]
]
total: total + angle 
if total >= 360[total: total - 360]
]
]
]
]
effect:[draw[pen colors/text font default-font]]
sum: 0 
explode: 0 
degrees: 270 
init: make function![][
data: reduce data 
explode: any[select options 'explode 0]
if select options 'start[
degrees: 270 + select options 'start 
if degrees >= 360[degrees: degrees - 360]
if degrees < 0[degrees: degrees + 360]
]
foreach[label color val]data[sum: sum + val]
]
]
progress: make rebface[
tip:{USAGE:
progress
progress data .5
DESCRIPTION:
A horizontal progress indicator.
At runtime face/data ranges from 0 to 1 indicating percentage.}
size: 50x5 
effect:[draw[pen colors/state-dark fill-pen colors/state-dark box 1x1 1x1]]
data: 0 
edge: default-edge 
feel: make default-feel[
redraw: make function![face act pos][
all[
act = 'show 
face/effect/draw/7/x: max 1 face/size/x - 2 - sizes/edge - sizes/edge * face/data: min 1 max 0 face/data
]
]
]
action: make default-action[
on-resize: make function![face][face/effect/draw/6/y: face/size/y - 2 - sizes/edge - sizes/edge]
]
init: make function![][action/on-resize self]
]
radio-group: make rebface[
tip:{USAGE:
radio-group data["Option A" "Option B"]
radio-group data[2 "On" "Off"]
DESCRIPTION:
Group of mutually exclusive radio buttons.
Alignment is vertical unless height is specified as line height.
An integer provided as the first entry in the block indicates the default selection.}
size: 50x-1 
pane:[]
picked: none 
selected: make function![][
all[picked pick data picked]
]
select-item: make function![item[integer! none!]][
either any[none? item zero? item][
item: either picked = 1[2][1]
pane/:item/feel/engage/reset pane/:item 'down none
][
all[item <> picked pane/:item/feel/engage pane/:item 'down none]
]
]
init: make function![/local off siz pos index][
unless string? first data: reduce data[
picked: first data 
remove data
]
all[negative? size/y size/y: sizes/line * length? data]
off: either size/y > sizes/line[
siz: as-pair size/x sizes/line 
as-pair 0 sizes/line
][
siz: as-pair size/x / length? data sizes/line 
as-pair siz/x 0
]
pos: 0x0 
index: 1 
foreach label data[
insert tail pane make subface[
offset: pos 
size: siz 
text: label 
effect: compose/deep[draw[pen (colors/outline-light) fill-pen (colors/page) circle (as-pair sizes/cell * 1.5 sizes/cell * 2.5) (sizes/cell * 1.5)]]
data: index 
font: default-font 
para: default-para-indented 
feel: make default-feel[
over: make function![face act pos][
face/effect/draw/pen: either act[colors/outline-dark][colors/outline-light]
show face
]
engage: make function![face act event /reset /local pf][
do select[
down[
if all[pf: face/parent-face pf/picked <> face/data][
all[
pf/picked 
clear skip pf/pane/(pf/picked)/effect/draw 7 
show pf/pane/(pf/picked)
]
either reset[pf/picked: none][
pf/picked: face/data 
insert tail face/effect/draw reduce[
'pen colors/state-dark 'fill-pen colors/state-dark 'circle as-pair sizes/cell * 1.5 sizes/cell * 2.5 sizes/cell - 1
]
show face 
pf/action/on-click pf
]
]
]
away[face/feel/over face false 0x0]
]act
]
]
]
pos: pos + off 
index: index + 1
]
all[
integer? picked 
insert tail pane/:picked/effect/draw reduce[
'pen colors/state-dark 'fill-pen colors/state-dark 'circle as-pair sizes/cell * 1.5 sizes/cell * 2.5 sizes/cell - 1
]
]
]
]
scroll-panel: make rebface[
tip:{USAGE:
scroll-panel data[sheet]
DESCRIPTION:
A panel used to group widgets within a scrollable container.
OPTIONS:
'offset keeps the original offset}
size: 50x50 
pane:[]
edge: outline-edge 
action: make default-action[
on-click: make function![face][system/view/focal-face: face]
on-scroll: make function![face scroll /page][
either page[
all[face/pane/3/show? face/pane/3/set-data scroll]
][
all[face/pane/2/show? face/pane/2/set-data scroll]
]
]
on-resize: make function![face /child /local p1 p2 p3 p4][
p1: face/pane/1 
p2: face/pane/2 
p3: face/pane/3 
p4: face/pane/4 
p2/show?: either p1/size/y <= face/size/y[face/sld-offset/x: 0 false][face/sld-offset/x: sizes/slider true]
p3/show?: either p1/size/x <= face/size/x[face/sld-offset/y: 0 false][face/sld-offset/y: sizes/slider true]
p4/show?: either any[p2/show? p3/show?][true][false]
p2/ratio: min 1 face/size/y - face/sld-offset/y / p1/size/y 
p3/ratio: min 1 face/size/x - face/sld-offset/x / p1/size/x 
if child[
all[p2/ratio = 1 p2/data: p1/offset/y: 0]
all[p3/ratio = 1 p3/data: p1/offset/x: 0]
show face
]
]
]
p1: p2: p3: p4: none 
sld-offset: 0x0 
init: make function![/local p][
p: self 
data: layout/only data 
insert pane either 1 = length? data/pane[first data/pane][data]
all[negative? size/x size/x: data/size/x]
all[negative? size/y size/y: data/size/y]
data: none 
p1: first pane 
color: p1/color 
unless find options 'offset[p1/offset: 0x0]
p1/edge: none 
if span[
all[find span #H p1/span: #H]
all[find span #W p1/span: #W]
all[find span #H find span #W p1/span: #HW]
]
insert tail pane make slider[
tip: none 
offset: as-pair p/size/x - sizes/slider 0 
size: as-pair sizes/slider p/size/y - sizes/slider 
span: case[
none? p/span[none]
all[find p/span #H find p/span #W][#XH]
find p/span #H[#H]
find p/span #W[#X]
]
options:[arrows]
action: make default-action[
on-click: make function![face][
p1/offset/y: negate p1/size/y + sld-offset/y - p/size/y * face/data 
show p1
]
]
]
p2: second pane 
p2/init 
insert tail pane make slider[
tip: none 
offset: as-pair 0 p/size/y - sizes/slider 
size: as-pair p/size/x - sizes/slider sizes/slider 
span: case[
none? p/span[none]
all[find p/span #H find p/span #W][#YW]
find p/span #H[#Y]
find p/span #W[#W]
]
options:[arrows]
action: make default-action[
on-click: make function![face][
p1/offset/x: negate p1/size/x + sld-offset/x - p/size/x * face/data 
show p1
]
]
]
p3: third pane 
p3/init 
insert tail pane make symbol[
offset: p/size - as-pair sizes/slider sizes/slider 
size: as-pair sizes/slider sizes/slider 
span: case[
none? p/span[none]
all[find p/span #H find p/span #W][#XY]
find p/span #H[#Y]
find p/span #W[#X]
]
edge: none 
data: 'record 
action: make default-action[
on-click: make function![face /local p][
p: face/parent-face 
either p1/offset = 0x0[
p2/data: p3/data: 1
][
p2/data: p3/data: 0
]
all[p2/show? show p2]
all[p3/show? show p3]
]
]
]
p4: fourth pane 
p4/init 
action/on-resize self
]
]
sheet: make rebface[
tip:{USAGE:
sheet
sheet options[size 3x3 width 2]
sheet options[size 3x3 widths[2 3 4]]
sheet data[A1 1 A2 2 A3 "=A1 + A2"]
DESCRIPTION:
Simple spreadsheet, based on rebocalc.r, with formulas calculated left to right, top to bottom.
A cell is either a scalar value, string, or a formula starting with "=".
Scalar values are automatically right-justified, series values left-justified.
Remember to put spaces between each item in a formula and use () where needed.
OPTIONS:
'size specifies number of columns and rows
'width specifies cell width in relation to cell height
'widths specifies n cell widths}
size: -1x-1 
color: colors/outline-light 
pane:[]
data:[]
cells: none 
load-data: make function![dat /local v][
insert clear data dat 
foreach cell cells[
cell/text: either v: select data cell/data[form v][copy ""]
enter cell
]
compute 
show cells
]
save-data: make function![][
clear data 
foreach cell cells[
unless empty? cell/text[
insert tail data either cell/init[
reduce[cell/data join "=" form cell/init]
][
reduce[cell/data get cell/data]
]
]
]
]
enter: make function![face /local v][
face/color: colors/page 
face/font/align: 'left 
attempt[unset face/data]
face/init: none 
all[empty? trim face/text exit]
v: attempt[load either #"=" = first face/text[next face/text][face/text]]
either any[series? v word? v][
either #"=" = first face/text[face/color: colors/outline-light face/init: :v][set face/data face/text]
][
face/font/align: 'right 
set face/data v
]
]
compute: make function![/local v][
foreach cell cells[
if cell/init[
either all[word? cell/init string? get cell/init][v: get cell/init][
unless v: attempt[do cell/init][cell/text: "ERROR!"]
]
cell/font/align: either series? v['left]['right]
cell/text: form v 
set cell/data cell/text 
show cell
]
]
]
init: make function![/local cols rows p pos char v widths row-size][
either pair? v: select options 'size[cols: v/x rows: v/y][
either empty? data[cols: 6 rows: 12][
cols: #"A" 
rows: 1 
foreach[cell val]data[
cols: max cols uppercase first form cell 
rows: max rows to integer! next form cell
]
cols: to integer! cols - 64
]
]
widths: copy[]
case[
v: select options 'widths[insert widths v]
v: select options 'width[insert/dup widths v cols]
true[insert/dup widths 4 cols]
]
row-size: as-pair sizes/line * 2 sizes/line 
if negative? size/x[
size/x: row-size/x + cols + 1 
foreach w widths[size/x: w * sizes/line + size/x]
]
all[negative? size/y size/y: rows * sizes/line + rows + row-size/y + 1]
char: #"A" 
pos: as-pair row-size/x + 1 0 
repeat x cols[
insert tail pane make subface[
offset: pos 
size: as-pair sizes/line * pick widths x sizes/line 
text: form char 
color: colors/theme-dark 
font: default-font-heading
]
char: char + 1 
pos/x: sizes/line * (pick widths x) + pos/x + 1
]
pos: as-pair 0 sizes/line + 1 
repeat y rows[
insert tail pane make subface[
offset: pos 
size: row-size 
text: form y 
color: colors/theme-dark 
font: default-font-heading
]
pos/y: pos/y + sizes/line + 1
]
p: self 
cells: tail pane 
pos: row-size + 1x1 
repeat y rows[
pos/x: row-size/x + 1 
char: #"A" 
repeat x cols[
v: to word! join char y 
insert tail pane make rebface[
type: 'field 
offset: pos 
size: as-pair sizes/line * pick widths x sizes/line 
text: form any[select p/data v ""]
color: colors/page 
font: make default-font[]
para: make default-para[]
feel: edit/feel 
data: v 
action: make default-action[
on-focus: make function![face][
all[face/init face/text: join "=" form face/init]
face/font/align: 'left 
select-face face 
true
]
on-unfocus: make function![face][
deselect-face/fill face 
enter face compute face/para/scroll: 0x0 
true
]
]
]
char: char + 1 
pos/x: sizes/line * (pick widths x) + pos/x + 1
]
pos/y: pos/y + sizes/line + 1
]
unless empty? data[
foreach cell cells[
unless empty? cell/text[enter cell]
]
compute
]
]
]
slider: make rebface[
tip:{USAGE:
slider
slider data .5[print face/data]
DESCRIPTION:
A slider control. Its size determines whether it is vertical or horizontal.
At runtime face/data ranges from 0 to 1 indicating percentage.
OPTIONS:
'arrows adds an arrow to each end of the slider creating a scroller
'together forces the arrows to appear together
[ratio n]where n indicates the initial dragger size}
size: 5x50 
data: 0 
color: colors/outline-light 
effect:[
draw[
pen colors/outline-dark fill-pen colors/theme-light box 0x0 10x10 
fill-pen colors/theme-light box 0x0 0x0 
fill-pen colors/theme-light box 0x0 0x0 
pen colors/page 
fill-pen colors/page triangle 0x0 0x0 0x0 
fill-pen colors/page triangle 0x0 0x0 0x0
]
]
ratio: 0.1 
step: 5E-2 
hold: none 
state: none 
flags: none 
set-data: make function![new[integer! decimal! pair!]/local old][
old: data 
data: min 1 max 0 either pair? new[
data + either negative? new/y[negate step][step]
][new]
all[data <> old show self]
]
feel: make default-feel[
redraw: make function![
face act pos 
/local width state-blk freedom axis dragdom arrow-width arrows? together? draw-blk arrow-blk arrow-size
][
if act = 'draw[
if face/state <> compose state-blk:[(face/data) (face/size) (face/ratio) (face/flags)][
width: min face/size/x face/size/y 
face/ratio: any[face/ratio 0.1]
freedom: 1 - face/ratio 
axis: either face/size/y > face/size/x['y]['x]
dragdom: face/size/:axis 
arrow-width: 0 
if all[face/flags arrows?: find face/flags 'arrows][
arrow-width: min face/size/x face/size/y 
dragdom: dragdom - (2 * arrow-width) 
together?: find face/flags 'together
]
draw-blk: face/effect/draw 
arrow-blk: at draw-blk 8 
either arrows?[
arrow-size: as-pair arrow-width - 1 arrow-width - 1 
arrow-blk/4: either together?[dragdom * either axis = 'y[0x1][1x0]][0x0]
arrow-blk/5: arrow-blk/4 + arrow-size 
arrow-blk/9: dragdom + arrow-width * either axis = 'y[0x1][1x0]
arrow-blk/10: arrow-blk/9 + arrow-size 
arrow-blk/16: arrow-blk/4 + (width * 0.1 * either axis = 'y[5x2][2x5]) 
arrow-blk/17: arrow-blk/4 + (width * 0.1 * either axis = 'y[2x7][7x8]) 
arrow-blk/18: arrow-blk/4 + (width * 0.1 * either axis = 'y[8x7][7x2]) 
arrow-blk/22: arrow-blk/9 + (width * 0.1 * either axis = 'y[5x8][8x5]) 
arrow-blk/23: arrow-blk/9 + (width * 0.1 * either axis = 'y[8x3][3x2]) 
arrow-blk/24: arrow-blk/9 + (width * 0.1 * either axis = 'y[2x3][3x8])
][
repeat pos[4 5 9 10 16 17 18 22 23 24][arrow-blk/:pos: 0x0]
]
draw-blk/6: 0x0 
draw-blk/6/:axis: (dragdom * freedom * min 1 max 0 face/data) + either together?[0][arrow-width]
draw-blk/7: draw-blk/6 + width - 1 
draw-blk/7/:axis: (freedom * min 1 max 0 face/data) + face/ratio * (dragdom - 1) + either together?[0][arrow-width]
draw-blk/7: max draw-blk/7 draw-blk/6 + as-pair sizes/cell * 2 sizes/cell * 2 
either none? face/state[
face/state: compose state-blk
][
face/state: compose state-blk 
face/action/on-click face
]
]
]
]
engage: make function![
face act event 
/local freedom axis dragdom arrows? together? arrow-width offset more? page oft win-face
][
freedom: 1 - face/ratio 
axis: either face/size/y > face/size/x['y]['x]
dragdom: face/size/:axis 
arrow-width: 0 
if all[face/flags arrows?: find face/flags 'arrows][
arrow-width: min face/size/x face/size/y 
dragdom: dragdom - (2 * arrow-width) 
together?: find face/flags 'together
]
oft: event/offset 
if all[act = 'time event/face = view*/screen-face/pane/1][
win-face: find-window face 
oft: oft + (event/face/offset - win-face/offset)
]
offset: oft - either act = 'time[win-offset? face][0]
offset: offset/:axis - either together?[0][arrow-width]
if find[over away]act[
if all[
number? face/hold 
freedom > 0
][
face/set-data (offset - face/hold / (dragdom * freedom))
]
exit
]
if find[down time]act[
if act = 'down[face/rate: 16]
either all[
more?: offset >= (dragdom * (freedom * face/data)) 
offset < (dragdom * ((freedom * face/data) + face/ratio))
][
if act = 'down[
face/hold: offset - (dragdom * (freedom * face/data)) 
face/effect/draw/4: colors/state-light show face
]
][
case[
offset < 0[
if act = 'down[
face/hold: 'top-arrow 
face/effect/draw/9: colors/state-light show face
]
if face/hold = 'top-arrow[
face/set-data (face/data - face/step)
]
]
all[together? offset > dragdom offset < (dragdom + arrow-width)][
if act = 'down[
face/hold: 'top-arrow 
face/effect/draw/9: colors/state-light show face
]
if face/hold = 'top-arrow[
face/set-data (face/data - face/step)
]
]
offset > (dragdom + either together?[arrow-width][0])[
if act = 'down[
face/hold: 'bottom-arrow 
face/effect/draw/14: colors/state-light show face
]
if face/hold = 'bottom-arrow[
face/set-data (face/data + face/step)
]
]
true[
if act = 'down[face/hold: 'page]
if face/hold = 'page[
page: any[all[freedom = 0 0]face/ratio / freedom]
face/set-data (face/data + either more?[page][negate page])
]
]
]
]
]
if act = 'up[
face/rate: none face/hold: none 
face/effect/draw/4: face/effect/draw/9: face/effect/draw/14: colors/theme-light show face
]
]
]
rebind: make function![][color: colors/outline-light]
init: make function![][
all[number? data data: min 1 max 0 data]
flags: copy[]
all[find options 'arrows insert tail flags 'arrows]
if any[effects/arrows-together find options 'together][insert tail flags 'together]
all[find options 'ratio ratio: select options 'ratio]
]
]
spinner: make rebface[
tip:{USAGE:
spinner
spinner options[$1 $10 $1]data $5
DESCRIPTION:
Similar to a field, with arrows to increment/decrement a value by a nominated step amount.
OPTIONS:
[min max step]block of minimum, maximum and step amounts}
size: 20x5 
color: colors/page 
text: "" 
edge: theme-edge 
font: default-font-right 
para: make default-para[]
feel: edit/feel 
options:[1 10 1]
pane: copy[]
action: make default-action[
on-scroll: make function![face scroll /page][
face/text: either any[none? face/data page][
form data: either negative? scroll/y[second face/options][first face/options]
][
form face/data + either negative? scroll/y[last face/options][negate last face/options]
]
face/action/on-unfocus face
]
on-unfocus: make function![face][
either empty? face/text[
face/data: none
][
face/data: any[attempt[to type? first face/options face/text]face/data]
face/text: either face/data[form face/data: min max face/data first face/options second face/options][copy ""]
show face
]
face/action/on-click face 
true
]
]
rebind: make function![][color: colors/page]
init: make function![/local p][
all[data text: form data]
all[not empty? text data: to type? first options text]
para/margin/x: size/y - sizes/cell 
p: self 
insert pane make arrow[
tip: none 
offset: as-pair p/size/x - p/size/y + sizes/cell 0 
size: as-pair p/size/y - sizes/cell p/size/y / 2 
span: all[
p/span 
case[
all[find p/span #L find p/span #W][#OX]
find p/span #W[#X]
find p/span #L[#O]
]
]
data: 'up 
edge: none 
action: make default-action[
on-click: make function![face /local p][
p: face/parent-face 
p/data: any[attempt[to type? first p/options p/text]p/data first p/options]
p/data: p/data + third p/options 
if p/data > second p/options[p/data: second p/options]
p/text: form p/data 
edit/unlight-text 
view*/caret: none 
show p 
p/action/on-click p
]
]
]
pane/1/init 
insert tail pane make arrow[
tip: none 
offset: as-pair p/size/x - p/size/y + sizes/cell p/size/y / 2 
size: as-pair p/size/y - sizes/cell p/size/y / 2 
span: all[
p/span 
case[
all[find p/span #L find p/span #W][#OX]
find p/span #W[#X]
find p/span #L[#O]
]
]
edge: none 
action: make default-action[
on-click: make function![face /local p][
p: face/parent-face 
p/data: any[attempt[to type? first p/options p/text]p/data first p/options]
p/data: p/data - third p/options 
if p/data < first p/options[p/data: first p/options]
p/text: form p/data 
edit/unlight-text 
view*/caret: none 
show p 
p/action/on-click p
]
]
]
pane/2/init
]
esc: none 
caret: none 
undo: copy[]
]
splitter: make rebface[
tip:{USAGE:
area splitter area
DESCRIPTION:
Placed between two widgets on the same row or column.
Allows both to be resized by dragging the splitter left/right or up/down respectively.
Its size determines whether it is vertical or horizontal.}
size: 1x25 
color: colors/outline-light 
feel: make default-feel[
redraw: make function![face act pos /local f p n][
unless face/data[
f: find face/parent-face/pane face 
p: back f 
n: next f 
if face/size/y <= face/size/x[
while[face/offset/x <> p/1/offset/x][
if head? p[gui-error "Splitter failed to find previous widget"]
p: back p
]
while[face/offset/x <> n/1/offset/x][
if tail? p[gui-error "Splitter failed to find next widget"]
n: next n
]
]
face/data: reduce[first p first n]
]
]
over: make function![face act pos][
face/color: either act[colors/state-dark][colors/outline-light]
show face
]
engage: make function![face act event /local p n delta][
if event/type = 'move[
p: first face/data 
n: second face/data 
either face/size/y > face/size/x[
delta: face/offset/x - face/offset/x: min n/offset/x + n/size/x - face/size/x - 1 max p/offset/x + 1 face/offset/x + event/offset/x 
p/size/x: p/size/x - delta 
n/size/x: n/size/x + delta 
n/offset/x: n/offset/x - delta
][
delta: face/offset/y - face/offset/y: min n/offset/y + n/size/y - face/size/y - 1 max p/offset/y + 1 face/offset/y + event/offset/y 
p/size/y: p/size/y - delta 
n/size/y: n/size/y + delta 
n/offset/y: n/offset/y - delta
]
show[p face n]
]
all[act = 'away face/feel/over face false 0x0]
]
]
rebind: make function![][color: colors/outline-light]
]
style: make rebface[
tip:{USAGE:
style 20x20 data[btn "VID btn"]
style data[btn 20x20]options[size]
DESCRIPTION:
A container for a VID style.
OPTIONS:
'size use VID style size.}
size: 5x5 
data:[]
init: make function![][
unless find options 'size[insert next data size]
data: system/words/layout/tight data 
pane: data/pane/1 
size: pane/size 
data: none
]
]
symbol: make rebface[
tip:{USAGE:
symbol data 'start
symbol data 'rewind
symbol data 'left
symbol data 'pause
symbol data 'stop
symbol data 'record
symbol data 'right
symbol data 'forward
symbol data 'end
symbol data 'up
symbol data 'down
symbol -1 "Some text"
DESCRIPTION:
Basic single-color shapes, such as those found on media players, on an "arrow" type button.
Uses "Webdings" if available, otherwise simple ASCII equivalents.}
size: 5x-1 
text: "" 
edge: default-edge 
font: default-font-heading 
feel: make default-feel[
redraw: make function![face act pos][
if act = 'show[
face/color: either face/data[colors/state-light][colors/theme-light]
]
]
engage: make function![face act event][
do select[
time[all[face/data face/action/on-click face]]
down[face/data: on]
up[face/data: off face/action/on-click face]
over[face/data: on]
away[face/data: off]
]act 
show face
]
]
action: make default-action[
on-resize: make function![face][
face/font/size: to integer! (min face/size/x face/size/y) * either face/font/style[0.6][0.8]
all[odd? face/font/size face/font/size: face/font/size + 1]
all[
not effects/webdings 
negative? face/font/space/x 
face/font/space/x: face/font/size * -0.2
]
]
]
init: make function![][
either all[data empty? text][
font: make font either effects/webdings[[name: "webdings"]][[space: -1x0 style: 'bold]]
all[negative? size/y size/y: size/x]
text: pick do select[
start[["9" "|<<"]]
rewind[["7" "<<"]]
left[["3" "<"]]
pause[[";" "| |"]]
stop[["<" "[]"]]
record[["=" "O"]]
right[["4" ">"]]
forward[["8" ">>"]]
end[[":" ">>|"]]
up[["5" "^^"]]
down[["6" "v"]]
]data effects/webdings
][
font: make font[style: 'bold]
all[negative? size/y size/y: sizes/line]
font/size: to integer! size/y * 0.6 
all[negative? size/x size/x: 6 + first size-text self]
]
data: off 
action/on-resize self
]
]
table: make rebface[
tip:{USAGE:
table options["Name" left .6 "Age" right .4]data["Bob" 32 "Pete" 45 "Jack" 29]
DESCRIPTION:
Columns and rows of values formatted according to a header definition block.
OPTIONS:
'multi allows multiple rows to be selected at once
'no-dividers hides column dividers
["Title" align width]triplets for each column}
size: 50x25 
color: colors/page 
pane:[]
data:[]
edge: default-edge 
redraw: make function![][]
selected: make function![][]
picked:[]
widths:[]
aligns:[]
cols: none 
rows: make function![][pane/1/rows]
total-width: none 
add-row: func[
row[block!]
/position 
pos[integer!]
][
either pos[
pos: (pos - 1) * cols
][
pos: 1 + length? data
]
insert at data pos row 
redraw
]
remove-row: func[
row[integer! block!]
/local rows removed
][
if integer? row[row: to-block row]
rows: sort/reverse copy row 
repeat n length? rows[
row: max 1 min rows/:n (length? data) / cols 
remove/part skip data (row - 1) * cols cols
]
redraw
]
alter-row: func[
row[integer! block!]
values[block!]
/local rows last-picked
][
last-picked: copy picked 
if integer? row[row: to-block row]
rows: row 
if (length? rows) <> (length? values)[
values: reduce[values]
]
if (length? rows) = (length? values)[
repeat n length? rows[
row: max 1 min rows/:n (length? data) / cols 
change skip data (row - 1) * cols copy/part values/:n cols
]
]
redraw 
unless empty? last-picked[select-row/no-action last-picked]
]
select-row: func[
row[integer! none! block!]
/no-action 
/local rows lines
][
clear picked 
if row[
row: either integer? row[to block! row][sort copy row]
rows: pane/1/rows 
lines: pane/1/lines 
foreach r row[
r: max 1 min rows r 
insert picked r
]
if any[
row/1 < (pane/1/scroll + 1) 
row/1 > (pane/1/scroll + pane/1/lines)
][
pane/1/pane/2/data: 1 / (rows - lines) * ((min (rows - lines + 1) row/1) - 1)
]
unless no-action[action/on-click self]
]
system/view/caret: pane/1/pane/1/text 
system/view/focal-face: pane/1/pane/1 
show self
]
set-columns: func[
options[block!]
/no-show 
/no-dividers 
/local col-offset p last-col dividers?
][
p: self 
if (length? pane) > 2[
remove/part next pane 2 * cols - 1
]
clear widths 
clear aligns 
cols: (length? options) / 3 
p/pane/1/cols: cols 
p/pane/1/data: p/data 
col-offset: total-width: 0 
foreach[column halign width]options[
unless any[string? column word? column][
gui-error "Table expected column name to be a string or word"
]
unless find[left center right]halign[
gui-error {Table expected column align to be one of left, center or right}
]
unless decimal? width[
gui-error "Table expected column width to be a decimal"
]
insert tail aligns halign 
insert tail widths width: to integer! p/size/x * width 
total-width: total-width + width 
insert back tail pane make subface[
offset: as-pair col-offset 0 
size: as-pair width - sizes/cell sizes/line 
text: form column 
color: colors/theme-dark 
col: length? widths 
para: make default-para[margin: as-pair sizes/line + 2 2]
font: make default-font-heading[align: aligns/:col]
feel: make default-feel[
over: make function![face act pos][
face/color: either act[colors/theme-light][colors/theme-dark]
show face
]
engage: make function![face act event /local arrow][
if act = 'down[
arrow: last parent-face/pane 
unless arrow/col = col[
arrow/col: col 
arrow/asc: none 
arrow/offset/x: offset/x + size/x - (sizes/cell * 3)
]
arrow/action arrow
]
]
]
]
col-offset: col-offset + width 
if cols > length? widths[
insert back tail pane make subface[
offset: as-pair col-offset - sizes/cell 0 
size: as-pair 2 either no-dividers[sizes/line][p/size/y]
color: colors/outline-dark 
span: unless no-dividers[all[p/span find p/span #H #H]]
col-1: length? widths 
col-2: 1 + length? widths 
feel: make default-feel[
over: make function![face act pos][
color: either act[colors/state-dark][colors/outline-dark]
show face
]
engage: make function![face act event /local delta arrow][
switch/default act[
down[data: event/offset/x]
up[data: none feel/over face false 0x0]
alt-up[data: none feel/over face false 0x0]
][
if all[
data 
event/type = 'move 
event/offset/x <> data
][
delta: event/offset/x - data 
delta: either positive? delta[
min delta parent-face/pane/(col-2 * 2)/size/x - (sizes/line * 2)
][
max delta negate parent-face/pane/(col-1 * 2)/size/x - (sizes/line * 2)
]
unless zero? delta[
arrow: last parent-face/pane 
if arrow/col = col-1[arrow/offset/x: arrow/offset/x + delta]
offset/x: offset/x + delta 
widths/:col-1: widths/:col-1 + delta 
widths/:col-2: widths/:col-2 - delta 
parent-face/pane/(col-1 * 2)/size/x: widths/:col-1 - sizes/cell 
parent-face/pane/(col-2 * 2)/offset/x: offset/x + sizes/cell 
either cols = col-2[
parent-face/pane/(col-2 * 2)/size/x: widths/:col-2
][
parent-face/pane/(col-2 * 2)/size/x: widths/:col-2 - sizes/cell
]
show parent-face
]
]
]
]
]
]
]
]
p/options: pane/1/options 
last-col: first back back tail pane 
last-col/size/x: last-col/size/x + sizes/cell + size/x - total-width 
if negative? last-col/size/x[
gui-error "Table column widths are too large"
]
widths/:cols: widths/:cols + size/x - total-width 
if all[span find span #W][
last-col/span: #W
]
pane/1/init 
unless no-show[
show self
]
]
rebind: make function![][color: colors/page]
init: make function![/local p opts dividers?][
opts:[table]
if 'multi = first options[remove options insert tail opts 'multi]
dividers?: either 'no-dividers = first options[remove options false][true]
if 'multi = first options[remove options insert tail opts 'multi]
unless integer? cols: divide length? options 3[
gui-error "Table has an invalid options block"
]
if all[not empty? data decimal? divide length? data cols][
gui-error "Table has an invalid data block"
]
p: self 
insert tail pane make face-iterator[
offset: as-pair 0 sizes/line 
size: p/size - as-pair 0 sizes/line 
span: either p/span[copy p/span][none]
data: p/data 
cols: p/cols 
widths: p/widths 
aligns: p/aligns 
options: opts 
picked: p/picked 
action: get in p/action 'on-click 
alt-action: get in p/action 'on-alt-click 
dbl-action: get in p/action 'on-dbl-click
]
insert tail pane make subface[
offset: as-pair negate sizes/line sizes/cell 
size: as-pair sizes/cell * 3 sizes/cell * 3 
effect:[arrow colors/text rotate 0]
cols: p/cols 
col: none 
asc: true 
feel: make default-feel[
engage: make function![face act event][
all[act = 'down face/action face]
]
]
action: make function![face /local last-selected][
asc: either none? asc[true][complement asc]
effect/rotate: either asc[0][180]
last-selected: selected 
either asc[
sort/skip/compare parent-face/data cols col
][
sort/skip/compare/reverse parent-face/data cols col
]
all[
last-selected 
select-row/no-action (((index? find parent-face/data last-selected) - 1) / cols) + 1
]
show parent-face
]
]
either dividers?[set-columns/no-show options][set-columns/no-show/no-dividers options]
redraw: get in pane/1 'redraw 
selected: get in pane/1 'selected 
feel: make default-feel[
redraw: make function![face act pos /local total arrow][
if act = 'show[
total: 0 
foreach width widths[total: total + width]
widths/:cols: widths/:cols + size/x - total 
arrow: last pane 
if arrow/col = cols[arrow/offset/x: size/x + sizes/cell - sizes/line]
]
]
]
]
]
tab-panel: make rebface[
tip:{USAGE:
tab-panel data["A"[field]"B"[field]"C"[field]]
tab-panel data["1"[field]action[face/color: red]"2"[field]]
DESCRIPTION:
A panel with a set of tabs.
Each tab spec may be preceded by an action block spec.
OPTIONS:
'action do action of initial tab (if any)
[tab n]where n specifies tab to initially open with (default 1)
no-tabs do not display tabs (overlay mode)}
size: -1x-1 
pane: copy[]
tabs: 0 
selected: make function![][
either find options 'no-tabs[data][pane/(tabs + data)/text]
]
select-tab: make function![num[integer!]][
if any[num < 1 num > tabs][exit]
pane/:data/show?: false 
edit/unfocus 
either find options 'no-tabs[
pane/(data: num)/show?: true
][
pane/(tabs + data)/color: colors/theme-dark 
pane/(tabs + data)/font/color: colors/page 
pane/(data: num)/show?: true 
pane/(tabs + data)/color: colors/page 
pane/(tabs + data)/font/color: colors/text
]
pane/(data)/action pane/:data 
show self
]
replace-tab: make function![num[integer!]block[block!]/title text[string!]][
pane/:num: layout/only block 
pane/:num/offset: as-pair 0 either find options 'no-tabs[0][sizes/line]
pane/:num/color: colors/page 
pane/:num/edge: outline-edge 
all[title pane/(tabs + num)/text: text]
if data <> num[pane/:num/show?: false]
show self
]
init: make function![/local tab tab-offset trigger][
tab-offset: 0x0 
foreach[title spec]data[
either title = 'action[
trigger: spec
][
tabs: tabs + 1 
tab: layout/only spec 
tab/offset/y: either find options 'no-tabs[0][sizes/line]
tab/color: colors/page 
tab/edge: outline-edge 
tab/show?: false 
tab/span: #LV 
tab/action: either trigger[make function![face /local var]trigger][none]
insert at pane tabs tab 
unless find options 'no-tabs[
insert tail pane make subface[
offset: tab-offset 
size: as-pair 1 sizes/line + 1 
text: title 
effect: reduce['round colors/outline-light effects/radius sizes/edge]
data: tabs 
color: colors/theme-dark 
font: make default-font-heading[color: colors/page]
para: default-para 
feel: make default-feel[
over: make function![face act pos][
face/color: either act[colors/theme-light][
either face/data = face/parent-face/data[colors/page][colors/theme-dark]
]
show face
]
engage: make function![face act event /local p][
all[find[down alt-down]act face/parent-face/select-tab face/data]
]
]
]
tab: last pane 
tab/size/x: sizes/line + first size-text tab 
tab-offset/x: tab-offset/x + tab/size/x + 2
]
trigger: none
]
]
all[
negative? size/x 
repeat i tabs[size/x: max size/x pane/:i/size/x]
]
all[
negative? size/y 
repeat i tabs[size/y: max size/y pane/:i/size/y]
size/y: size/y + either find options 'no-tabs[0][sizes/line]
]
repeat i tabs[
all[span find span #H insert pane/:i/span #H]
all[span find span #W insert pane/:i/span #W]
]
pane/(data: any[select options 'tab 1])/show?: true 
unless find options 'no-tabs[select-tab data]
all[find options 'action pane/(data)/action pane/:data]
]
]
text: make heading[
tip:{USAGE:
text "A text string."
text "Blue text" text-color blue
text "Bold text" bold
text "Italic text" italic
text "Underline text" underline
DESCRIPTION:
Normal text.}
font: default-font
]
text-list: make rebface[
tip:{USAGE:
text-list data["One" "Two"]
text-list data ctx-rebgui/locale*/colors
text-list data[1 2][print face/selected]
DESCRIPTION:
A single column list with a scroller.
OPTIONS:
'multi allows multiple rows to be selected at once}
size: 50x25 
color: colors/page 
data:[]
edge: outline-edge 
redraw: make function![][]
selected: make function![][]
picked:[]
rows: make function![][pane/rows]
select-row: make function![
row[integer! none! block!]
/no-action 
/local rows lines
][
clear picked 
if row[
row: either integer? row[to block! row][sort copy row]
rows: pane/rows 
lines: pane/lines 
foreach r row[
r: max 1 min rows r 
insert picked r
]
unless no-action[action/on-click self]
]
show self
]
rebind: make function![][color: colors/page]
init: make function![/local p][
p: self 
pane: make face-iterator[
size: p/size 
span: either p/span[copy p/span][none]
data: p/data 
options: p/options 
picked: p/picked 
action: get in p/action 'on-click 
alt-action: get in p/action 'on-alt-click 
dbl-action: get in p/action 'on-dbl-click
]
pane/init 
redraw: get in pane 'redraw 
selected: get in pane 'selected
]
]
title-group: make rebface[
tip:{USAGE:
title-group %images/setup.png data "Title" "Body"
DESCRIPTION:
A title and text with an optional image to the left.
If an image is specified then height is set to image height.}
font: default-font-top 
rebind: make function![][
font/name: effects/font 
font/size: sizes/font
]
init: make function![/local p indent][
indent: either image[size/y: image/size/y image/size/x + sizes/line][sizes/line]
p: self 
pane: make subface[
offset: as-pair indent sizes/line 
size: as-pair p/size/x - indent - sizes/line 10000 
text: p/data 
font: make default-font-bold[size: to integer! sizes/font / 0.75]
para: default-para-wrap
]
pane/size: 5x5 + size-text pane 
para: make default-para-wrap compose[
origin: (as-pair indent p/pane/size/y + sizes/line + sizes/line) 
margin: (as-pair sizes/line 0)
]
all[not image negative? size/y size/y: 10000 size/y: para/origin/y + second size-text self]
data: none
]
]
tool-bar: make rebface[
tip:{USAGE:
tool-bar silver data["Open" %images/document-open.png[request-file]pad 2 none "Save" %images/document-save.png[]]
DESCRIPTION:
An iconic toolbar. Height is set to 30 pixels.
[pad n none]sequence works as per 'pad in the display function.}
size: 100x-1 
pane:[]
color: colors/outline-light 
rebind: make function![][color: colors/outline-light]
init: make function![/local icon-offset][
size/y: 30 
icon-offset: 2x2 
foreach[txt icon spec]data[
either string? txt[
insert tail pane make subface[
offset: icon-offset 
size: 22x22 
text: "" 
image: any[
if word? icon[get icon]
if file? icon[load icon]
icon
]
tip: txt 
feel: make default-feel[
over: make function![face act pos][
face/color: either act[colors/state-light][none]
show face
]
engage: make function![face act event][
do select[
down[face/action face]
up[face/feel/over face false none]
away[face/feel/over face false none]
]act
]
]
action: make function![face /local var]spec
]
icon-offset: icon-offset + 24x0
][
icon-offset/x: icon * sizes/cell + icon-offset/x
]
]
data: none
]
]
tooltip: make rebface[
tip:{USAGE:
tooltip "Some text."
DESCRIPTION:
Tooltip text.}
size: -1x-1 
effect:[draw[pen colors/outline-dark line-width sizes/edge fill-pen yello box 0x0 0x0 effects/radius]]
font: default-font 
para: make default-para[origin: 4x4 margin: 4x4]
rate: 2 
init: make function![][
either all[negative? size/x negative? size/y][
size: 10000x10000 
size: 8 + size-text self
][
all[negative? size/x para: default-para-wrap size/x: 10000 size/x: 8 + first size-text self]
all[negative? size/y para: default-para-wrap size/y: 10000 size/y: 8 + second size-text self]
]
poke effect/draw 9 size - 1x1
]
]
tree: make rebface[
tip:{USAGE:
tree data["Pets"["Cat" "Dog"]"Numbers"[1 2 3]]
DESCRIPTION:
Values arranged in a collapsible hierarchy.
OPTIONS:
'expand starts with all nodes expanded
'resize change face/size as tree is expanded / collapsed}
size: 50x25 
color: colors/page 
pane:[]
data:[]
edge: outline-edge 
chain: 
pos: 
expand?: 
p: 
old-face: none 
width: 
height: 0 
show-node: make function![items /no-expand][
foreach item items[
either block? item[
either expand?[show-node item][show-node/no-expand item]
][
expand?: either no-expand[
pane/1/offset/y: negate sizes/line 
false
][
pane/1/offset/y: pos 
pos: pos + sizes/line 
if find options 'resize[
height: height + sizes/line 
width: max width pane/1/offset/x + pane/1/size/x
]
either pane/1/expand?[true][false]
]
pane: next pane
]
]
]
show-tree: make function![][
pos: height: width: 0 
show-node data 
pane: head pane 
if find options 'resize[
size: as-pair width height 
all[parent-face parent-face/action/on-resize/child parent-face]
]
show self
]
build-tree: make function![items /local last-item][
foreach item items[
either block? item[
last-item: last pane 
last-item/pane/effect/rotate: either find options 'expand[last-item/expand?: true 180][last-item/expand?: false 90]
insert tail chain last last-item/data 
pos: pos + sizes/line 
build-tree item 
pos: pos - sizes/line 
remove back tail chain
][
insert tail pane make subface[
offset: as-pair pos 0 
size: as-pair sizes/line + 4 + first size-text make default-text[text: form item]sizes/line 
text: form item 
data: compose[(chain) (item)]
span: all[p/span find p/span #W #W]
pane: make subface[
size: as-pair sizes/line sizes/line 
effect: copy[arrow rotate 90]
]
font: make default-font[]
para: default-para-indented 
feel: make default-feel[
engage: make function![face act event][
if act = 'down[
all[old-face old-face/font/color: colors/text set-color old-face none]
unless none? face/expand?[
face/pane/effect/rotate: either face/expand?[face/expand?: false 90][face/expand?: true 180]
show-tree
]
face/font/color: colors/page 
set-color face colors/state-light 
old-face: face 
face/parent-face/action/on-click face
]
]
]
expand?: none
]
]
]
]
rebind: make function![][color: colors/page]
init: make function![][
p: self 
pos: 0 
chain: copy[]
build-tree data 
show-tree
]
]
]
layout: make function![
spec[block!]"Block of widgets, attributes and keywords" 
/only "Do not change face offset" 
/local 
view-face 
here 
margin-size indent-width xy gap-size max-width max-height last-widget widget-face arg append-widget left-to-right? 
after-count after-limit 
word 
widget 
button-size 
field-size 
label-size 
text-size 
action-alt-click 
action-away 
action-click 
action-dbl-click 
action-edit 
action-focus 
action-key 
action-over 
action-resize 
action-scroll 
action-unfocus 
attribute-size 
attribute-span 
attribute-text 
attribute-text-color 
attribute-text-style 
attribute-color 
attribute-image 
attribute-effect 
attribute-data 
attribute-tip 
attribute-edge 
attribute-font 
attribute-para 
attribute-feel 
attribute-rate 
attribute-show? 
attribute-options 
attribute-keycode
][
margin-size: xy: sizes/cell * as-pair sizes/margin sizes/margin 
gap-size: sizes/cell * as-pair sizes/gap sizes/gap 
indent-width: 0 
max-width: xy/x 
max-height: xy/y 
left-to-right?: true 
after-count: 1 
after-limit: 10000 
view-face: make rebface[
pane: copy[]
color: colors/page 
effect: all[not only effects/window]
options: copy[activate-on-show]
keycodes: copy[]
]
word: 
widget: 
button-size: 
field-size: 
label-size: 
text-size: 
action-alt-click: 
action-away: 
action-click: 
action-dbl-click: 
action-edit: 
action-focus: 
action-key: 
action-over: 
action-resize: 
action-scroll: 
action-unfocus: 
attribute-size: 
attribute-span: 
attribute-text: 
attribute-text-color: 
attribute-text-style: 
attribute-color: 
attribute-image: 
attribute-effect: 
attribute-data: 
attribute-tip: 
attribute-edge: 
attribute-font: 
attribute-para: 
attribute-feel: 
attribute-rate: 
attribute-show?: 
attribute-options: 
attribute-keycode: none 
append-widget: make function![][
if widget[
insert tail view-face/pane make widgets/:widget[
type: either widgets/:widget/type = 'face[widget][widgets/:widget/type]
offset: xy 
size: sizes/cell * any[
if attribute-size[either pair? attribute-size[attribute-size][as-pair attribute-size size/y]]
if widget = 'bar[as-pair max-width - margin-size/x / sizes/cell size/y]
if all[button-size widget = 'button][either pair? button-size[button-size][as-pair button-size size/y]]
if all[field-size widget = 'field][either pair? field-size[field-size][as-pair field-size size/y]]
if all[label-size widget = 'label][either pair? label-size[label-size][as-pair label-size size/y]]
if all[text-size widget = 'text][either pair? text-size[text-size][as-pair text-size size/y]]
size
]
span: any[attribute-span span]
text: any[attribute-text text][text: copy text]
effect: any[attribute-effect effect]
data: either any[attribute-data = false data = false][false][any[attribute-data data]]
rate: any[attribute-rate rate]
show?: either none? attribute-show?[show?][attribute-show?]
options: copy any[attribute-options options]
color: any[attribute-color color]
image: any[attribute-image image]
text: translate text 
data: translate data 
tip: attribute-tip 
if attribute-text-color[
font: make any[font widgets/default-font][color: attribute-text-color]
]
if attribute-text-style[
font: make any[font widgets/default-font][style: attribute-text-style]
]
if attribute-edge[edge: make any[edge widgets/default-edge]attribute-edge]
if attribute-font[font: make any[font widgets/default-font]attribute-font]
if attribute-para[para: make any[para widgets/default-para]attribute-para]
if attribute-feel[feel: make feel attribute-feel]
action: make action[]
all[action-alt-click action/on-alt-click: make function![face /local var]action-alt-click]
all[action-away action/on-away: make function![face /local var]action-away]
all[action-click action/on-click: make function![face /local var]action-click]
all[action-dbl-click action/on-dbl-click: make function![face /local var]action-dbl-click]
all[action-edit action/on-edit: make function![face /local var]action-edit]
all[action-focus action/on-focus: make function![face /local var]action-focus]
all[action-key action/on-key: make function![face event /local var]action-key]
all[action-over action/on-over: make function![face /local var]action-over]
all[action-resize action/on-resize: make function![face /local var]action-resize]
all[action-scroll action/on-scroll: make function![face scroll /page /local var]action-scroll]
all[action-unfocus action/on-unfocus: make function![face /local var]action-unfocus]
if any[
get in action 'on-alt-click 
get in action 'on-click 
get in action 'on-dbl-click 
get in action 'on-edit 
get in action 'on-key 
get in action 'on-scroll
][
unless get in feel 'engage[
feel: make feel[
engage: make function![face act event][
case[
event/double-click[face/action/on-dbl-click face]
act = 'up[face/action/on-click face]
act = 'alt-up[face/action/on-alt-click face]
act = 'key[
face/action/on-key face event 
face/action/on-edit face
]
act = 'scroll-line[face/action/on-scroll face event/offset]
act = 'scroll-page[face/action/on-scroll/page face event/offset]
]
]
]
]
]
if any[
get in action 'on-away 
get in action 'on-over
][
unless get in feel 'over[
feel: make feel[
over: make function![face into pos][
either into[face/action/on-over face][face/action/on-away face]
]
]
]
]
]
last-widget: last view-face/pane 
if attribute-keycode[
insert tail view-face/keycodes reduce[attribute-keycode last-widget]
]
last-widget/init 
last-widget/init: none 
unless left-to-right?[
last-widget/offset/x: last-widget/offset/x - last-widget/size/x
]
xy: last-widget/offset 
max-height: max max-height xy/y + last-widget/size/y 
if left-to-right?[
xy/x: xy/x + last-widget/size/x 
max-width: max max-width xy/x
]
after-count: either after-count < after-limit[
xy/x: xy/x + either left-to-right?[gap-size/x][negate gap-size/x]
after-count + 1
][
xy: as-pair margin-size/x + indent-width max-height + gap-size/y 
after-count: 1
]
if :word[set :word last-widget]
word: 
widget: 
action-alt-click: 
action-away: 
action-click: 
action-dbl-click: 
action-edit: 
action-focus: 
action-key: 
action-over: 
action-resize: 
action-scroll: 
action-unfocus: 
attribute-size: 
attribute-span: 
attribute-text: 
attribute-text-color: 
attribute-text-style: 
attribute-color: 
attribute-image: 
attribute-effect: 
attribute-data: 
attribute-tip: 
attribute-edge: 
attribute-font: 
attribute-para: 
attribute-feel: 
attribute-rate: 
attribute-show?: 
attribute-options: 
attribute-keycode: none
]
]
parse reduce/only spec words[
any[
opt[here: set arg paren! (here/1: do arg) :here][
'return (
append-widget 
xy: as-pair margin-size/x + indent-width max-height + gap-size/y 
left-to-right?: true 
after-limit: 10000
) 
| 'reverse (
append-widget 
xy: as-pair max-width max-height + gap-size/y 
left-to-right?: false 
after-limit: 10000
) 
| 'after set arg integer! (
if widget[
append-widget 
xy: as-pair margin-size/x + indent-width max-height + gap-size/y
]
after-count: 1 
after-limit: arg
) 
| 'button-size[set arg integer! | set arg pair! | | set arg none!](button-size: arg) 
| 'field-size[set arg integer! | set arg pair! | | set arg none!](field-size: arg) 
| 'label-size[set arg integer! | set arg pair! | | set arg none!](label-size: arg) 
| 'text-size[set arg integer! | set arg pair! | | set arg none!](text-size: arg) 
| 'pad[set arg integer! | set arg paren!](
append-widget 
all[paren? arg arg: do arg]
arg: either left-to-right?[arg * sizes/cell][negate arg * sizes/cell]
either after-count = 1[xy/y: xy/y + arg][xy/x: xy/x + arg]
) 
| 'do set arg block! (view-face/init: make function![face /local var]arg) 
| 'margin set arg pair! (append-widget margin-size: xy: arg * sizes/cell) 
| 'indent set arg integer! (
append-widget 
indent-width: arg * sizes/cell 
xy/x: margin-size/x + indent-width
) 
| 'space set arg pair! (append-widget gap-size: arg * sizes/cell) 
| 'tight (append-widget margin-size: xy: gap-size: 0x0) 
| 'at set arg pair! (append-widget xy: arg * sizes/cell + margin-size after-limit: 10000) 
| 'effect[set arg word! | set arg block!](attribute-effect: arg) 
| 'options set arg block! (attribute-options: arg) 
| 'data set arg any-type! (attribute-data: either paren? arg[do arg][arg]) 
| 'edge set arg block! (attribute-edge: arg) 
| 'font set arg block! (attribute-font: arg) 
| 'para set arg block! (attribute-para: arg) 
| 'feel set arg block! (attribute-feel: arg) 
| 'on set arg block! (
action-click: any[action-click select arg 'click]
action-alt-click: any[action-alt-click select arg 'alt-click]
action-dbl-click: any[action-dbl-click select arg 'dbl-click]
action-away: select arg 'away 
action-edit: select arg 'edit 
action-focus: select arg 'focus 
action-key: select arg 'key 
action-over: select arg 'over 
action-resize: select arg 'resize 
action-scroll: select arg 'scroll 
action-unfocus: select arg 'unfocus
) 
| 'on-alt-click set arg block! (action-alt-click: arg) 
| 'on-away set arg block! (action-away: arg) 
| 'on-click set arg block! (action-click: arg) 
| 'on-dbl-click set arg block! (action-dbl-click: arg) 
| 'on-edit set arg block! (action-edit: arg) 
| 'on-focus set arg block! (action-focus: arg) 
| 'on-key set arg block! (action-key: arg) 
| 'on-over set arg block! (action-over: arg) 
| 'on-resize set arg block! (action-resize: arg) 
| 'on-scroll set arg block! (action-scroll: arg) 
| 'on-unfocus set arg block! (action-unfocus: arg) 
| 'rate[set arg integer! | set arg time!](attribute-rate: arg) 
| 'tip set arg string! (attribute-tip: arg) 
| 'text-color set arg tuple! (attribute-text-color: arg) 
| 'bold (attribute-text-style: 'bold) 
| 'italic (attribute-text-style: 'italic) 
| 'underline (attribute-text-style: 'underline) 
|[set arg integer! | set arg pair!](attribute-size: arg) 
| set arg issue! (attribute-span: sort arg) 
| set arg string! (attribute-text: arg) 
|[set arg tuple! | set arg none!](attribute-color: arg) 
| set arg image! (attribute-image: arg) 
| set arg file! (attribute-image: load arg) 
| set arg url! (attribute-data: arg) 
| set arg block! (
case[
none? action-click[action-click: arg]
none? action-alt-click[action-alt-click: arg]
none? action-dbl-click[action-dbl-click: arg]
]
) 
| set arg logic! (attribute-show?: arg) 
| set arg char! (attribute-keycode: arg) 
| set arg set-word! (append-widget word: :arg) 
| set arg word! (append-widget widget: arg)
]
]
]
append-widget 
view-face/init view-face 
view-face/init: none 
view-face/size: margin-size + as-pair max-width max-height 
unless only[
foreach face view-face/pane[span-size face view-face/size margin-size]
all[
zero? view-face/offset 
view-face/offset: max 0x0 view*/screen-face/size - view-face/size / 2
]
]
view-face
]
requestors: make object![
color-spec: copy[text-size 15 margin 2x2 space 1x1]
do make function![/local bx r g b i][
bx: 4 + length? locale*/colors 
r: bx - 1 
g: bx + 2 
b: bx + 4 
i: 1 
foreach color locale*/colors[
insert tail color-spec compose/deep[
box 5x5 (color)[face/parent-face/pane/(bx)/action/on-click face]edge[]feel[
over: make function![face act pos /local p][
all[
act 
p: face/parent-face/pane 
p/(bx)/color: face/color 
p/(r)/text: form face/color/1 
p/(g)/text: form face/color/2 
p/(b)/text: form face/color/3 
set-title face/parent-face (uppercase/part form color 1)
]
]
]
]
all[zero? i // 8 insert tail color-spec 'return]
i: i + 1
]
all['return <> last color-spec insert tail color-spec 'return]
]
read-dir: make function![path /local blk dirs][
blk: copy[]
if dirs: attempt[read path][
foreach dir remove-each file sort dirs[any[#"/" <> last file #"." = first file]][
insert tail blk head remove back tail dir 
insert/only tail blk read-dir dirize path/:dir 
if empty? last blk[remove back tail blk]
]
]
blk
]
alert: make function![
"Prompts to acknowledge a message." 
message[string!]"Message text" 
/title text[string!]"Title text"
][
display/dialog any[text "Alert"][
text 60x-1 message 
return 
bar 
reverse 
button "OK"[hide-popup]
do[set-focus last face/pane]
]
]
question: make function![
"Requests a Yes/No answer to a question." 
message[string!]"Message text" 
/title text[string!]"Title text" 
/local result
][
result: none 
display/dialog any[text "Question"][
text 50x-1 message 
return 
bar 
reverse 
button #"N" "No"[result: false hide-popup]
button #"Y" "Yes"[result: true hide-popup]
do[set-focus last face/pane]
]
result
]
request-char: make function![
"Requests a character." 
/title text[string!]"Title text" 
/font name[string!]"Font to use" 
/local result char-spec size
][
result: none 
char-spec: copy[text-size 7x7 tight]
name: any[name either effects/webdings["webdings"][effects/font]]
size: to integer! sizes/font * 1.5 
repeat i 256[
if i > 32[
insert tail char-spec compose/deep[
text (colors/page) (form to char! i - 1) font[name: (name) size: (size) align: 'center][result: to char! face/text hide-popup]on[
over[select-face face]
away[deselect-face face]
]
]
if zero? remainder i 16[insert tail char-spec 'return]
]
]
display/dialog any[text "Character Map"]char-spec 
result
]
request-color: make function![
"Requests a color." 
/title text[string!]"Title text" 
/color clr[tuple!]"Default color" 
/allow-none "Allow none as a value" 
/local result bx btn
][
clr: any[clr colors/text]
result: false 
display/dialog any[text "Color Palette"]compose/deep[
(color-spec) 
return bar return 
text "Red" spinner 15 data (clr/1) options[0 255 1][bx/color/1: face/data show bx]
bx: box 5x5 #L clr edge[][result: bx/color hide-popup]
return 
text "Green" spinner 15 data (clr/2) options[0 255 1][bx/color/2: face/data show bx]
return 
text "Blue" spinner 15 data (clr/3) options[0 255 1][bx/color/3: face/data show bx]
return 
bar 
reverse 
button "OK"[result: bx/color hide-popup]
btn: button "None" false[result: none hide-popup]
do[
all[allow-none btn/show?: true]
bx/size/y: sizes/cell * 17
]
]
result
]
request-date: make function![
"Requests a date." 
/title text[string!]"Title text" 
/date dt[date!]"Initial date to show (default is today)" 
/local result
][
result: none 
display/dialog any[text "Calender"][
tight 
calendar data (any[dt now/date])[result: face/data hide-popup]
]
result
]
request-dir: make function![
"Requests a directory." 
/title text[string!]"Title text" 
/path dir[file!]"Set starting directory" 
/expand "Start with all nodes expanded" 
/local result txt opts
][
if any[none? dir not exists? dir][dir: clean-path %.]
dir: dirize dir 
opts: either expand[[resize expand]][[resize]]
result: none 
display/dialog any[text "Select a Directory:"][
after 1 
txt: text 100 (form to-local-file dir) 
scroll-panel #HW 100x50 data[
tree 100x50 options opts data (read-dir dir)[
var: dir 
foreach item face/data[var: rejoin[var item #"/"]]
set-text txt to-local-file var
]
]
bar #WY 
reverse 
button #XY "Open"[result: dirize to-rebol-file txt/text hide-popup]
]
result
]
request-file: make function![
{Requests a file using a popup list of files and directories.} 
/title text[string!]"Title text" 
/file path[file! block!]"Default file name or block of file names" 
/filter name[string!]mask[string!]
/only "Return only a single file, not a block" 
/save "Request file for saving, otherwise loading" 
/local result blk
][
text: any[text either save["Save"]["Open"]]
if file[
set[path file]split-path clean-path path
]
if any[none? path not exists? path][path: clean-path %.]
file: either any[none? file not exists? path/:file][copy[]][compose[(file)]]
if local-request-file result: reduce[
any[select locale*/words text text]
"" 
path 
file 
compose[(any[select locale*/words name name select locale*/words "All" "All"])]
compose/deep[[(any[mask "*"])]]
logic? only 
logic? save
][
either only[join result/3 first result/4][
blk: copy[]
foreach file result/4[insert tail blk join result/3 file]
blk
]
]
]
request-font: make function![
"Requests a font name, returning a string." 
/title text[string!]"Title text" 
/style "Adds a style selector (returns font! object!)" 
/size "Adds a size selector (returns font! object!)" 
/align "Adds an alignment selector (returns font! object!)" 
/local result f blk
][
result: none 
blk: copy[
group-box "Font" data[
margin 2x2 
text-list (as-pair 50 30 + sizes/gap) data effects/fonts[f/font/name: f/text: copy face/selected show f]
]
]
all[
style 
insert tail blk[
group-box 30 "Style" data[
margin 2x2 
radio-group data[1 "Normal" "Bold" "Italic" "Underline"][
f/font/style: pick reduce[none 'bold 'italic 'underline]face/picked 
show f
]
]
]
]
if size[
all[style insert tail blk reduce['at as-pair 54 + sizes/gap 25 + sizes/gap]]
insert tail blk[
group-box 30 "Size" data[
margin 2x2 
spinner #L options[8 36 2]data 24[f/font/size: face/data show f]
]
]
all[style align insert tail blk reduce['at as-pair 86 + sizes/gap 0]]
]
all[
align 
insert tail blk[
group-box 30 "Align" data[
margin 2x2 
radio-group data[2 "left" "center" "right"][
f/font/align: to word! face/selected 
show f
]
return 
radio-group data[2 "top" "middle" "bottom"][
f/font/valign: to word! face/selected 
show f
]
]
]
]
insert tail blk[
return 
f: field #L effects/font 20x20 edge[size: 0x0]font[size: 24 align: 'center]
return 
bar 
reverse 
button "Cancel"[hide-popup]
button "OK"[result: either any[style size align][f/font][f/font/name]hide-popup]
]
display/dialog any[text "Available Fonts"]blk 
result
]
request-menu: make function![
"Requests a menu choice." 
face[object!]"Widget to appear in relation to" 
menu[block!]"Label/Action block pairs" 
/width x[integer!]"Width in pixels (defaults to 25 units)" 
/offset xy[pair!]"Offset relative to widget (defaults to top right)" 
/local result
][
result: none 
do select menu result: widgets/choose face any[x 25 * sizes/cell]any[xy face/offset + as-pair face/size/x 0]extract menu 2 
result
]
request-password: make function![
"Requests a username and password." 
/title text[string!]"Title text" 
/user username[string!]"Default username" 
/pass password[string!]"Default password" 
/check rules[block!]{Rules to test password against (fails if string returned)} 
/only "Password only" 
/verify "Verify password" 
/local result s blk u p v
][
blk: copy[text-size 20]
all[check rules: make function![text[string!]]rules]
all[not only insert tail blk compose[text "Username:" u: field (any[username ""]) return]]
insert tail blk compose[text "Password:" p: password (any[password ""]) return]
all[verify insert tail blk[text "Verify:" v: password return]]
result: none 
display/dialog any[text "Password"]compose[
(blk) 
bar 
reverse 
button "OK"[
case[
all[not only empty? u/text][
alert "Username must be provided." 
set-focus u
]
all[check string? s: rules p/text][
alert s 
set-focus p
]
all[verify p/text <> v/text][
alert "Please try again." 
set-focus v
]
true[
result: either only[copy p/text][reduce[u/text p/text]]
hide-popup
]
]
]
]
result
]
request-progress: make function![
"Requests a progress dialog for an action block." 
steps[integer!]"Number of iterations" 
block[block!]"Action block" 
/title text[string!]"Title text" 
/local step s p
][
s: 1 / steps 
step: make function![][p/data: p/data + s show p]
display/parent any[text "Loading ..."][
after 1 
label (any[text "Loading ..."]) 
p: progress 
do[face/options:[no-title]]
]
do bind block 'step 
unview
]
request-spellcheck: make function![
"Requests spellcheck on a widget's text." 
face[object!]
/title text[string!]"Title text" 
/anagram "Anagram option" 
/local ignore new next-word word start end txt fld lst a
][
if any[not string? face/text empty? face/text][exit]
ignore: copy[]
new: copy[]
unless exists? %dictionary[make-dir %dictionary]
unless locale*/dict[locale*/dict: make hash! 1000]
next-word: make function![/init][
while[any[init start <> end]][
either init[
start: end: head face/text 
unless find edit/letter first start[
while[all[not tail? start: next start find edit/other first start]][]
]
init: false
][
start: end 
while[all[not tail? start: next start find edit/other first start]][]
]
end: start 
while[all[not tail? end: next end find edit/letter first end]][]
word: copy/part start end 
unless any[
empty? word 
find ignore word 
find new word 
find locale*/dict word
][break]
word: none
]
if all[none? init word][
txt/text: fld/text: word 
show[txt fld]
insert clear lst/data edit/lookup-word word lst/redraw 
view*/focal-face: face 
view*/caret: none 
edit/hilight-text start end 
show face
]
string? word
]
if next-word/init[
view*/caret: none 
edit/hilight-text start end 
show face 
display/dialog any[text rejoin["Spellcheck (" locale*/language ")"]][
label-size 25 
after 2 
label "Original" txt: text 75 word 
label "Word" fld: field 75 word 
label "Suggestions" lst: text-list data (edit/lookup-word word) 75x50[set-text fld face/selected]
bar 
reverse 
button "Close"[
hide-popup
]
button "Add"[
insert tail new fld/text 
unless next-word[hide-popup]
]
button "Replace"[
change/part start fld/text end 
end: skip start length? fld/text 
unless next-word[hide-popup]
]
button "Ignore"[
insert tail ignore word 
unless next-word[hide-popup]
]
a: button "Anagram" false[
either 2 < var: length? fld/text[
face/data: lowercase sort copy fld/text 
clear lst/data 
foreach word locale*/dict[
all[var = length? word face/data = sort copy word insert tail lst/data word]
]
lst/redraw
][alert "Requires a word with at least 3 characters."]
]
do[all[anagram a/show?: true]]
]
set-focus face 
unless empty? new[
insert tail locale*/dict new 
write locale*/dictionary form locale*/dict
]
]
]
request-ui: make function![
"Requests UI changes." 
/title text[string!]"Title text" 
/file name[file!]"Set file to save changes (default is ui.dat)" 
/local result c1 c2 c3 c4 c5 c6 c7 c8 s1 s2 s3 s4 s5 s6 b1 b2 b3 b4 b5 b6 e1 e2 e3 e4 e5 e6 e7 e8
][
result: none 
display/dialog any[text "User Interface"][
tab-panel data[
"Colors"[
group-box "General" data[
text-size 15 
after 2 
text "Page" c1: box 10x5 edge[color: colors/text]colors/page[all[var: request-color/color face/color set-color face var]]
text "Text" c2: box 10x5 edge[color: colors/text]colors/text[all[var: request-color/color face/color set-color face var]]
]
return 
group-box "Theme" data[
text-size 15 
after 2 
text "Light" c3: box 10x5 edge[color: colors/text]colors/theme-light[all[var: request-color/color face/color set-color face var]]
text "Dark" c4: box 10x5 edge[color: colors/text]colors/theme-dark[all[var: request-color/color face/color set-color face var]]
drop-list #L data["Butter" "Orange" "Chocolate" "Chameleon" "Sky Blue" "Plum" "Scarlet Red"][
set-color c3 pick[252.233.79 252.175.62 233.185.110 138.226.52 114.159.207 173.127.168 239.41.41]face/picked 
set-color c4 pick[196.160.0 206.92.0 143.89.2 78.154.6 32.74.135 92.53.102 164.0.0]face/picked
]
]
group-box "State" data[
text-size 15 
after 2 
text "Light" c5: box 10x5 edge[color: colors/text]colors/state-light[all[var: request-color/color face/color set-color face var]]
text "Dark" c6: box 10x5 edge[color: colors/text]colors/state-dark[all[var: request-color/color face/color set-color face var]]
drop-list #L data["Butter" "Orange" "Chocolate" "Chameleon" "Sky Blue" "Plum" "Scarlet Red"][
set-color c5 pick[252.233.79 252.175.62 233.185.110 138.226.52 114.159.207 173.127.168 239.41.41]face/picked 
set-color c6 pick[196.160.0 206.92.0 143.89.2 78.154.6 32.74.135 92.53.102 164.0.0]face/picked
]
]
group-box "Outline" data[
text-size 15 
after 2 
text "Light" c7: box 10x5 edge[color: colors/text]colors/outline-light[all[var: request-color/color face/color set-color face var]]
text "Dark" c8: box 10x5 edge[color: colors/text]colors/outline-dark[all[var: request-color/color face/color set-color face var]]
]
]
"Sizes"[
group-box "Pixels & Points" 60 data[
label-size 15 
after 3 
label "Cell" s1: drop-list 15 (form sizes/cell) data[3 4 5 6 7 8]text "pixels" 
label "Edge" s2: drop-list 15 (form sizes/edge) data[1 2 3]text "pixel(s)" 
label "Font" s3: drop-list 15 (form sizes/font) data[8 9 10 11 12 14 16 18 20 22 24]text "points"
]
return 
group-box "Cells" 60 data[
label-size 15 
after 3 
label "Gap" s4: drop-list 15 (form sizes/gap) data[1 2 3 4]text "cell(s)" 
label "Margin" s5: drop-list 15 (form sizes/margin) data[2 4 6 8]text "cells" 
label "Slider" s6: drop-list 15 (form sizes/slider / sizes/cell) data[2 3 4]text "cells"
]
]
"Behaviors"[
after 1 
group-box "Action" #L data[
label-size 20 
after 2 
label "On enter" b1: field #L (form behaviors/action-on-enter) 
label "On tab" b2: field #L (form behaviors/action-on-tab)
]
group-box "Focus" #L data[
label-size 20 
after 2 
label "Caret" b3: field #L (form behaviors/caret-on-focus) 
label "Hilight" b4: field #L (form behaviors/hilight-on-focus)
]
group-box "Tabbing" #L data[
label-size 20 
after 2 
label "Cyclic" b5: field #L (form behaviors/cyclic) 
label "Tabbable" b6: field #L (form behaviors/tabbed)
]
]
"Effects"[
after 1 
group-box "Window effect(s)" #L data[
e1: field #L (either effects/window[mold/only effects/window][copy ""])
]
group-box "General" #L data[
label-size 20 
label "Font" e2: button 50x5 #L effects/font[all[var: request-font set-text face var]]
return 
label "Fonts" e3: field #L (mold/only effects/fonts) 
return 
label "Radius" e4: spinner 25 options[0 15 1](form effects/radius) text "pixel(s)" 
return 
label "Arrows" e5: radio-group 25x5 data[pick[2 1]effects/arrows-together "Win" "Mac"]
label "Symbols" e6: radio-group 25x5 data[pick[1 2]effects/webdings "On" "Off"]
]
group-box "Delay (in seconds)" #L data[
label-size 20 
label "Splash" e7: spinner 25 (form effects/splash-delay) 
label "Tooltip" e8: spinner 25 options[0 10 1](either none? effects/tooltip-delay["0"][form to integer! effects/tooltip-delay])
]
]
]
reverse 
button "Cancel"[result: none hide-popup]
button "Reset"[
either exists? %ui.dat[
if question {This action will delete your preferences and exit the application, do you wish to proceed?}[
either none? attempt[delete %ui.dat][
alert "Could not delete %ui.dat. File read-only?"
][quit]
]
][result: none hide-popup]
]
button "Save"[
colors/page: c1/color 
colors/text: c2/color 
colors/theme-light: c3/color 
colors/theme-dark: c4/color 
colors/state-light: c5/color 
colors/state-dark: c6/color 
colors/outline-light: c7/color 
colors/outline-dark: c8/color 
sizes/cell: to integer! s1/text 
sizes/edge: to integer! s2/text 
sizes/font: to integer! s3/text 
sizes/gap: to integer! s4/text 
sizes/margin: to integer! s5/text 
sizes/slider: sizes/cell * to integer! s6/text 
sizes/line: sizes/cell * 5 
behaviors/action-on-enter: load/all b1/text 
behaviors/action-on-tab: load/all b2/text 
behaviors/caret-on-focus: load/all b3/text 
behaviors/hilight-on-focus: load/all b4/text 
behaviors/cyclic: load/all b5/text 
behaviors/tabbed: load/all b6/text 
effects/window: either empty? e1/text[none][load/all e1/text]
effects/font: form e2/text 
effects/fonts: load/all e3/text 
effects/radius: e4/data 
effects/arrows-together: either e5/selected = "Mac"[true][false]
effects/webdings: either e6/selected = "On"[true][false]
effects/splash-delay: e7/data 
effects/tooltip-delay: either zero? e8/data[none][to time! e8/data]
widgets/rebind 
save any[name %ui.dat]reduce[colors sizes behaviors effects]
result: true 
hide-popup
]
]
result
]
request-value: make function![
"Requests a value." 
prompt[string!]"Prompt text" 
/title text[string!]"Title text" 
/default value[any-type!]"Default value" 
/type datatype[datatype!]"Return type" 
/local result f b
][
value: form any[value ""]
result: none 
display/dialog any[text "Ask"][
text prompt 
f: field value[b/action/on-click b]
return 
bar 
reverse 
button "Cancel"[hide-popup]
b: button "OK"[
either type[
var: attempt[to datatype f/text]
either var[
result: var 
hide-popup
][alert reform[f/text "is not a valid" join datatype "!"]]
][
result: f/text 
hide-popup
]
]
do[set-focus f]
]
result
]
splash: make function![
{Displays a centered splash screen for one or more seconds.} 
spec[block! file! image!]"The face spec or image to display"
][
spec: either block? spec[make subface spec][
make subface[
image: either file? spec[load spec][spec]
size: image/size
]
]
spec/type: 'splash 
spec/offset: max 0x0 view*/screen-face/size - spec/size / 2 
spec/color: any[spec/color colors/page]
view/new/options spec 'no-title 
wait effects/splash-delay
]
]
foreach word find first requestors 'alert[
either word = 'request-file[
all[
find[2 3]fourth system/version 
value? 'local-request-file 
set to word! word get in requestors word
]
][
set to word! word get in requestors word
]
]
functions: make object![
append-widget: make function![
"Append a custom widget to widgets context." 
spec[block!]"Widget spec" 
/local word
][
all[
find words word: to word! first spec 
gui-error reform[word "is already in use"]
]
widgets: make widgets spec 
all[
find words third spec 
widgets/:word/type: third spec
]
insert tail words word
]
clear-text: make function![
{Clear text attribute of a widget or block of widgets.} 
face[object! block!]
/no-show "Don't show" 
/focus
][
foreach f reduce either object? face[[face]][face][
if string? f/text[
clear f/text 
all[f/type = 'area f/para/scroll: 0x0 f/pane/data: 0]
f/line-list: none
]
]
unless no-show[
either all[focus object? face][set-focus face][show face]
]
]
display: make function![
{Displays widgets in a centered window with a title.} 
title[string!]"Window title" 
spec[block!]"Block of widgets, attributes and keywords" 
/dialog {Displays widgets in a modal popup window with /parent option} 
/maximize "Maximize window" 
/parent "Force parent to be last window (default is first)" 
/position "Use an alternative positioning scheme" 
offset[pair! word! block!]{Offset pair or one or more of 'left 'right 'top 'bottom 'first 'second} 
/min-size "Specify a minimum OS window resize size" 
size[pair!]{Minimum display size (including window border/title)} 
/close "Handle window close event" 
closer[block!]"The close handler block" 
/local tooltip-time tooltip
][
foreach window view*/screen-face/pane[all[title = window/text exit]]
spec: layout spec 
spec/text: title 
if position[
either pair? offset[
spec/offset: max 0x0 offset
][
foreach word compose[(offset)][
if word = 'first[word: either view*/screen-face/size/x > view*/screen-face/size/y['left]['top]]
if word = 'second[word: either view*/screen-face/size/x > view*/screen-face/size/y['right]['bottom]]
do select[
left[spec/offset/x: max 0 view*/screen-face/size/x / 2 - spec/size/x / 2]
right[spec/offset/x: max 0 view*/screen-face/size/x / 2 - spec/size/x / 2 + (view*/screen-face/size/x / 2)]
top[spec/offset/y: max 0 view*/screen-face/size/y / 2 - spec/size/y / 2]
bottom[spec/offset/y: max 0 view*/screen-face/size/y / 2 - spec/size/y / 2 + (view*/screen-face/size/y / 2)]
]word
]
]
]
unless empty? view*/screen-face/pane[
either view*/screen-face/pane/1/type <> 'splash[
insert tail spec/options reduce['parent either any[dialog parent][last view*/screen-face/pane][first view*/screen-face/pane]]
][unview]
]
either any[min-size maximize][
insert tail spec/options 'resize 
all[maximize spec/changes:[maximize]]
][
foreach sub-face spec/pane[
all[
sub-face/span 
not empty? intersect sub-face/span #HWXY 
insert tail spec/options 'resize 
break
]
]
]
all[
find spec/options 'resize 
insert tail spec/options reduce['min-size either min-size[size][spec/size + view*/title-size + view*/resize-border]]
]
either dialog[
spec/type: 'popup 
spec/feel: system/words/face/feel 
show-popup spec
][view/new spec]
all[close spec/action: make function![face /local var]closer]
spec/feel: make any[spec/feel widgets/default-feel][
orig-size: spec/size 
mouse-offset: 0x0 
if all[not dialog effects/tooltip-delay][
tooltip-time: now/time/precise 
insert tail spec/pane tooltip: make widgets/tooltip[type: 'tooltip offset: -10000x-10000 tip: none]
]
detect: make function![face event /local f][
if none? tooltip[
f: last face/pane 
if f/type = 'tooltip[
tooltip-time: now/time/precise 
tooltip: last face/pane
]
]
if all[
face/type <> 'popup 
effects/tooltip-delay 
tooltip/data 
event/type <> 'time 
mouse-offset <> event/offset
][
tooltip-time: now/time/precise 
tooltip/data: false 
tooltip/offset: -10000x-10000 
show tooltip
]
if all[
face/type <> 'popup 
effects/tooltip-delay 
not tooltip/data 
(now/time/precise - tooltip-time) > effects/tooltip-delay
][
f: event/face 
while[f: find-face event/offset f][
if all[f/type <> 'face f/tip][
tooltip/text: f/tip 
tooltip/init 
tooltip/size: 10000x10000 
tooltip/size: 8 + size-text tooltip 
poke tooltip/effect/draw 9 tooltip/size - 1x1 
tooltip/offset: min event/face/size - tooltip/size - 2 max 2x2 event/offset - as-pair 0 tooltip/size/y 
tooltip/data: true 
if all[
tooltip/parent-face 
block? tooltip/parent-face/pane
][
remove find tooltip/parent-face/pane tooltip
]
insert tail event/face/pane tooltip 
show tooltip 
break
]
if function? get in f 'pane[break]
unless f: f/pane[break]
]
]
if find[down up alt-down alt-up]event/type[
if all[
view*/focal-face 
not within? event/offset win-offset? view*/focal-face view*/focal-face/size
][unless edit/unfocus[exit]]
]
do select[
key[
case[
event/key = #"^-"[
if all[view*/focal-face viewed? view*/focal-face][
f: either event/shift[edit/back-field view*/focal-face][edit/next-field view*/focal-face]
if find behaviors/action-on-tab view*/focal-face/type[
view*/focal-face/action/on-click view*/focal-face
]
if :f[set-focus f]
exit
]
]
find[#" " #"^M"]event/key[
if all[view*/focal-face view*/focal-face/type = 'button][
view*/focal-face/action/on-click view*/focal-face 
exit
]
]
all[
find[f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12]event/key 
get in on-fkey event/key
][
on-fkey/(event/key) face event 
exit
]
any[not view*/focal-face view*/focal-face/type = 'button][
either f: select face/keycodes event/key[
f/action/on-click f exit
][
if event/key = #"^["[
if find view*/pop-list view*/pop-face[hide-popup exit]
if all[view*/pop-face view*/pop-face/type = 'choose][hide-popup exit]
all[get in face 'action not face/action face exit]
if all[face = pick view*/screen-face/pane 1 1 <> length? view*/screen-face/pane][
either question "Do you really want to quit this application?"[quit][exit]
]
unview/only face 
exit
]
]
]
]
]
move[mouse-offset: event/offset]
resize[
all[face/size <> orig-size span-resize face face/size - orig-size]
show face 
orig-size: face/size 
exit
]
close[
if view*/focal-face[
view*/focal-face: view*/caret: none 
edit/unlight-text
]
all[get in face 'action not face/action face exit]
if all[face = pick view*/screen-face/pane 1 1 <> length? view*/screen-face/pane][
either question "Do you really want to quit this application?"[quit][exit]
]
]
]event/type 
event
]
]
either dialog[do-events][show spec spec]
]
examine: make function![
"Prints information about widgets and attributes." 
'widget 
/indent "Indent output as an MD2 ready string" 
/no-print "Do not print output to console" 
/local string tmp blk funcs
][
unless word? widget[widget: to word! widget]
unless find tmp: next find first widgets 'choose widget[
print "Unknown widget. Supported widgets are:^/" 
foreach widget tmp[print join "^-" widget]
exit
]
widget: widgets/:widget 
string: replace/all copy widget/tip "^/" "^/^-" 
replace/all string "[" join " " "[" 
replace/all string "]" join "]" " " 
replace/all string "^- " "^-" 
replace/all string " ^/" "^/" 
replace string "^-DESCRIPTION:" "^/DESCRIPTION:" 
replace string "^-OPTIONS:" "^/OPTIONS:" 
insert tail string {

ATTRIBUTES:} 
foreach attribute skip first rebface 3[
if all[
not find[show? face-flags feel action tip]attribute 
get tmp: in widget attribute
][
tmp: either find["function" "object" "block" "bitset"]form type? get tmp[join type? get tmp "!"][mold get tmp]
insert tail string rejoin[
"^/^-" 
head insert/dup tail form attribute " " 16 - length? form attribute 
tmp
]
]
]
unless widget/feel = widgets/default-feel[
insert tail string "^/^/PREDEFINED FEELS:" 
foreach attribute next first widgets/default-feel[
if get in widget/feel attribute[
insert tail string join "^/^-" attribute
]
]
]
unless widget/action = widgets/default-action[
insert tail string "^/^/PREDEFINED ACTIONS:" 
foreach attribute next first widgets/default-action[
if get in widget/action attribute[
insert tail string join "^/^-" attribute
]
]
]
funcs: copy[]
unless empty? blk: difference first rebface first widget[
insert tail string "^/^/EXTENDED ATTRIBUTES:" 
foreach attribute blk[
if tmp: in widget attribute[
either function? get tmp[
insert tail funcs attribute
][
tmp: either find["object" "block" "bitset"]form type? get tmp[join type? get tmp "!"][mold get tmp]
insert tail string rejoin["^/^-" head insert/dup tail form attribute " " 16 - length? form attribute tmp]
]
]
]
]
unless empty? funcs[
insert tail string "^/^/ACCESSOR FUNCTIONS:" 
foreach attribute funcs[
tmp: copy "" 
foreach w third get in widget attribute[
all[word? w insert tail tmp join " " w]
if refinement? w[
either w = /local[break][insert tail tmp join " /" w]
]
]
insert tail string rejoin["^/^-" uppercase form attribute tmp]
]
]
if indent[
replace/all string "^/" "^/^-" 
replace/all string "^-^/" "^/" 
insert string "^-"
]
if no-print[
replace/all string "^-" "    "
]
either any[indent no-print][string][print string]
]
get-values: make function![
{Gets values from input widgets within a display or grouping widget.} 
face[object!]"Display face" 
/type "Precede each value with its type" 
/local blk
][
all[
find[scroll-panel tab-panel]face/type 
face: either block? face/pane[face: face/pane/1][face/pane]
]
blk: copy[]
foreach widget face/pane[
if find[
area check check-group drop-list edit-list field group-box password radio-group scroll-panel slider tab-panel table text-list
]widget/type[
all[type insert tail blk widget/type]
insert/only tail blk case[
find[area drop-list edit-list field password]widget/type[widget/text]
find[check check-group slider]widget/type[widget/data]
find[radio-group table text-list]widget/type[widget/picked]
find[scroll-panel group-box tab-panel]widget/type[
either type[get-values/type widget][get-values widget]
]
]
]
]
blk
]
set-color: make function![
"Set and show a widget's color attribute." 
face[object!]
color[tuple! none!]
/no-show "Don't show"
][
face/color: color 
unless no-show[show face]
]
set-data: make function![
"Set and show a widget's data attribute." 
face[object!]
data[any-type!]
/no-show "Don't show"
][
face/data: either series? data[copy data][data]
unless no-show[show face]
]
set-focus: make function![
"Set and show widget focus." 
face[object!]
/caret
][
unless edit/unfocus[exit]
if face/show?[
if get in face/action 'on-focus[
unless face/action/on-focus face[return false]
]
view*/focal-face: face 
view*/caret: case[
all[caret in face 'caret face/caret][at face/text face/caret]
find behaviors/caret-on-focus face/type[either none? edit/caret[tail face/text][edit/caret]]
find behaviors/hilight-on-focus face/type[edit/hilight-all face face/text]
]
edit/caret: none 
all[in face 'esc face/esc: copy face/text]
either face/type = 'button[face/feel/over face true none][show face]
]
]
set-locale: make function![
"Dynamically set/change locale." 
language[string! none!]
/local dat-file
][
clear system/locale/words 
system/locale/dict: none 
all[
exists? dat-file: join what-dir either language[rejoin[%language/ language %.dat]][%locale.dat]
system/locale: construct/with load dat-file system/locale
]
all[
exists? system/locale/dictionary: rejoin[what-dir %dictionary/ system/locale/language %.dat]
system/locale/dict: make hash! parse read system/locale/dictionary " "
]
locale*: system/locale
]
set-state: make function![
"Toggle and show widget state." 
face[object!]
/info "Exit if already info." 
/edit "Exit if already edit." 
/local temp
][
all[info find face/options 'info exit]
all[edit not find face/options 'info exit]
either temp: find face/options 'info[remove temp][insert tail face/options 'info]
case[
find[area edit-list field]face/type[
face/color: either find face/options 'info[
face/action: make face/action[on-focus: make function![face][false]]
all[face/type = 'edit-list insert tail face/options 'no-click]
colors/outline-light
][
face/action: make face/action[on-focus: make function![face][true]]
all[face/type = 'edit-list remove find face/options 'no-click]
colors/page
]
]
face/type = 'button[
unless find face/options 'info[face/feel/over face false 0x0]
]
]
show face
]
set-text: make function![
"Set and show a widget's text attribute." 
face[object!]"Widget" 
text[any-type!]"Text" 
/caret "Insert at cursor position (tail if none)" 
/no-show "Don't show" 
/focus
][
unless string? face/text[exit]
either caret[
if all[
face = view*/focal-face 
view*/caret
][face/caret: index? view*/caret]
either face/caret[
insert at face/text face/caret form text 
view*/caret: at face/text face/caret + length? form text 
face/caret: index? view*/caret
][insert tail face/text form text]
][insert clear face/text form text]
all[
face/para 
face/para/scroll: 0x0 
all[face/type = 'area face/pane/data: 0]
]
face/line-list: none 
unless no-show[either focus[set-focus face][show face]]
]
set-text-color: make function![
"Set and show a widget's font color attribute." 
face[object!]
color[tuple! none!]
/no-show "Don't show"
][
unless string? face/text[exit]
all[
widgets/(face/type)/font 
face/font = widgets/(face/type)/font 
face/font: make face/font[]
]
face/font/color: color 
unless no-show[show face]
]
set-texts: make function![
"Set and show text attribute of a block of widgets." 
faces[block!]"Widgets" 
text[any-type!]"Text or block of text" 
/no-show "Don't show"
][
unless block? text[text: reduce[text]]
foreach face reduce faces[
set-text face first text 
unless 1 = length? text[text: next text]
]
text: head text 
unless no-show[show faces]
]
set-title: make function![
"Set and show window title." 
face[object!]"Window dialog face" 
title[string!]"Window bar title"
][
face/text: title 
face/changes: 'text 
show face
]
set-values: make function![
{Puts values into input widgets within a display or grouping widget.} 
face[object!]"Display face" 
blk[block!]"Block of values (or 'skip)" 
/no-show "Don't show" 
/local val
][
all[
find[scroll-panel tab-panel]face/type 
face: either block? face/pane[face: face/pane/1][face/pane]
]
foreach widget face/pane[
if find[
area check check-group drop-list edit-list field group-box password radio-group scroll-panel slider tab-panel table text-list
]widget/type[
unless 'skip = val: first blk[
switch/default widget/type[
check[widget/data: val]
check-group[all[block? val insert clear widget/data val]]
group-box[all[block? val set-values/no-show widget copy/deep val]]
radio-group[widget/select-item to integer! val]
scroll-panel[all[block? val set-values/no-show widget copy/deep val]]
slider[widget/data: to decimal! val]
tab-panel[all[block? val set-values/no-show widget copy/deep val]]
table[widget/select-row val]
text-list[widget/select-row val]
][
widget/line-list: none 
insert clear widget/text val 
all[widget/type = 'area widget/para widget/para/scroll: 0x0 widget/pane/data: 0]
]
]
if tail? blk[gui-error "set-values had insufficient values"]
blk: next blk
]
]
blk: head blk 
unless no-show[show face]
]
translate: make function![
{Dynamically translate a string or block of strings.} 
text "String (or block of strings) to translate" 
/local match
][
if all[series? text locale*/words][
text: copy/deep text 
all[
string? text 
match: select/skip locale*/words text 2 
insert clear text match
]
if block? text[
foreach word text[
all[
string? word 
match: select/skip locale*/words word 2 
insert clear word match
]
]
]
]
text
]
]
foreach word find first functions 'append-widget[
set to word! word get in functions word
]
remove-each font effects/fonts[not font? font]
set-locale none 
insert tail words next find first widgets 'choose
]
system/view/screen-face/feel: none 
open-events 
recycle