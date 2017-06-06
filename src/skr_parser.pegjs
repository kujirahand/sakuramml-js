main
  = sentence*

sentence
   = (" " / "\n" / "\r" / "\t")+
   { return {type:"nop", loc:location()} }
   / note
   / cmd_o
   / cmd_q
   / cmd_v
   / cmd_l
   / cmd_voice

note
  = name:[a-g] len:note_len "," __ q:q_len
  { return {type: 'note', name, len, q} }
  / name:[a-g] len:note_len
  { return {type: 'note', name, len, q:''} }
  / "n" tone:$([0-9]+) len:note_len "," __ q:q_len
  { return {type: 'tone', name, len, q} }
  / "n" tone:$([0-9]+) len:note_len
  { return {type: 'tone', name, len, q:''} }

note_len
  = "%" len:$([0-9]+)
  { return { len, flag:'%' } }
  / len:$([0-9.]*) __ "^" __ len2:note_len
  { return { len, len2, flag: '=' } }
  / len:$([0-9.]*)
  { return { len, len2:null, flag: '=' } }

q_len
  = "!" value:value
  { return { value, flag:'!'} }
  / "%"? value:value
  { return { value, flag:'%' } }

cmd_o
  = "o" value:ud_value
  { return { type: 'o', value} }
cmd_q
  = "q" q_len
  { return { type: 'o', value:q_len} }
cmd_v
  = "v" value:ud_value
  { return { type: 'v', value} }
cmd_l
  = "l" value:note_len
  { return { type: 'l', value} }
cmd_voice
  = "@" value:value
  { return { type: 'v', value} }

value = $([0-9]+)
ud_value
  = flag:("+" / "-" / "=") value:value
  { return {flag, value} }
  / value:value
  { return {flag: "=", value} }
__ = [" ", "\n"]*
