rebol []

do %scroll-panel.r 

view layout [
	b: box  "A Box" forest feel [
		engage: func [face action event] [
			if action = 'scroll-line [
				print ["Scroll line" event/offset]
				
				]
			if action = 'scroll-page [ ; Ctrl+wheel
				print ["scroll page" event/offset]
				]
			]
		]
	button [? sp]	
]
focus b 
do-events