
sequence.o:     file format elf64-x86-64


Disassembly of section .text.startup:

0000000000000000 <main>:
   0:	41 57                	push   r15
   2:	41 56                	push   r14
   4:	41 55                	push   r13
   6:	41 54                	push   r12
   8:	55                   	push   rbp
   9:	53                   	push   rbx
   a:	48 81 ec 18 12 00 00 	sub    rsp,0x1218
  11:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
  18:	00 00 
  1a:	48 89 84 24 08 12 00 	mov    QWORD PTR [rsp+0x1208],rax
  21:	00 
  22:	31 c0                	xor    eax,eax
  24:	83 ff 02             	cmp    edi,0x2
  27:	74 2e                	je     57 <main+0x57>
  29:	b8 01 00 00 00       	mov    eax,0x1
  2e:	48 8b b4 24 08 12 00 	mov    rsi,QWORD PTR [rsp+0x1208]
  35:	00 
  36:	64 48 33 34 25 28 00 	xor    rsi,QWORD PTR fs:0x28
  3d:	00 00 
  3f:	0f 85 29 01 00 00    	jne    16e <main+0x16e>
  45:	48 81 c4 18 12 00 00 	add    rsp,0x1218
  4c:	5b                   	pop    rbx
  4d:	5d                   	pop    rbp
  4e:	41 5c                	pop    r12
  50:	41 5d                	pop    r13
  52:	41 5e                	pop    r14
  54:	41 5f                	pop    r15
  56:	c3                   	ret    
  57:	48 8b 7e 08          	mov    rdi,QWORD PTR [rsi+0x8]
  5b:	31 c0                	xor    eax,eax
  5d:	31 f6                	xor    esi,esi
  5f:	e8 00 00 00 00       	call   64 <main+0x64>
  64:	83 f8 ff             	cmp    eax,0xffffffff
  67:	41 89 c5             	mov    r13d,eax
  6a:	74 bd                	je     29 <main+0x29>
  6c:	4c 8d a4 24 00 01 00 	lea    r12,[rsp+0x100]
  73:	00 
  74:	31 c0                	xor    eax,eax
  76:	48 89 e7             	mov    rdi,rsp
  79:	b9 20 00 00 00       	mov    ecx,0x20
  7e:	45 31 ff             	xor    r15d,r15d
  81:	45 31 f6             	xor    r14d,r14d
  84:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
  87:	b9 20 00 00 00       	mov    ecx,0x20
  8c:	4c 89 e7             	mov    rdi,r12
  8f:	49 8d 9c 24 00 01 00 	lea    rbx,[r12+0x100]
  96:	00 
  97:	31 ed                	xor    ebp,ebp
  99:	f3 48 ab             	rep stos QWORD PTR es:[rdi],rax
  9c:	48 8d b4 24 00 02 00 	lea    rsi,[rsp+0x200]
  a3:	00 
  a4:	ba 00 10 00 00       	mov    edx,0x1000
  a9:	44 89 ef             	mov    edi,r13d
  ac:	e8 00 00 00 00       	call   b1 <main+0xb1>
  b1:	48 85 c0             	test   rax,rax
  b4:	0f 84 a7 00 00 00    	je     161 <main+0x161>
  ba:	48 83 f8 ff          	cmp    rax,0xffffffffffffffff
  be:	0f 84 65 ff ff ff    	je     29 <main+0x29>
  c4:	48 85 c0             	test   rax,rax
  c7:	7e d3                	jle    9c <main+0x9c>
  c9:	48 8d 94 24 00 02 00 	lea    rdx,[rsp+0x200]
  d0:	00 
  d1:	48 8d 0c 02          	lea    rcx,[rdx+rax*1]
  d5:	eb 28                	jmp    ff <main+0xff>
  d7:	66 0f 1f 84 00 00 00 	nop    WORD PTR [rax+rax*1+0x0]
  de:	00 00 
  e0:	85 c0                	test   eax,eax
  e2:	74 54                	je     138 <main+0x138>
  e4:	80 3c 04 00          	cmp    BYTE PTR [rsp+rax*1],0x0
  e8:	0f 85 3b ff ff ff    	jne    29 <main+0x29>
  ee:	c6 04 04 01          	mov    BYTE PTR [rsp+rax*1],0x1
  f2:	41 83 c6 01          	add    r14d,0x1
  f6:	48 83 c2 01          	add    rdx,0x1
  fa:	48 39 d1             	cmp    rcx,rdx
  fd:	74 9d                	je     9c <main+0x9c>
  ff:	40 84 ed             	test   bpl,bpl
 102:	48 0f be 02          	movsx  rax,BYTE PTR [rdx]
 106:	74 d8                	je     e0 <main+0xe0>
 108:	85 c0                	test   eax,eax
 10a:	74 34                	je     140 <main+0x140>
 10c:	80 3c 04 00          	cmp    BYTE PTR [rsp+rax*1],0x0
 110:	0f 84 13 ff ff ff    	je     29 <main+0x29>
 116:	80 bc 04 00 01 00 00 	cmp    BYTE PTR [rsp+rax*1+0x100],0x0
 11d:	00 
 11e:	0f 85 05 ff ff ff    	jne    29 <main+0x29>
 124:	c6 84 04 00 01 00 00 	mov    BYTE PTR [rsp+rax*1+0x100],0x1
 12b:	01 
 12c:	41 83 c7 01          	add    r15d,0x1
 130:	eb c4                	jmp    f6 <main+0xf6>
 132:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
 138:	bd 01 00 00 00       	mov    ebp,0x1
 13d:	eb b7                	jmp    f6 <main+0xf6>
 13f:	90                   	nop
 140:	45 39 fe             	cmp    r14d,r15d
 143:	0f 85 e0 fe ff ff    	jne    29 <main+0x29>
 149:	4c 89 e0             	mov    rax,r12
 14c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
 150:	c6 00 00             	mov    BYTE PTR [rax],0x0
 153:	48 83 c0 01          	add    rax,0x1
 157:	48 39 c3             	cmp    rbx,rax
 15a:	75 f4                	jne    150 <main+0x150>
 15c:	45 31 ff             	xor    r15d,r15d
 15f:	eb 95                	jmp    f6 <main+0xf6>
 161:	89 e8                	mov    eax,ebp
 163:	83 f0 01             	xor    eax,0x1
 166:	0f b6 c0             	movzx  eax,al
 169:	e9 c0 fe ff ff       	jmp    2e <main+0x2e>
 16e:	e8 00 00 00 00       	call   173 <main+0x173>
