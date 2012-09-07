REBOL [
    Title: "SCROLL-PANEL"
    Author: "Brett Handley"
    Date: 9-Jul-2002
    History: [
        1.1.0 [9-July-2002 "Modified due to new information on Resize facet." "Brett Handley"]
        1.0.0 [10-June-2002 "Initial version." "Brett Handley"]
    ]
]

stylize/master [

    SCROLL-PANEL: FACE edge [size: 2x2 effect: 'ibevel] with [

        data: cropbox: sliders: none

        ; returns unit-vector for an axis
        uv?: func [w] [either w = 'x [1x0] [0x1]]

        ; calculates canvas size
        sz?: func [f] [either f/edge [f/size - (2 * f/edge/size)] [f/size]]

        ; slider widths for both directions as a pair
        sldw: 25x15

        ; Manages the pane.
        layout-pane: function [/resize child-face] [sz dsz v v1 v2 lyo] [
            if none? data [data: copy []]

            ; Convert VID to a face.
            if block? data [data: layout/offset/styles data 0x0 copy self/styles]

            ; On initial layout create the crop-box and sliders.
            if not resize [
                if not size [size: data/size if edge [size: 2 * edge/size + size]]
                lyo: layout compose/deep [origin 0x0 cropbox: box
                    slider 5x1 * sldw [face/parent-face/scroll uv? face/axis value]
                    slider 1x5 * sldw [face/parent-face/scroll uv? face/axis value]]
                sliders: copy/part next lyo/pane 2
                pane: lyo/pane
            ]

            cropbox/pane: data
            sz: sz? self
            cropbox/size: sz dsz: data/size

            ; Determine the size of the content plus any required sliders.
            repeat i 2 [
                repeat v [x y] [
                    if dsz/:v > sz/:v [dsz: sldw * (reverse uv? v) + dsz]
                ]
            ]
            dsz: min dsz sldw + data/size

            ; Size the cropbox to accomodate sliders.
            repeat v [x y] [
                if (dsz/:v > sz/:v) [
                    cropbox/size: cropbox/size - (sldw * (reverse uv? v))
                ]
            ]

            ; Size and position the sliders - non-required slider(s) is/are off stage.
            repeat sl sliders [
                v2: reverse v1: uv? v: sl/axis
                sl/offset: cropbox/size * v2
                sl/size: add 2 * sl/edge/size + cropbox/size * v1 sldw * v2
                sl/redrag min 1.0 divide cropbox/size/:v data/size/:v
                if resize [svvf/drag-off sl sl/pane/1 0x0]
            ]
            if resize [do-face self data/offset]
            self
        ]

        ; Method to scroll the content with performance hinting.
        scroll: function [v value] [extra] [
            extra: min 0x0 (sz? cropbox) - data/size
            data/offset: add extra * v * value data/offset * reverse v
            cropbox/changes: 'offset
            show cropbox
            do-face self data/offset
            self
        ]	

	feel: make feel [
		engage 
		]

	

        ; Method to change the content
        modify: func [spec] [data: spec layout-pane/resize self]
        resize: func [new /x /y] [
            either any [x y] [
                if x [size/x: new]
                if y [size/y: new]
            ] [size: any [new size]]
            layout-pane/resize self
        ]
        init: [feel: none layout-pane]
        words: [data [new/data: second args next args]
            action [new/action: func [face value] second args next args]]
        multi: make multi [
            image: file: text: none
            block: func [face blk] [if blk/1 [face/data: blk/1]]
        ]
    ]

]

{SCROLL-PANEL DOCUMENTATION

    Author: "Brett Handley"
    Date: 10-Jun-2002

===Overview

The SCROLL-PANEL style provides a scrolling region for VID. It takes as
input a normal VID specification.

===Features

*Sliders will appear only if required.

*Fires action function when sliders are moved. Value is set to the current offset.

*If not size is specified it will utilise the size of the input.

===Recognised Facets

    DATA - Takes the specification for the layout.
    ACTION - Allows an action function to be given.

===Example Usage

    view layout [
        scroll-panel 200x200 orange [title "This is a scrolling region"]
        scroll-panel [text "This scroll panel has no sliders" ]
    ]

###
}

