Rebol []

stylize/master [
	tab-panel: face with [
		tab-area: make face [
			offset: 0x20
			edge: make edge [
				image: load to-binary decompress 64#{
eJzrDPBz5+WS4mJgYOD19HAJAtIgNhcHG5DsNTq/F0ixpDv6OjIwbOyr+R04GchX
SPYI8mVgqFJlYGhoZmD4+R9Iv2BgKDVgYHiVwMBgNZ2BQTx/+sqZV4BqSzxdHEMq
5iT9+f/fntmQQaFhRkcQKwsD4xGmZJ9ZxuLTLzIqMCk0RExwLZokFBjiM9Nc3kWS
+WNmA8OhDb9+fz+f0MPHwNSRYc7EIsC9i0FdXT+slYGxZZHAK7U1QLMmiDbVpPd4
KzowLIyulZq9aM+UJ2cZGNkYHn4VlU0+/eY00H4GT1c/l3VOCU0AA71IA+kAAAA=
}
				size: 4x4 
				color: none
				]
			feel: make feel [
				redraw: func [f a e] [
					either f/parent-face/border? [
						f/edge/effect: compose [extend 4x4 (f/size - 10) colorize (f/parent-face/colors/1)]
						][
							f/edge: none
							]
					f/effect: compose [gradient 0x1 252.252.254 244.243.238 colorize (f/parent-face/colors/1)]
					]
				]
			]	
		tab: make face [
			size: 50x19
			font: make font [
				color: 120.120.120
				size: 11
				]
			edge: make edge [
			color: none
			size: 0x1
			]
		feel: make feel [
			engage: func [f a e /local slf] [
				switch a [
					down [
						slf: f/parent-face/parent-face
						slf/tab-area/pane: select slf/tabs slf/focus-tab: index? find slf/tab-box/pane f/self
						if e [slf/action slf slf/focus-tab]
						slf/tab-area/pane/color: none
						show slf/pane
						]
					]
				]
			redraw: func [f a e /local slf] [
				if a = 'show [
					slf: f/parent-face/parent-face
					f/offset: min f/pos f/pos + f/parent-face/doft
					f/color: slf/colors/1
					either slf/focus-tab = index? find slf/tab-box/pane f/self [
						f/size/y: 22
						f/offset/y: 0
						f/font/color: black
						if slf/border? [
							f/edge/effect: compose/deep [draw [pen (slf/colors/1) fill-pen (slf/colors/1) box 0x19 1000x21]]
							f/effect: compose [round 158.169.165 3]
							]
						][
							f/size/y: 19
							f/offset/y: 2
							f/font/color: black + 60
							if slf/border? [
								f/edge/effect: none
								f/effect: [round 158.169.165 3 gradcol 0x1 140.140.140 110.110.110]
								]
							]
					]
				]
			]
		]
		size: none
		border?: true
		focus-tab: tabs: data: tab-box: dbak: arrows: color: edge: none
		colors: [#[none] 196.213.255]
		words: [
			data [new/data: first next args next args]
			no-border [new/border?: false args]
			]
		init: copy my-init: [
			tab-box: make face [
				offset: 4x2
				doft: 0x0
				steps: copy []
				max-size: 0x0
				color: edge: none
				pane: copy []
				]
			tab: make tab [font: make font []]
			tab-area: make tab-area [edge: make edge []]
			tab-box: make tab-box []
			tabs: copy []
			if not focus-tab [focus-tab: 1]
			pane: reduce [tab-area tab-box]
			if data [dbak: copy data]
			if not color [color: white]
			use [oft valu text lay idx f-tab tmp-size][
				tmp-size: 0x0
				oft: 0x2
				idx: 1 
				if not empty? data [
					parse data [
						some [
							any [set valu set-word!] set text string! set lay [block! | object! | word!] any [set f-tab 'focus] (
								if word? lay [lay: get lay]
								if block? lay [lay: layout lay]
								lay/offset: 0x0
								if value? 'f-tab [
									focus-tab: idx
									unset 'f-tab
									]
								if value? 'valu [
									set valu lay
									unset 'valu
									]
								if not size [
									tmp-size: max any [tmp-size 0x0] lay/size + 18x33
									]
								insert tail tabs reduce [idx lay]
								idx: idx + 1
								insert tail tab-box/pane make tab compose/deep [
									pos: oft
									size/x: 10 + first size-text make face [tab/font: make tab/font [] size: 1000x25 text: (text)]
									text: (text)
									edge: make edge []
									]
								insert tail tab-box/steps first get in last tab-box/pane 'size
								oft: oft + to-pair reduce [1 + first get in last tab-box/pane 'size 0]
								) | skip
							]
						]
					size: any [size tmp-size]
					tab-box/max-size: oft
					tab-box/size: (size * 1x0) + -16x21
					if oft/x > size/x [
						insert tail pane arrows: layout/offset/origin compose/deep [
							across
							origin 3x2 space 0
							arrow 17x17 (colors/2) left rate 6 [
								use [f] [
									f: face/parent-face/parent-face
									if not head? f/tab-box/steps [
										f/tab-box/steps: back f/tab-box/steps
										f/tab-box/doft: f/tab-box/doft + to-pair reduce [1 + first f/tab-box/steps 0]
										show f/tab-box
										]
									]
								]
								arrow 17x17 (colors/2) right rate 6 [
									use [f] [
										f: face/parent-face/parent-face
										if not tail? next f/tab-box/steps [
											f/tab-box/doft: f/tab-box/doft - to-pair reduce [1 + first f/tab-box/steps 0]
											f/tab-box/steps: next f/tab-box/steps
											show f/tab-box
											]
										]
									]
							] (size * 1x0) - 40x-2 0x0
						arrows/color: none
						]
					]
				]
			]
  
		feel: make feel [  
		
			resize: func [ f size+ ][
				either pair? size+ [
					f/size/y: f/size/y + size+/y
					][
						f/size: size+
						]
				show f
				]
   
			redraw: func [f a o /local idx] [
				if a = 'show [
					if not-equal? f/dbak f/data [
						hide f
						f/size: none
						f/arrows: none
						do bind f/my-init in f 'self
						show f
						exit
						]
					if f/color [
						f/colors/1: f/color
						f/color: none
						]
					idx: max 1 min length? f/tab-box/pane f/focus-tab
					f/tab-area/size: f/size - 10x25
					f/tab-box/pane/1/feel/engage f/tab-box/pane/:idx 'down none
					if f/arrows [
						f/arrows/color: none
						f/arrows/pane/1/color: f/arrows/pane/2/color: f/colors/2
						f/arrows/offset: (f/size * 1x0) - 40x-2
						f/tab-box/doft/x: negate f/tab-box/pane/:idx/pos/x
						f/tab-box/steps: skip head f/tab-box/steps f/focus-tab
						if f/tab-box/max-size/x < first f/tab-box/size: (f/size * 1x0) + -49x21 [
							f/tab-box/steps: head f/tab-box/steps
							f/tab-box/doft: 0x0
							f/arrows/offset: -100x-100
							]
						]
					]
				]
			]
		]
	]