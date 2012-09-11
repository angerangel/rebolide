rebol [
	Title: "resize-vid.r"
	Author: "Romano Paolo Tenca"
	Date: 25/03/03
	Version: 1.0.0
	Copyright: {

     resize-vid.r (C) 2002-2003 Romano Paolo Tenca

     This software is provided 'as-is', without any express or implied
     warranty.  In no event will the author be held liable for any damages
     arising from the use of this software.

     Permission is granted to anyone to use this software for any purpose,
     including commercial applications, and to alter it and redistribute it
     freely, subject to the following restrictions:

     1. This notice may not be removed or altered.
     2. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
     3. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
}
	History: [
		25/03/03  "First public release"
	]
]

if in rebol 'ctx-resize [print "resize-vid.r already installed" exit]
ctx-resize: context [
	resize-ob: make object! [
		resize-d:	;pointer for flags
		size:		;old size
		list:		;resize list for do-resize
		user-group:	;id of user-group
		anchor:		;anchored faces
		anchor-to: 	;target face
		act:		;func [face delta delta-offset] for resize-do
		code:		;block of code to build list for nested faces at auto-resize time, can be [none] (=ignore inner faces)
		none
	]
	make-act: func [body][func [face delta delta-offset] copy/deep body]
	fake-ob: make object! [type: 'fake size: offset: 0x0 style: axis: extend: data: map: none]
	resize-mutual: [resize-x resize-y resize-xy resize-none]
	not-mutual?: func [flags][empty? intersect flags resize-mutual]
	fresize: compose [resize-x 1 resize-y 2 resize-xy 3 (none) 3 resize-none (none)]
	fresize-e: extract fresize 2
	select-fresize: func [flags][select fresize pick intersect flags fresize-e 1]
	fanchor: [anchor-x 1x0 anchor-y 0x1 anchor-xy 1x1]
	fanchor-e: extract fanchor 2
	falone: join fanchor-e 'resize-alone
	get-rd: func [face][
		all [in face 'flags face: face/flags face: find face 'resize-d get first face]
	]
	check-rd: func [face][
		if in face 'flags [any [get-rd face make resize-ob [resize-d: self flag-face face resize-d]]]
	]
	make-fake: function [comm [word!] xy [integer!] value [object! block!]][origin sz][
		either block? value [
			origin: 2147483647x2147483647 sz: 0x0
			foreach x value [origin: min origin x/offset sz: max sz x/offset + x/size]
			sz: sz - origin value: copy value
		][origin: value/offset sz: value/size value: reduce [value]]
		make fake-ob [style: comm offset: origin size: sz axis: xy data: value]
	]
	set 'do-resize function [
		{Execute the resize}
		face [object!] "Face to resize" size [pair!] "Size to add" offset [pair!] "Offset to add"
		/nosize "The size of face is already set"
	][map xy tot lens tmp resto axis resize-d data][
		resize-d: get-rd face
		either nosize [size: face/size - resize-d/size][
			either in face 'resize [face/resize face/size + size][face/size: face/size + size]
			face/offset: face/offset + offset
		]
		if resize-d [
			resize-d/size: face/size
			if resize-d/anchor [
				foreach [home axis word] resize-d/anchor [
					do-resize first reduce reduce [word] 0x0 (size * home) + offset * axis
				]
			]
			if resize-d/list [foreach x resize-d/list [do-resize x size 0x0]]
			if get in resize-d 'act [resize-d/act face size offset]
		]
		if face/type = 'fake [
			xy: pick [1x0 0x1 1x1] axis: face/axis
			switch face/style [
				size [foreach x face/data [do-resize x size * xy 0x0]]
				shift [foreach x face/data [do-resize x 0x0 offset * xy]]
				do [face/data face size offset]
				group [
					data: face/data map: face/map
					either axis = 3 [
						foreach x data [
							do-resize x size * map/1 / 100x100 offset
							map: next map
						]
					][
						lens: copy []
						tot: size/:axis
						foreach x map [
							if 2 = axis [x: reverse x]
							insert tail lens tmp: size * x / 100x100
							tot: tot - tmp/:axis
						]
						resto: either positive? tot [xy][negate xy]
						foreach x map [
							if all [tot <> 0 x/1 <> 0][
								lens/1: lens/1 + resto
								tot: tot - resto/:axis
							]
							do-resize first data lens/1 offset
							offset: xy * lens/1 + offset
							lens: next lens data: next data
						]
					]
				]
			]
		]
	]
	;=============== View resize code ===================
	layout-resize: function [
		"Creates the resize list"
		[catch]	blk [block!]
	][res rule arg x map faces tmp extend][
		res: copy []
		rule: [
			set x set-word! (set x tail res)
			|[
				(arg: extend: 100x0)
				['across (arg: 1) | 'below (arg: 2)]
				opt ['extend (extend: 100x100) | 'none | none]
				set map block!
				into [
					(faces: copy [])
					some [
						x: ['across | 'below] 2 thru block! tmp:
						(insert tail faces layout-resize copy/part x tmp)
						| set x [word! | path! | object!] (insert tail faces reduce reduce [x])
					]
					(tmp: make-fake 'group arg faces
					 either empty? map [create-map tmp][tmp/map: map] tmp/extend: extend)
				]
				| 'do set arg block!
				 (tmp: make fake-ob [style: 'do axis: 1 data: make-act arg])
				| set arg ['size | 'shift] set x ['x | 'y | 'xy] set tmp block!
				 (tmp: make-fake arg select [x 1 y 2 xy 3] x reduce tmp)
			] (insert tail res tmp)
		]
		if not parse blk [some rule][throw make error! join "*** Invalid rule: " mold blk]
		res
	]
	;=============== VID resize code ===================
	sort-offset: function [pane [block!] x [integer!]][y][
		any [x <> 3 x: 1]
		y: 3 - x
		sort/compare pane func [a b][
			either a/offset/:x < b/offset/:x [-1][
				either a/offset/:x > b/offset/:x [1][
					either a/offset/:y < b/offset/:y [-1][
						either a/offset/:y > b/offset/:y [1][0]
					]
				]
			]
		]
	]
	overlap?: function [a b xy [integer!]][][
		either xy = 3 [
			all [
				b/offset/x + b/size/x > a/offset/x a/offset/x + a/size/x > b/offset/x
				b/offset/y + b/size/y > a/offset/y a/offset/y + a/size/y > b/offset/y
			]
		][all [b/offset/:xy + b/size/:xy > a/offset/:xy a/offset/:xy + a/size/:xy > b/offset/:xy]]
	]
	create-map: function [fake][tmp table tot resto map extend xy][
		xy: fake/axis
		table: pick [[100x0 0x100 100x100 0x0][0x100 100x0 100x100 0x0]] xy <> 2
		fake/map: map: copy []
		tot: 0 extend: 0x0
		foreach x fake/data [
			extend: extend + tmp: either x/type = 'face [
				either all [in x 'flags tmp: select-fresize x/flags][pick table tmp][0x0]
			][
				either (xy <> 2) xor (x/axis = 2) [x/extend][reverse x/extend]
			]
			if all [xy <> 3 tmp/1 > 0][tot: x/size/:xy + tot]
			insert tail map tmp
		]
		fake/extend: min 100x100 100x100 * extend
		if all[tot > 0 xy <> 3][
			resto: 100
			foreach x fake/data [
				if map/1/1 > 0 [map/1/1: x/size/:xy * 100 / tot  resto: resto - map/1/1]
				map: next map
			]
			if resto > 0 [
				map: head map
				while [all [not tail? map resto > 0]][
					if map/1/1 > 0 [map/1/1: map/1/1 + 1 resto: resto - 1]
					map: next map
				]
			]
		]
	]
	find-groups: function [pane xy [integer!]][start group fake face safe-pane][
		safe-pane: pane
		while [1 < length? safe-pane][
			pane: safe-pane
			insert group: clear [] start: first pane
			remove pane
			until[
				face: first pane
				all [
					fake: either (xy <> 3) xor found? overlap? start face xy [
						make fake-ob [
							style: 'group axis: xy
							size: (max start/offset + start/size face/offset + face/size) - offset: min start/offset face/offset
						]
					][none]
					xy <> 3
					foreach x head pane [any [x = face not overlap? fake x 3 fake: none break]]
				]
				tail? pane: either fake [
					insert tail group either face/type = xy [face/data][face]
					start: fake
					remove pane
				][next pane]
			]
			safe-pane: either 1 = length? group [insert safe-pane group next safe-pane][
				sort-offset start/data: copy group xy
				create-map start
				head insert safe-pane start
			]
		]
		clear group
	]
	system/words/auto-resize: function [[catch] face [object!]][pane tmp][
		foreach x pane: reduce [face][
			if tmp: get-rd x [tmp/anchor: none]
			any [function? tmp: get in x 'pane not tmp insert tail pane tmp]
		]
		auto-resize face
	]
	auto-resize: function [face [object!]][
		resize-d x-resize-d pane backd oldlen tmp x groups end axis name target
	][
		any [resize-d: check-rd face return face]
		resize-d/size: face/size
		if resize-d/code [resize-d/list: do resize-d/code return face]
		if any [in face 'resize	none? tmp: get in face 'pane function? :tmp][return face]
		insert pane: copy [] tmp
		backd: copy []
		groups: copy []
		while [not empty? pane][
			either in auto-resize x: first pane 'flags [
				x-resize-d: get-rd x
				either empty? intersect x/flags falone [
					either all [x-resize-d name: x-resize-d/user-group][
						any [tmp: select groups name insert tail groups reduce [name tmp: copy []]]
						insert tail tmp x
						remove pane
					][
						either find x/flags 'resize-next [
							insert tail groups reduce [<next> tmp: reduce [x]]
							remove pane
							while [not tail? pane][
								insert tail tmp auto-resize x: first pane
								remove pane
								any [find x/flags 'resize-next break]
							]
						][pane: next pane]
					]
				][
					remove pane
					if tmp: select-fresize x/flags [insert tail backd make-fake 'size tmp x]
					any [
						empty? intersect x/flags fanchor-e
						foreach [home axis target] x-resize-d/anchor-to [
							tmp: check-rd either target = 'panel [face][get target]
							insert tail any [tmp/anchor tmp/anchor: copy []] reduce [home axis x]
						]
					]
				]
			][pane: next pane]
		]
		pane: head pane
		insert tail groups reduce [<main> pane]
		foreach [name pane] groups [
			if 1 < length? pane [
				sort-offset pane 2
				find-groups pane 3
				until [
					oldlen: length? pane
					foreach xy [2 1][find-groups pane xy]
					any [1 = length? pane all [oldlen = length? pane throw make error! join "invalid group: " to string! name]]
				]
			]
			any [name = <main> insert tail groups/<main> pane]
		]
		while [not tail? pane][
			pane: either all [pane/1/type = 'face in pane/1 'flags][
				either tmp: select-fresize pane/1/flags [
					change pane make-fake 'size tmp pane/1
				][remove pane]
			][next pane]
		]
		resize-d/list: head insert pane backd
		face
	]
	flag-resize: function [face flag][tmp][
		if find resize-mutual flag [foreach x resize-mutual [remove find face/flags x]]
		do compose [flag-face face (flag)]
	]
	;install
	insert-event-func func [face event][
		if all [event/type = 'resize flag-face? event/face resize-d][
			do-resize/nosize event/face 0x0 0x0
			show event/face
		]
		event
	]
	;============== VID: new facets
	insert tail svv/facet-words reduce [
		'resize-none 'resize-alone 'resize-x 'resize-y 'resize-xy 'resize-next func [new args][
			flag-resize new first args args
		]
		'resize-of func [new args][
			set in check-rd new 'user-group second args next args
		]
		'resize-do func [new args][
			set in check-rd new 'act make-act second args next args
		]
		'anchor-x 'anchor-y 'anchor-xy func [new args][
			flag-resize new first args
			new: check-rd new
			any [new/anchor-to new/anchor-to: copy []]
			insert tail new/anchor-to reduce [third args select fanchor first args second args]
			next next args
		]
	]
	;=============== Style resize code ===================
	;all the following stuff should be done by style coders,
	;this is a patch for already existing styles
	use [styles h flag] [
		styles: svv/vid-styles
		parse [
			backdrop backtile sensor key 'resize-alone
			sensor drop-down arrow key button toggle check radio btn btn-cancel btn-help btn-enter tog led 'resize-none
			field choice info text vtext txt body banner vh1 vh2 vh3 vh4 label lbl title rotary h1 h2 h3 h4 h5 tt code 'resize-x
			logo-bar 'resize-y
		][
			some [
				copy h to lit-word! set flag skip
				(foreach style h [
					if style: select styles style [
						insert tail style/init bind compose/deep [
							if any [
								not find resize-mutual (:flag)
								not-mutual? flags
							][
								insert tail flags (:flag)
							]
						] in style 'self
					]
				])
			]
		]
		foreach [name blk][
			list [
				set in check-rd self 'code [
					auto-resize subface
					layout-resize [size x [subface]]
				]
			]
			slider [
				if not-mutual? flags [append flags pick [resize-y resize-x] size/y > size/x]
				set in check-rd self 'code [layout-resize [do [state: none]]]
			]
			progress [
				if not-mutual? flags [append flags pick [resize-y resize-x] size/y > size/x]
				set in check-rd self 'code [layout-resize [do [state: none]]]
			]
			scroller [
				if not-mutual? flags [append flags select [y [resize-y] x [resize-x]] axis]
			]
			text-list [
				set in check-rd self 'code [
					layout-resize [
						size x [iter] size xy [pane] across extend [100x100 0x100] [sub-area sld]
						do [lc: to integer! size/y / iter/size/y sld/redrag lc / max 1 length? head lines sld/state: none]
					]
				]
			]
		][if name: select styles name [insert tail name/init bind blk in name 'self]]
	]
]
