org 100h
jmp main
beep:
    mov ax,[freq]
	out 42h,al
	mov al,ah
	out 42h,al
	mov al,61h
	mov al,11b
	out  61h,al
	mov word [delayferq],35500
delaysound:
    dec word [delayferq]
    jne delaysound	
	mov ah,86h
	mov cx,5h
	mov dx,5h
	mov al,61h
	out 61h,al
	ret
beepded:
    mov ax,[freqded]
	out 42h,al
	mov al,ah
	out 42h,al
	mov al,61h
	mov al,11b
	out  61h,al
	mov word [delayferq],35500
delaysound1:
    dec word [delayferq]
    jne delaysound1	
	mov ah,86h
	mov cx,5h
	mov dx,5h
	mov al,61h
	out 61h,al
	ret
beepfruit:
    mov ax,[freqfruit]
	out 42h,al
	mov al,ah
	out 42h,al
	mov al,61h
	mov al,11b
	out  61h,al
	mov word [delayferq],35500
delaysound2:
    dec word [delayferq]
    jne delaysound2	
	mov ah,86h
	mov cx,5h
	mov dx,5h
	mov al,61h
	out 61h,al
	ret
clrscr:
     push es
	 push ax
	 push di
	 mov ax,0xb800
	 mov es,ax
	 mov di,0
nextloc:
     mov word [es:di],0x0720
	 add di,2
	 cmp di,4000
	 jne nextloc
	 pop di
	 pop ax 
	 pop es
	 ret
drawborder:
     push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 mov si,3
	 mov ax,0xb800
	 mov es,ax
	 mov di,480
	 mov cx,480
sider:
     add cx,160
	 inc si
     cmp si,4
	 je drawline
	 cmp si,25
	 je drawline
     cmp si,26
	 je return
sider1:
	 mov ah,0x10
	 mov al,'-'
	 mov [es:di],ax
	 add di,158
	 mov ah,0x10
	 mov al,'-'
	 mov [es:di],ax
	 add di,2
	 jmp sider
drawline: 
     mov ah,0x10
	 mov al,'-'
     mov word [es:di],ax
	 add di,2
	 cmp di,cx
	 jne drawline
	 je sider
return:
     pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 ret 
setdefaults:
     cmp word [lives],1
	 je returnhome
	 cmp word [len],240
	 je returnhome1
	 jne cont4
returnhome1:
      mov word [flagstatus],1
	  jmp returnmain
returnhome:
     jmp returnmain
cont4:
     dec word [lives]
     mov word [setflag],4
	 mov word [flagdown],0
	 mov word [flagup],0
	 mov word [flagright],0
	 mov word [flagleft],1
     mov si,40
	 mov ax,0xb800
	 mov es,ax
     mov ax,80
	 mov bx,12
	 mul bx
	 add ax,si
	 shl ax,1
	 mov di,ax
	 sub di,396
	 mov word [locatefood],di
	 add di,396
	 mov cx,[len1]
	 mov [len],cx
	 sti
	 call printlives
	 call printscore
	 call printlevel
	 ret
printstrlife:     
     push bp               
     mov  bp, sp               
     push es               
     push ax               
     push cx               
     push si               
     push di 
     mov  ax, 0xb800               
     mov  es, ax   
     mov  al, 80   
     mul  byte [bp+10]             
     add  ax, [bp+12] 
     shl  ax, 1              
     mov  di,ax 
     mov  si, [bp+6]                
     mov  cx, [bp+4]            
     mov  ah, [bp+8]
	 cld
nextchar:	    
     lodsb              
     stosw                 
     loop nextchar
     add di,4
     mov ah,0x07
     mov al,[lives]
     add al,0x30
     mov [es:di],ax	 
     pop  di               
     pop  si               
     pop  cx               
     pop  ax               
     pop  es 
     pop  bp               
     ret  10 
printstrscore:     
     push bp               
     mov  bp, sp               
     push es               
     push ax               
     push cx               
     push si               
     push di 
     mov  ax, 0xb800               
     mov  es, ax   
     mov  al, 80   
     mul  byte [bp+10]             
     add  ax, [bp+12] 
     shl  ax, 1              
     mov  di,ax 
     mov  si, [bp+6]                
     mov  cx, [bp+4]            
     mov  ah, [bp+8]
	 cld
nextchar1:	    
     lodsb              
     stosw                 
     loop nextchar1
     add di,4
	 mov word [locatescore],di
     call printnum
     mov ax,0x0720
     mov [es:di],ax
     add di,2
     mov ax,0x0720
     mov [es:di],ax	 
     pop  di               
     pop  si               
     pop  cx               
     pop  ax               
     pop  es               
     pop  bp               
     ret  10 
printstr:     
     push bp               
     mov  bp, sp               
     push es               
     push ax               
     push cx               
     push si               
     push di 
     mov  ax, 0xb800               
     mov  es, ax   
     ; mov  al, 80   
     ; mul  byte [bp+10]             
     ; add  ax, [bp+12] 
     ; shl  ax, 1              
     mov  di,[bp+10] 
     mov  si, [bp+6]                
     mov  cx, [bp+4]            
     mov  ah, [bp+8]
	 cld
nextchar2:	    
     lodsb              
     stosw                 
     loop nextchar2
	 mov [locatelevel],di
     ;add di,4
	 ;mov word [locatescore],di
     ; mov ah,0x07
     ; mov al,[lives]
     ; add al,0x30
     ; mov [es:di],ax
     ;call printnum	 
     pop  di               
     pop  si               
     pop  cx               
     pop  ax               
     pop  es               
     pop  bp               
     ret  8
printlevel:
     mov ax,2              
     push ax               
     mov  ax,0x05                   
     push ax                   
     mov ax,levelnum             
     push ax             
     push word [lengthlevel]           
     call printstr
	 mov word [storedi],di
	 mov word [locatelevel],16
	 mov di,[locatelevel]
	 mov ax,[levelnumber]
	 add ax,0x30
	 mov ah,0x07
	 mov [es:di],ax
	 mov word di,[storedi]
     ret
printscore:                
     mov  ax,1                      
     push ax              
     mov  ax,1               
     push ax               
     mov  ax,0x0A                   
     push ax                   
     mov ax,messagescore             
     push ax             
     push word [lengthscore]           
     call printstrscore
     ret
printlives:         
     mov  ax,1                      
     push ax              
     mov  ax,2               
     push ax               
     mov  ax,0x0E                   
     push ax                   
     mov  ax,messagelives              
     push ax                
     push word [lengthlife]           
     call printstrlife 
	 ret
setdrawsnake:         ;change for all directions
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 add di,si
	 add di,2
	 mov al,'-'
	 mov ah,0x10
	 cmp word [es:di],ax
	 je returnsnake
	 mov al,'='
	 mov ah,0x07
	 cmp word [es:di],ax
	 je returnsnake
	 sub di,2
	 mov al,'O'
	 mov ah,0x0D
	 ;mov [es:di],ax
	 mov bp,0
	 mov word [location+bp],di
	 mov word [snakechars+bp],ax
	 mov cx,[len]
	 add bp,2
l1draw:
     mov al,'o'
	 mov ah,0x0E
	 sub di,2
	 mov word [location+bp],di
	 mov word [snakechars+bp],ax
	 ;mov [es:di],ax
	 add bp,2
	 loop l1draw
	 jmp returnset
returnsnake:
     jmp far [cs:returnmain]
returnset:
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 ret 
createhurdles:
     push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 mov bp,0
	 mov cx,11
hurdles:
	 mov di,[dangerous+bp]
	 add di,120
	 cmp di,482
	 jb sethurd
hurdles1:
	 mov al,'o'
	 mov ah,0x0E
	 mov bl,'-'
	 mov bh,0x10
	 cmp word [es:di],ax
	 je sethurd
	 cmp word [es:di],bx
	 je sethurd
	 mov al,'X'
	 mov ax,0x04
	 cmp word [es:di],ax
	 je sethurd
	 mov bl,'-'
	 mov bh,0x10
	 mov [es:di],bx
	 add di,2
	 dec cx
	 cmp cx,0
	 jnz hurdles1
	 jmp returnhurdle
sethurd:
     dec cx
     cmp cx,0
     je returnhurdle 
     add di,200
	 add bp,2
	 jmp hurdles
returnhurdle:
     pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 ret 
dangfood:
     push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 mov bp,0
	 mov al,'o'
	 mov ah,0x0E
	 mov bl,'-'
	 mov bh,0x10
checkdang:
	 mov di,[dangerous+bp]
	 cmp di,484
	 jb setdang
	 cmp word[es:di],ax
	 je setdang
	 cmp word [es:di],bx
	 je setdang
	 jne outdang
setdang:
     add word [dangerous+bp],350
	 jmp checkdang
outdang:
     mov dl,'X'
	 mov dh,0x04
	 mov [es:di],dx
	 add bp,2
	 cmp bp,20
	 jne checkdang
returndang:
     pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 ret 
dangfood1:
     push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 mov bp,0
	 mov al,'o'
	 mov ah,0x0E
	 mov bl,'-'
	 mov bh,0x10
checkdang1:
	 mov di,[dangerous+bp]
	 cmp di,484
	 jb setdang1
	 cmp word[es:di],ax
	 je setdang1
	 cmp word [es:di],bx
	 je setdang1
	 jne outdang1
setdang1:
     add word [dangerous+bp],350
	 jmp checkdang1
outdang1:
     mov dl,'X'
	 mov dh,0x04
	 mov [es:di],dx
	 add bp,2
	 cmp bp,40
	 jne checkdang1
returndang1:
     pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 ret 
displevel:
     mov di,[locatelevel]
	 mov word ax,[levelnumber]
	 add al,0x30
	 mov ah,0x07
	 mov word [es:di],ax
	 ret
setdrawsnakeright:
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 ;add di,si
	 call printnum
	 call beep
	 mov di,[location]
	 add di,2
	 mov al,'-'
	 mov ah,0x10
	 cmp word [es:di],ax
	 je returnsnakerightll
	 mov al,'X'
	 mov ah,0x04
	 cmp word [es:di],ax
	 je returnsnakerightll
	 sub di,2
     cmp word [locatefood],di
	 ;je setvals1
	 jne cont11
setvals1:
     add word [locatefood],240
	 mov word [savedi],di
	 mov word di,[locatefood]
	 cmp di,3998
	 ja setfood
	 cmp di,482
	 jb setfood
	 mov ah,0x10
	 mov al,'-'
	 cmp word [es:di],ax
	 je setvals1
	 mov word di,[savedi]
	 jmp contfood
cont11:
     jmp cont1
setfood:
     mov word [locatefood],2600
	 jmp setvals
	 ;call beep 
	 ;call beep
returnsnakerightll:
     jmp returnsnakeright
contfood:
     call beepfruit
	 add word [catchcount],1
	 add word [len],4
	 cmp word [len],240
	 jae returnmainr
	 add word [score],10
	 cmp word [score],100
	 je stagesetr
     cmp word [score],200
	 je stagesetr1
	 cmp word [score],300
	 je stagesetr2
	 cmp word [score],400
	 je stagesetr3
	 jne cont1
stagesetr:
     inc word [levelnumber]
	 call displevel
	 mov word [flag],1
	 jmp cont1
stagesetr1:
     inc word [levelnumber]
	 call displevel
     mov word [flag],2
	 jmp cont1
stagesetr2:
     inc word [levelnumber]
	 call displevel
     mov word [flag],3
	 jmp cont1
stagesetr3:
     inc word [levelnumber]
	 call displevel
     mov word [flag],4
cont1:
	 mov cx,[len]
	 mov si,2
	 dec cx
	 jmp charright
returnmainr:
     jmp returnmain
charright:
     cmp word di,[location+si]
	 je returnsnakeright1
	 add si,2
	 loop charright
	 sub di,2      
	 mov cx,[len]
	 mov si,0
	 mov dx,[location+si]
	 add word [location+si],2
	 mov al,'O'
	 mov ah,0x0D
	 mov [snakechars+si],ax
	 mov al,'o'
	 mov ah,0x0E
l1rightset:
     add si,2
     mov [snakechars+si],ax
	 mov bx,[location+si]
	 mov word [location+si],dx
	 mov dx,bx
	 dec cx
	 cmp cx,1
	 jnz l1rightset
	 mov di,bx
	 mov ax,0xb800
	 mov es,ax
	 mov word [es:di],0x0720
	 cmp word [flag],1
	 je destfood4
	 cmp word [flag],2
	 je createhurdles4
	 cmp word [flag],3
	 je createhurdles41
	 cmp word [flag],4
	 je createhurdles42
     jne level4
returnsnakeright1:
     jmp returnsnakeright
destfood4:
     call dangfood
	 jmp level4
createhurdles4:
     call dangfood1
	 ;call createhurdles
	 jmp level4
createhurdles41:
     ;call dangfood
	 call createhurdles
	 jmp level4
createhurdles42:
     call dangfood1
	 call createhurdles
	 ;jmp level4
level4:
	 jmp returnsetright
returnsnakeright:
     call beepded
     call clrscr
	 call drawborder	 
     call setdefaults
	 call setdrawsnake
	 call move
returnsetright:
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 ret 
drawsnake:            
     push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 mov di,0
	 mov ah,0x10
	 mov al,'-'
	 mov [es:di],ax
	 call printnum
     cmp word [catchcount],5
     je outsp
	 cmp word [catchcount],6
	 je retsp
     jmp outfoo
outsp:
     mov di,[locatefood]
	 mov al,'$'
	 mov ah,0x8F
	 jmp outdraw
retsp:
     add word [score],40
     mov word [catchcount],1
outfoo:  	 
	 mov di,[locatefood]
	 mov ax,0xA020
outdraw:
	 mov [es:di],ax
	 mov cx,[len]
	 mov bp,0
	 mov di,0
	 mov word [es:di],0x0720
l1draw1:
     mov di,[location+bp]
	 mov ax,[snakechars+bp]
	 mov [es:di],ax
	 add bp,2
	 loop l1draw1
retsnake:
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 ret
printnum:                   
push es               
push ax               
push bx
push cx               
push dx        
push di  
mov  ax, 0xb800               
mov  es, ax              
mov  ax, [score]   
mov  bx, 10              
mov  cx, 0  
mov dx,0   
nextdigit:    
mov  dx, 0     
div  bx       
add  dl, 0x30                
push dx           
inc  cx               
cmp  ax, 0              
jnz  nextdigit 
mov  di, [locatescore]
nextpos:      
pop  dx         
mov  dh, 0x07     
mov [es:di], dx          
add  di, 2              
loop nextpos
     ;add di,2
     mov ax,0x0720
     mov [es:di],ax
     add di,2
     mov ax,0x0720
     mov [es:di],ax	 
pop  di               
pop  dx               
pop  cx               
pop  bx               
pop  ax               
pop  es              
ret 
printnumtime:                   
push es               
push ax               
push bx
push cx               
push dx        
push di  
mov  ax, 0xb800               
mov  es, ax              
mov  ax, [timecount]   
mov  bx, 10              
mov  cx, 0  
mov dx,0   
nextdigit1:    
mov  dx, 0     
div  bx       
add  dl, 0x30                
push dx           
inc  cx               
cmp  ax, 0              
jnz  nextdigit1 
mov di,478
mov word [es:di],0x0720
mov di,476
mov word [es:di],0x0720
mov  di, 474
nextpos1:      
pop  dx         
mov  dh, 0x07     
mov [es:di], dx          
add  di, 2              
loop nextpos1 
pop  di               
pop  dx               
pop  cx               
pop  bx               
pop  ax               
pop  es              
ret  
setdrawsnakeup:         ;change for all directions
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 ;add di,si
	 call printnum
	 call beep
	 mov di,[location]
	 sub di,160
	 mov al,'-'
	 mov ah,0x10
	 cmp word [es:di],ax
	 je returnsnakeupll
	 mov al,'X'
	 mov ah,0x04
	 cmp word [es:di],ax
	 je returnsnakeupll
	 add di,160
	 mov word [savedi],di
	 cmp word [locatefood],di
	 je setvals
	 jne contup
setvals:
     add word [catchcount],1
     add word [locatefood],360
	 mov word di,[locatefood]
	 cmp di,3998
	 ja setfood1
	 cmp di,482
	 jb setfood1
	 mov ah,0x10
	 mov al,'-'
	 cmp word [es:di],ax
	 je setvals
	 mov al,'o'
	 mov ah,0x0E
	 cmp word [es:di],ax
	 je setvals
	 mov word di,[savedi]
	 jmp contfood1
returnsnakeupll:
     jmp returnsnakeup
contup:
     jmp cont
setfood1:
     mov word [locatefood],2600
	 jmp setvals
	 ;call beep
contfood1:
     call beepfruit
	 add word [len],4
	 cmp word [len],240
	 jae returnmainu
	 add word [score],10
	 ; cmp word [catchcount],5
	 ; je addsp
	 ;add word [score],10
	 cmp word [score],100
	 je stagesetu
     cmp word [score],200
	 je stagesetu1
	 cmp word [score],300
	 je stagesetu2
	 cmp word [score],400
	 je stagesetu3
	 jne cont
stagesetu:
     inc word [levelnumber]
	 call displevel
	 mov word [flag],1
	 jmp cont
stagesetu1:
     inc word [levelnumber]
	 call displevel
     mov word [flag],2
	 jmp cont
stagesetu2:
     inc word [levelnumber]
	 call displevel
     mov word [flag],3
	 jmp cont
stagesetu3:
     inc word [levelnumber]
	 call displevel
     mov word [flag],4
cont:
	 mov cx,[len]
	 mov si,2
	 dec cx
	 jmp charup
returnmainu:
     jmp returnmain
charup:
     cmp word di,[location+si]
	 je returnsnakeup1
	 add si,2
	 loop charup
	 mov cx,[len]
	 add di,160
     mov si,0
	 mov dx,[location+si]
	 sub word [location+si],160
	 mov al,'O'
	 mov ah,0x0D
	 mov [snakechars+si],ax
	 mov al,'o'
	 mov ah,0x0E
  l1upset:
	 add si,2
	 mov [snakechars+si],ax
	 mov bx,[location+si]
	 mov word [location+si],dx
	 mov dx,bx
	 dec cx
	 cmp cx,1
	 jnz l1upset
	 mov di,bx
	 mov ax,0xb800
	 mov es,ax
	 mov word [es:di],0x0720
	 cmp word [flag],1
	 je destfood3
	 cmp word [flag],2
	 je createhurdles3
	 cmp word [flag],3
	 je createhurdles31
	 cmp word [flag],4
	 je createhurdles32
     jnae level3
returnsnakeup1:
     jmp returnsnakeup
destfood3:
     call dangfood
	 jmp level3
createhurdles3:
     call dangfood1
	 ;call createhurdles
	 jmp returnsetup
createhurdles31:
	 call createhurdles
	 jmp returnsetup
createhurdles32:
     call dangfood1
	 call createhurdles
	 jmp returnsetup
level3:
	 jmp returnsetup
returnsnakeup:
     call beepded
     call clrscr
	 call drawborder
     call setdefaults
	 call setdrawsnake
	 call move
returnsetup:
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 ret	
setdrawsnakeleft:         ;change for all directions
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 call printnum
	 call beep
	 ;add di,si
	 ;sub di,2
	 mov di,[location]
	 sub di,2
	 mov al,'-'
	 mov ah,0x10
	 cmp word [es:di],ax
	 je returnsnakeleftll
	 mov al,'X'
	 mov ah,0x04
	 cmp word [es:di],ax
	 je returnsnakeleftll
	 add di,2
	 cmp word [locatefood],di
	 je setvals2
	 jne cont22
setvals2:
     sub word [locatefood],540
	 mov word [savedi],di
	 mov word di,[locatefood]
	 cmp di,3998
	 ja setfood2
	 cmp di,482
	 jb setfood2
	 mov ah,0x10
	 mov al,'-'
	 cmp word [es:di],ax
	 je setvals2
	 mov al,'o'
	 mov ah,0x0E
	 cmp word [es:di],ax
	 je setvals2
	 jmp contfood2
cont22:
     jmp cont2
setfood2:
     mov word [locatefood],2600
	 jmp setvals2
returnsnakeleftll:
     jmp returnsnakeleft
contfood2:
     call beepfruit
	 mov word di,[savedi]
	 ;call beep
	 ;call beep 
	 ;call beep
	 add word [len],4
	 cmp word [len],240
	 jae returnmainl
	 add word [score],10
	 add word [catchcount],1
	 ;cmp word [catchcount],5
	 ;je addsp
	 cmp word [score],100
	 je stagesetl
     cmp word [score],200
	 je stagesetl1
	 cmp word [score],300
	 je stagesetl2
	 cmp word [score],400
	 je stagesetl3 
	 jmp cont2
stagesetl:
     inc word [levelnumber]
	 call displevel
	 mov word [flag],1
	 jmp cont2
stagesetl1:
     inc word [levelnumber]
	 call displevel
     mov word [flag],2
	 jmp cont2
stagesetl2:
     inc word [levelnumber]
	 call displevel
     mov word [flag],3
	 jmp cont2
stagesetl3:
     inc word [levelnumber]
	 call displevel
     mov word [flag],4
cont2:
     mov cx,[len]
	 mov si,2
	 dec cx
	 jmp charleft
returnmainl:
     jmp returnmain
charleft:
     cmp word di,[location+si]
	 je returnsnakeleft1
	 add si,2
	 loop charleft
	 add di,2
	 mov cx,[len]
	 mov si,0
	 mov dx,[location+si]
	 sub word [location+si],2
	 mov al,'O'
	 mov ah,0x0D
	 mov [snakechars+si],ax
	 mov al,'o'
	 mov ah,0x0E
l1leftset:
	 add si,2
	 mov [snakechars+si],ax
	 mov bx,[location+si]
	 mov word [location+si],dx
	 mov dx,bx
	 dec cx
	 cmp cx,1
	 jnz l1leftset
	 mov di,bx
	 mov ax,0xb800
	 mov es,ax
	 mov word [es:di],0x0720
	 cmp word [flag],1
	 je destfood1
	 cmp word [flag],2
	 je createhurdles1
	 cmp word [flag],3
	 je createhurdles2
	 cmp word [flag],4
	 je createhurdles3l
     jnae level11
returnsnakeleft1:
     jmp returnsnakeleft
destfood1:
     call dangfood
	 jmp level11
createhurdles1:
     call dangfood1
	 ;call createhurdles
	 jmp level11
createhurdles2:
     ;call dangfood
	 call createhurdles
	 jmp level11
createhurdles3l:
     call dangfood1
	 call createhurdles
level11:
	 jmp returnsetleft
returnsnakeleft:
     call beepded
     call clrscr
	 call drawborder
     call setdefaults
	 call setdrawsnake
	 call move
returnsetleft:
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 ret	
setdrawsnakedown:         ;change for all directions
	 push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 call printnum
	 call beep
	 ;add di,si
	 ;add di,160
	 mov di,[location]
	 ;add di,160
	 mov al,'-'
	 mov ah,0x10
	 add di,160
	 cmp word [es:di],ax
	 je returnsnakedownll
	 mov al,'X'
	 mov ah,0x04
	 cmp word [es:di],ax
	 je returnsnakedownll
	 sub di,160
	 cmp word [locatefood],di
	 je setvals3
	 jne cont33
setvals3:
     add word [locatefood],256
	 mov word [savedi],di
	 mov word di,[locatefood]
	 cmp di,3998
	 ja setfood3
	 cmp di,482
	 jb setfood3
	 mov ah,0x10
	 mov al,'-'
	 cmp word [es:di],ax
	 je setvals3
	 mov al,'o'
	 mov ah,0x0E
	 cmp word [es:di],ax
	 je setvals3
	 jmp contfood3
returnsnakedownll:
     jmp returnsnakedown
cont33:
     jmp cont3
setfood3:
     mov word [locatefood],2600
	 jmp setvals3
contfood3:
	 mov word di,[savedi]
	 call beepfruit
	 ;call beep 
	 ;call beep
	 add word [len],4
	 cmp word [len],240
	 jae returnmaind
	 add word [score],10
	 add word [catchcount],1
	 cmp word [score],100
	 je stagesetd
     cmp word [score],200
	 je stagesetd1
	 cmp word [score],300
	 je stagesetd2
	 cmp word [score],400
	 je stagesetd3
	 jnae cont3
stagesetd:
     ;cmp word [score],50
	 ;jnbe stagesetd1 
     inc word [levelnumber]
	 call displevel
	 mov word [flag],1
	 jmp cont3
stagesetd1:
     inc word [levelnumber]
	 call displevel
     mov word [flag],2
	 jmp cont3
stagesetd2:
     inc word [levelnumber]
	 call displevel
     mov word [flag],3
	 jmp cont3
stagesetd3:
     inc word [levelnumber]
	 call displevel
     mov word [flag],4
cont3:
	 mov cx,[len]
	 mov si,2
	 dec cx
	 jmp chardown
returnmaind:
     jmp returnmain
chardown:
     cmp word di,[location+si]
	 je returnsnakedown1
	 add si,2
	 loop chardown
	 ;sub di,160
	 mov cx,[len]
	 mov si,0
	 mov dx,[location+si]
	 add word [location+si],160
	 mov al,'O'
	 mov ah,0x0D
	 mov [snakechars+si],ax
	 mov al,'o'
	 mov ah,0x0E
l1downset:
	 add si,2
	 mov [snakechars+si],ax
	 mov bx,[location+si]
	 mov word [location+si],dx
	 mov dx,bx
	 dec cx
	 cmp cx,1
	 jnz l1downset
	 mov di,bx
	 mov ax,0xb800
	 mov es,ax
	 mov word [es:di],0x0720
     cmp word [flag],1
	 je destfood2
	 cmp word [flag],2
	 je createhurdles1d
	 cmp word [flag],3
	 je createhurdles2d
	 cmp word [flag],4
	 je createhurdles3d
     jnae level12
returnsnakedown1:
     jmp returnsnakedown
destfood2:
     call dangfood
	 jmp level12
createhurdles1d:
     call dangfood1
	 jmp level12
	 ;call createhurdles
createhurdles2d:
     call createhurdles
	 jmp level12
createhurdles3d:
     call dangfood1
     call createhurdles	 
level12:
	 jmp returnsetdown
returnsnakedown:
     call beepded
     call clrscr
	 call drawborder
     call setdefaults
	 call setdrawsnake
	 call move
returnsetdown:
	 pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
	 ret	
move:
     push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
	 ; cmp word [setflag],4
	 ; je forward
returndir2:
     sti
     mov al,0x20
	 out 0x20,al
forward:
     cmp word [setflag],1
	 je movup
	 cmp word [setflag],3
	 je movleft
	 cmp word [setflag],2
	 je movdown
	 cmp word [setflag],4
	 je movright
movright:
     call moveright
movup:
     call moveup
movleft:
     call moveleft
movdown:
     call movedown
	 ret
moveright:              
	 mov cx,[speed]
l2move:
     mov word [delay],15535
l1move:
	 dec word [delay]
	 cmp word[delay],0
	 ja l1move
	 loop l2move
	 ;call clrscr
	 ;call drawborder
	 add si,2
	 inc word [count]
	 call setdrawsnakeright
	 call drawsnake
	 call move
	 ret
moveup:                     
	 mov cx,[speed]
l2moveup:
     mov word [delay],15535
l1moveup:
	 dec word [delay]
	 cmp word[delay],0
	 ja l1moveup
	 loop l2moveup
	 ;call clrscr
	 ;call drawborder
	 inc word [count]
	 sub si,160
	 call setdrawsnakeup
	 call drawsnake
	 call move
	 ret
moveleft:                     
	 mov cx,[speed]
l2moveleft:
     mov word [delay],15535
l1moveleft:
	 dec word [delay]
	 cmp word[delay],0
	 ja l1moveleft
	 loop l2moveleft
	 ;call clrscr
	 ;call drawborder
	 inc word [count]
	 sub si,2
	 call setdrawsnakeleft
	 call drawsnake
	 call move
	 ret
movedown:                     
	 mov cx,[speed]
l2movedown:
     mov word [delay],12000
l1movedown:
	 dec word [delay]
	 cmp word[delay],0
	 ja l1movedown
	 loop l2movedown
	 ;call clrscr
	 ;call drawborder
	 inc word [count]
	 add si,160
	 call setdrawsnakedown
	 call drawsnake
	 call move
	 ret
setvalues:
     push ax
	 push bx
	 push cx
	 push dx
	 push di
	 push si
     cmp word [setflag],1
	 je upset
	 ;cmp [setflag],2
	 ;je dset
	 ;cmp [setflag],3
	 ;je lset
	 ;cmp [setflag],4
	 ;je rset
upset:
     mov cx,[len]
     mov si,0
	 mov dx,[location+si]
	 sub word [location+si],160
  l1upset1:
	 add si,2
	 mov bx,[location+si]
	 mov word [location+si],dx
	 mov dx,[location+si+2]
	 dec cx
	 cmp cx,1
	 jnz l1upset1
	 call moveup
	 ;call drawsnake 
     pop si
	 pop di
	 pop dx
	 pop cx
	 pop bx
	 pop ax
     ret
mover:
     push ax
	 push es
	 mov ax,0xb800
	 mov es,ax
	 in al,0x60
	 cmp al,0x48
	 je upmove
	 cmp al,0x50
	 je downmove
	 cmp al,0x4B 
	 je leftmover   ;left
	 cmp al,0x4D
	 je rightmover   ;right
	 jmp returndir1
upmove:
     cmp word [flagup],0
	 jnz returndir1
	 mov word [setflag],1
	 mov word [flagright],0
	 mov word [flagleft],0
	 mov word [flagdown],1
	 mov word [flagup],1
	 call moveup
	 jmp returndir1
rightmover:
     jmp rightmove
leftmover:
     jmp leftmove
downmove:
     cmp word [flagdown],0
	 jnz returndir1
     ;add di,160
	 mov word [setflag],2
	 mov word [flagright],0
	 mov word [flagleft],0
	 mov word [flagup],1
	 mov word [flagdown],1
	 call movedown
	 jmp returndir1
returndir1:
     mov al,0x20
	 out 0x20,al
	 pop es
	 pop ax
	 iret
leftmove:
     cmp word [flagleft],0
	 jnz returndir
	 mov word [setflag],3
	 mov word [flagright],1
	 mov word [flagup],0
	 mov word [flagdown],0
	 mov word [flagleft],1
	 call moveleft
	 jmp returndir
rightmove:
     cmp word [flagright],0
	 jnz returndir
	 mov word [setflag],4
	 mov word [flagup],0
	 mov word [flagleft],1
	 mov word [flagdown],0
	 mov word [flagright],1
	 call moveright
	 jmp returndir
returndir:
     mov al,0x20
	 out 0x20,al
	 pop es
	 pop ax
	 iret
timer:
     inc word [tickcount]
	 cmp word [tickcount],100
	 je inccurtime
	 jne eoitimer
inccurtime:
     dec word [timecount]
	 call printnumtime
     add word [curtime],1
	 mov word [tickcount],0
	 cmp word [curtime],240
	 je home
incsec:
     add word [second],1
	 cmp word [second],240
	 je setspeed
	 jne eoitimer
setspeed:
     sub word [speed],1
	 mov word [second],0
	 jmp eoitimer
home:
     jmp returnmain
eoitimer:
     mov al,0x20
	 out 0x20,al
     iret	
main:
     mov al, 0x36
     out 0x43, al   ;changing frequency of timer interrupt
     mov ax, 11931   ;setting frequency to 100  
     out 0x40, al    
     mov al,ah
     out 0x40, al
     xor ax,ax	
     mov es,ax
     mov word ax,[es:8*4]
	 mov word [oldisr],ax
	 mov word ax,[es:8*4+2]
	 mov word [oldisr+2],ax
initdang:
     mov word [dangerous],250
	 mov word [dangerous+2],520
	 mov word [dangerous+4],990
	 mov word [dangerous+6],1370
	 mov word [dangerous+8],1840
	 mov word [dangerous+10],2290
     mov word [dangerous+12],2950
	 mov word [dangerous+14],3380
	 mov word [dangerous+16],2580
	 mov word [dangerous+18],3780
	 mov word [dangerous+20],450
	 mov word [dangerous+22],800
     mov word [dangerous+24],1120
     mov word [dangerous+26],1580
	 mov word [dangerous+28],2080
	 mov word [dangerous+30],2580
	 mov word [dangerous+32],3180
	 mov word [dangerous+34],2780
	 mov word [dangerous+36],3580
	 mov word [dangerous+38],3680 
     xor ax,ax
	 mov es,ax
     ;cli
	 mov word [es:8*4],timer
     mov word [es:8*4+2],cs
     mov word [es:9*4],mover
     mov word [es:9*4+2],cs
     ;sti 
     call clrscr
     call drawborder
	 cmp word [setflag],0
	 je caller
	 jne notcaller
caller:
     call setdefaults
notcaller:
	 call setdrawsnake
	 call drawsnake
	 call move
returnmain:
     call clrscr
	 mov ax,1666
	 push ax
	 mov ax,0x00F5                    ;00E5 purple over orange
	 push ax
	 mov ax,status
	 push ax
	 push word [lengthstatus]
	 call printstr
	 cmp word [flagstatus],0
	 je outlost
	 cmp word [flagstatus],1
	 je outwin
outlost:
	 mov ax,1506
	 push ax
	 mov ax,0x00F5                    ;00E5 purple over orange
	 push ax
	 mov ax,lost
	 push ax
	 push word [lostlen]
	 call printstr
	 jmp exitmain
outwin:
     mov ax,1506
	 push ax
	 mov ax,0x00F5                    ;00E5 purple over orange
	 push ax
	 mov ax,win
	 push ax
	 push word [winlen]
	 call printstr
exitmain:
     xor ax,ax 
	 mov es,ax
     mov word ax,[oldisr]
     mov word [es:8*4],ax
	 mov word ax,[oldisr+2]
     mov word [es:8*4+2],ax
	 mov di,14
	 mov word [es:di],0x0720
     mov ax,4ch
	 int 21h
len:dw 10
oldisr:dd 0
score:dw 0
tickcount:dw 0
level: dw 0
second:dw 0
curtime:dw 0
speed: dw 12
catchcount:dw 1
messagescore:db 'Score'
messagelives:db 'Lives'
status:dw 'GAME OVER!'
levelnum:db 'LEVEL'
lost:db 'YOU LOST'
lostlen: dw 8
win: db 'YOU WIN'
winlen :dw 7
lengthlevel:dw 5
locatelevel:dw 0 
lengthstatus:dw 10
lengthlife:dw 5
lengthscore:dw 5 
len1:dw 20
lives:dw 4
delay:dw 0
storedi: dw 0              
flagup:dw 0
flagdown:dw 0
flagright:dw 0
flagleft:dw 0
setflag:dw 0
flagstatus:dw 0
flag:dw 0
location:times 250 dw 0
dangerous:times 20 dw 0
locatefood: dw 0
locatelives: dw 0
locatescore:dw 0
snakechars:times 250 dw 0
count:dw 0
savedi:dw 0
levelnumber:dw 1
timecount:dw 240
freq:dw 650
freqded:dw 950
freqfruit:dw 1180
delayferq:dw 34545
