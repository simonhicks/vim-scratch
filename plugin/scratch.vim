command! -nargs=* Scratch call scratch#OpenScratchBuffer(0, 0, <f-args>)
command! -nargs=* HScratch call scratch#OpenScratchBuffer(1, 0, <f-args>)
command! -nargs=* VScratch call scratch#OpenScratchBuffer(1, 1, <f-args>)
