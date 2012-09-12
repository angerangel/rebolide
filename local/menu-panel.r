Rebol []
ctx-menu: make object! [
   images: reduce [
      ;menu bkg with edge
      load 64#{iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAABGdBTUEAALGOfPtR
kwAAACBjSFJNAAB6JQAAgIMAAPn/AACA6AAAdTAAAOpgAAA6lwAAF2+XqZnUAAAA
2klEQVR4nGL8//8/AzUAQACxgIjrV8+RZJqmthEjuhhAALEgSRJlCNBSrOIAAcRE
ikvwAYAAoppBAAFENYMAAogsgxgZGRuA2BeI1WBiAAHEgk8DHiAJxMZQQxmASegW
QACR6zUpZMNAACCAKHERCDyHCQAEENUCGyCAqGYQQADBvYYrxRILAAIIbBC2vAOK
XgZIYIKwJJo0KGyeIQsABBAxgf0MhxjIsLMwAYAAwmfQTShtzIAUO0jgLJIaBoAA
YsRXHiGnXChQQFcD1L8LRAMEEF6DSAEAAQYALkgnZ4y/3BQAAAAASUVORK5CYII=}
      ;menu check mark
      load 64#{iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAABGdBTUEAALGOfPtR
kwAAACBjSFJNAAB6JQAAgIMAAPn/AACA6AAAdTAAAOpgAAA6lwAAF2+XqZnUAAAA
U0lEQVR4nGJk+A+EuIAgAwNAADHhkwQBgABiQuagS4IAQAAxYQgiK37PwAAQQKhW
oEmCAEAAMSFz0CVBACCAGMC+gEEBFB4YAgQQI15vAgFAgAEA+ksXPT3o/BEAAAAA
SUVORK5CYII=}
   ]
   stylize/master [
      menu: face with [
         color: none
         font: make font [
            color: black
            offset: 0x0
            shadow: none
         ]
         edge: make edge [
            size: 1x1
            color: 172.168.153   
         ]
         words: [
            data [new/data: first next args next args]
            alpha [
               new/alpha: first next args
                  if system/build/date < 21-Jan-2004 [
                     new/alpha: 255 -  new/alpha
                  ]
               
               next args
            ]
         ]
         oft: 0x0
         state: off
         col: fnt: menu-f: none
         alpha: 0
         feel: make feel [
            resize: func [f size+][
               either pair? f/size [ f/size/x: f/size/x + size+/x ]
               [ f/size: f/size + size+]
               show f
            ]
         
         ]
         init: [
            col: any [color none]
            if not color [color: 236.233.216]
            pane: copy []
            fnt: font
            foreach [i b] data [
               insert tail pane make face [
                  text: i
                  edge: none
                  color: none
                  bkg-colors: reduce [49.106.197 none]
                  font-colors: reduce [white black]
                  font: make fnt [align: 'left]
                  para: make para [wrap?: false origin: 2x0]
                  size: 4x4 + get-tsize/fnt i fnt
                  offset: oft
                  data: b     
                  feel: make feel [
                     over: func [f a o][
                        if all [a f/parent-face/state f/parent-face/menu-f][
                           menu/reset f/data
                           f/parent-face/menu-f/options: none
                           f/parent-face/menu-f/tmp-oft: f/parent-face/menu-f/offset: (win-offset? f) + (0x1 * f/size) - 0x4
                           f/parent-face/menu-f/size: second span? f/parent-face/menu-f/pane: build menu/options f/data reduce ['color f/parent-face/col 'fnt f/font 'alpha f/parent-face/alpha]
                           f/parent-face/menu-f/data: f/data
                           show f/parent-face/menu-f
                        ]
                        f/color: pick f/bkg-colors a
                        f/font/color: pick f/font-colors a
                        show f
                     ]
                     engage: func [f a e][
                        switch a [
                           down [
                              f/parent-face/state: not f/parent-face/state
                           ]
                           up [
                              if f/parent-face/state [
                                 poke f/parent-face/pane index? find f/parent-face/pane f/self make f/self []
                                 menu/reset f/data
                                 show-popup/window/away f/parent-face/menu-f: make face [
                                    tmp-oft: offset: (win-offset? f) + (0x1 * f/size) - 0x4
                                    edge: none
                                    color: none
                                    data: f/data
                                    font: fnt
                                    maction: get in f/parent-face 'action
                                    pane: build menu/options data reduce ['color f/parent-face/col 'fnt font 'alpha f/parent-face/alpha]
                                    size: second span? pane
                                    if in system/view 'popface-feel [
                                       feel: make feel [
                                           close-events: [close]
                                           inside?: func [face event][face = event/face]
                                           process-outside-event: func [face event][
                                               unless find [move time active inactive key down scroll-line] event/type [hide-popup]
                                               event
                                           ]
                                           pop-detect:   func [face event][
                                               either inside? face event [
                                                   either find close-events event/type [hide-popup none] [event]
                                               ] [
                                                   process-outside-event face event
                                               ]
                                           ]
                                       ]
                                    ]
                                 ] find-window f
                                 wait []
                                 f/parent-face/state: false
                              ]
                           ]
                        ]
                     ]
                  ]
               ]
               oft: oft + (1x0 * (4x4 + get-tsize/fnt i font))
            ]
            ;size: second span? pane
            ;size: 600x20
            feel/resize self first reduce [size size: 0]
         ]
         multi: make multi [
            file: func [face blk][
               if pick blk 1 [
                  face/data: load first blk
               ]
            ]
         ]
      ]
   ]

   get-tsize: func [
      str
      /fnt
         fobj
   ][
      return size-text make face [
         if fnt [font: make fobj []]
         size: 10000x10000
         text: str
      ]
   ]
   
   menu: func [
      menu-data
      /options
       opt
      /ofs
         ofst
      /path
         pth
      /reset
      /local
      vedge
      rules
      lineh
      item-f
      dum-f
      sub
      dis?
      chk?
      img
      bar?
      itm
      key
      expand?
      node?
      blk
      oft
      mark
      result
   ][
      result: copy []
      if reset[
         parse menu-data rul: [some [mark: 'on (mark/1: 'off) | set blk block! (parse blk rul)| skip] to end]
          exit
      ]
      if not path [
         nodes: copy []
      ]
      vedge: 3x3
      dum-f: [
         over: func [f a o][do in get in first back find f/parent-face/pane f/self 'feel 'over first back find f/parent-face/pane f/self a 0x0]
         engage: func [f a e][do in get in first back find f/parent-face/pane f/self 'feel 'engage first back find f/parent-face/pane f/self a e]
      ]
      item-f: make face [
         edge: none
         color: none
         font: make any reduce [select opt 'fnt font][]
         bkg-colors: reduce [49.106.197 none]
         font-colors: reduce [white black]
         state: off
      ]
      lineh: second get-tsize/fnt "M" item-f/font
      if not path [pth: copy [0]]
      oft: vedge
      parse menu-data rules: [
         some [
            opt ['disable (dis?: true)] opt [any ['+ (chk?: true) | '- (chk?: false)]] opt [set img [image! | file! | path!]] opt ['bar (bar?: true)] set itm string! opt [# set key string!] opt ['sub (node?: true)] mark: opt [set expand? some ['on | 'off]] opt [set blk block!] (
               poke back tail pth 1 (index? mark)
               if all [none? expand? all [blk node?]][insert mark 'off]
               if img [
                  if not image? img [img: load img]
                  img: to-image make face [color: green edge: none image: img effect: 'fit size: 1x1 * lineh];16x16]
               ]
               if oft/y = 3 [
                  insert tail result sub: make face [ ;submenu face
                     type: 'sub
                     image: images/1; menu edge bitmap %gfx/menu.png
                     effect: compose [extend alphamul (any reduce [select opt 'alpha 255]) colorize (any reduce [select opt 'color none])]
                     color: none
                     edge: none
                     pane: copy []
                     if ofs [offset: ofst]
                  ]
               ]
               if bar? [
                  insert tail sub/pane make face [ ;menu delimiter
                     type: 'bar
                     color: 172.168.153
                     edge: none
                     size: 100x1
                     offset: oft + 0x2
                  ]
                  oft: oft + 0x4
                  bar?: false
               ]
               insert tail sub/pane make item-f [ ;menu item
                  type: 'item
                  text: itm
                  offset: oft
                  root: sub
                  font-colors: either dis? [[172.168.153 172.168.153]][font-colors]
                  font: make font [align: 'left color: font-colors/2]
                  para: make para [wrap?: false origin: 0x1 + (lineh * 1x0)]
                  size: 0x2 + get-tsize/fnt itm font
                  effect: either image? img [
                     compose/deep [draw [image 0x0 (img) 0.255.0]]
                  ][
                     either chk? [
                        [draw [image 4x4 images/2 0.255.0]]
                     ][
                        none
                     ]
                  ]
                  idx: copy pth
                  feel: make feel [
                     over: func [f a o /local j tmp tmpo tmps tmpi] compose/deep [
                        tmp: false
                        if not-equal? font-colors/1 172.168.153 [
                           f/color: pick f/bkg-colors a
                           f/font/color: pick f/font-colors a
                        ]
                        show f
                        if all [a not f/root/parent-face/options = f/idx] [
                           f/root/parent-face/options: f/idx
                            ([
                               j: 0
                               foreach n copy nodes [
                                  j: j + 1
                                 if all [(length? f/idx) <= (length? n) not n = f/idx][
                                    tmp: true
                                    do compose [(to-set-path reduce join ['f 'root 'parent-face 'data] n) 'off]
                                    remove at nodes j
                                    j: j - 1
                                 ]
                               ]
                           ])
                           (
                           either all [blk node? mark/1 = 'off] [
                               [
                                 tmp: true
                                  f/action f f/idx
                               ]
                            ][
                               [
                               ]
                            ]
                           )
                           ([
                              if tmp [
                              f/root/parent-face/size: second span? f/root/parent-face/pane: build menu/options f/root/parent-face/data reduce ['color select f/root/effect 'colorize 'fnt f/font 'alpha select f/root/effect 'alphamul]
                                 either (f/root/parent-face/size/x + f/root/parent-face/tmp-oft/x - (first get in find-window f 'size)) > 0 [
                                    if (length? f/root/parent-face/pane) > 1 [
                                       tmpo: 0
                                       tmps: f/root/parent-face/pane/2/offset/x + 6 
                                       tmpi: f/root/parent-face/tmp-oft/x
                                       foreach i next f/root/parent-face/pane [
                                          either tmpi + i/offset/x + i/size/x > first get in find-window f 'size [
                                             tmpi: tmpi - i/offset/x - i/size/x
                                             i/offset/x: tmpo - i/size/x + 6
                                          ][
                                             i/offset/x: tmpo + tmps - 6
                                          ]
                                          tmps: i/size/x
                                          tmpo: i/offset/x
                                       ]
                                    ]
                                 ][
                                    f/root/parent-face/offset/x: f/root/parent-face/tmp-oft/x
                                 ]
                                 if (tmpo: first first span? f/root/parent-face/pane) < 0 [
                                    foreach i f/root/parent-face/pane [
                                       i/offset/x: i/offset/x + absolute tmpo
                                    ]
                                    f/root/parent-face/offset/x: f/root/parent-face/tmp-oft/x + tmpo
                                    f/root/parent-face/size: second span? f/root/parent-face/pane
                                 ]
                                 show f/root/parent-face
                              ]
                           ])
                        ]
                     ]
                     engage: func [f a e][
                        switch a [
                           down [f/state: on ]
                           up [if f/state [f/action f f/idx] f/state: off]
                           away [f/state: off]
                        ]
                     ]
                  ]
                  if not dis? [
                     action: func [face value /local x itm rul] either all [blk node?] [
                        compose [
                           (to-set-path reduce join ['face 'root 'parent-face 'data] pth) 'on
                        ]
                     ][
                        compose/only [
                           itm: face/text
                           parse face/root/parent-face/data rul: [
                              some [
                                 x: any ['+ | '-] itm (x/1: switch/default x/1 [+ ['-] - ['+]][x/1])
                                 | x: block! (parse x/1 rul)
                                 | skip
                              ] to end
                           ]
                           do (blk)
                             face/root/parent-face/maction face value
                        ]
                     ]
                  ]
               ]
               if key [
                  insert tail sub/pane make face [ ;shortcut item
                     type: 'key
                     color: none
                     para: make para [wrap?: false origin: 2x0]
                     font: make item-f/font [color: black]
                     edge: none
                     text: key
                     size: 2x2 + get-tsize/fnt key item-f/font
                     offset/y: oft/y
                     feel: make feel dum-f
                  ]
                  key: none
               ]
               if all [blk node?] [
                  insert tail sub/pane make face [ ;arrow item
                     type: 'arrow
                     color: none
                     edge: none
                     effect: [arrow 0.7 0.0.0 rotate 90]
                     size: 1x1 * lineh
                     offset/y: oft/y
                     feel: make feel dum-f
                  ]
               ]
               if all [blk expand? = 'on][
                  insert/only tail nodes copy pth
                  poke pth length? pth 1 + last pth
                  insert tail result menu/ofs/path/options blk oft join pth 0 reduce ['color select opt 'color 'fnt item-f/font 'alpha select opt 'alpha]
               ]
               oft: oft + (0x1 * (0x2 + get-tsize/fnt itm item-f/font))
               blk: none
               dis?: none
               img: none
               chk?: none
               expand?: none
               node?: none
            )
            | skip
         ]
         to end
      ]
      return result
   ]
   
   build: func [
      data
      /local
         vedge
         oft
         lineh
         tmpo
   ][
      oft: 0x0
      vedge: 3x3
      lineh: second get-tsize/fnt "M" data/1/font
      foreach i data [
         i/size: (2 * vedge) + second span? i/pane
         i/offset/x: oft/x
         tmpo: i/offset/y
         i/offset/y: i/offset/y + oft/y
         foreach j i/pane [
            switch j/type [
               key [
                  j/offset/x: i/size/x + first get-tsize/fnt "M" data/1/font
               ]
            ]
         ]
         i/size: (2 * vedge) + (2x0 * lineh) + second span? i/pane
         foreach j i/pane [
            switch j/type [
               item   [
                  j/size/x: i/size/x - (2 * vedge/x) - 4
               ]
               arrow [
                  j/offset/x: i/size/x - j/size/x - vedge/x
               ]
               bar [
                  j/size/x: i/size/x - (2 * vedge/x) - 8
                  j/offset/x: vedge/x + 2
               ]
            ]
         ]
         oft: oft +  (1x0 * i/size) - (2x0 * vedge) + (0x1 * tmpo)
      ]
      return data
   ]
   
   menus: copy []

   add-menu: func [blk][
      insert menus blk
      sort/skip/all/compare reduce menus 4 func [a b][either within? a/1 b/1 b/2 [true][false]]
   ]
   remove-menu: func [blk][
      remove find menus blk
   ]

];end of ctx-menu
