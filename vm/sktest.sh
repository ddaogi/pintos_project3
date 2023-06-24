cd ..
source ./activate
cd vm
make clean
make
cd build
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/read-boundary:read-boundary -p ../../tests/userprog/sample.txt:sample.txt --swap-disk=4 -- -q   -f run read-boundary < /dev/null 2> tests/userprog/read-boundary.errors > tests/userprog/read-boundary.output
# perl -I../.. ../../tests/userprog/read-boundary.ck tests/userprog/read-boundary tests/userprog/read-boundary.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/create-null:create-null --swap-disk=4 -- -q   -f run create-null < /dev/null 2> tests/userprog/create-null.errors > tests/userprog/create-null.output
# perl -I../.. ../../tests/userprog/create-null.ck tests/userprog/create-null tests/userprog/create-null.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/create-bad-ptr:create-bad-ptr --swap-disk=4 -- -q   -f run create-bad-ptr < /dev/null 2> tests/userprog/create-bad-ptr.errors > tests/userprog/create-bad-ptr.output
# perl -I../.. ../../tests/userprog/create-bad-ptr.ck tests/userprog/create-bad-ptr tests/userprog/create-bad-ptr.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/read-bad-ptr:read-bad-ptr -p ../../tests/userprog/sample.txt:sample.txt --swap-disk=4 -- -q   -f run read-bad-ptr < /dev/null 2> tests/userprog/read-bad-ptr.errors > tests/userprog/read-bad-ptr.output
# perl -I../.. ../../tests/userprog/read-bad-ptr.ck tests/userprog/read-bad-ptr tests/userprog/read-bad-ptr.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/read-boundary:read-boundary -p ../../tests/userprog/sample.txt:sample.txt --swap-disk=4 -- -q   -f run read-boundary < /dev/null 2> tests/userprog/read-boundary.errors > tests/userprog/read-boundary.output
# perl -I../.. ../../tests/userprog/read-boundary.ck tests/userprog/read-boundary tests/userprog/read-boundary.result


# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/fork-once:fork-once --swap-disk=4 -- -q   -f run fork-once < /dev/null 2> tests/userprog/fork-once.errors > tests/userprog/fork-once.output
# perl -I../.. ../../tests/userprog/fork-once.ck tests/userprog/fork-once tests/userprog/fork-once.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/fork-multiple:fork-multiple --swap-disk=4 -- -q   -f run fork-multiple < /dev/null 2> tests/userprog/fork-multiple.errors > tests/userprog/fork-multiple.output
# perl -I../.. ../../tests/userprog/fork-multiple.ck tests/userprog/fork-multiple tests/userprog/fork-multiple.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/fork-recursive:fork-recursive --swap-disk=4 -- -q   -f run fork-recursive < /dev/null 2> tests/userprog/fork-recursive.errors > tests/userprog/fork-recursive.output
# perl -I../.. ../../tests/userprog/fork-recursive.ck tests/userprog/fork-recursive tests/userprog/fork-recursive.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/fork-read:fork-read -p ../../tests/userprog/sample.txt:sample.txt --swap-disk=4 -- -q   -f run fork-read < /dev/null 2> tests/userprog/fork-read.errors > tests/userprog/fork-read.output
# perl -I../.. ../../tests/userprog/fork-read.ck tests/userprog/fork-read tests/userprog/fork-read.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/fork-boundary:fork-boundary --swap-disk=4 -- -q   -f run fork-boundary < /dev/null 2> tests/userprog/fork-boundary.errors > tests/userprog/fork-boundary.output
# perl -I../.. ../../tests/userprog/fork-boundary.ck tests/userprog/fork-boundary tests/userprog/fork-boundary.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/read-normal:read-normal -p ../../tests/userprog/sample.txt:sample.txt --swap-disk=4 -- -q   -f run read-normal < /dev/null 2> tests/userprog/read-normal.errors > tests/userprog/read-normal.output
# perl -I../.. ../../tests/userprog/read-normal.ck tests/userprog/read-normal tests/userprog/read-normal.result

# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/exec-missing:exec-missing --swap-disk=4 -- -q   -f run exec-missing < /dev/null 2> tests/userprog/exec-missing.errors > tests/userprog/exec-missing.output
# perl -I../.. ../../tests/userprog/exec-missing.ck tests/userprog/exec-missing tests/userprog/exec-missing.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/exec-bad-ptr:exec-bad-ptr --swap-disk=4 -- -q   -f run exec-bad-ptr < /dev/null 2> tests/userprog/exec-bad-ptr.errors > tests/userprog/exec-bad-ptr.output
# perl -I../.. ../../tests/userprog/exec-bad-ptr.ck tests/userprog/exec-bad-ptr tests/userprog/exec-bad-ptr.result


# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/pt-grow-stk-sc:pt-grow-stk-sc --swap-disk=4 -- -q   -f run pt-grow-stk-sc < /dev/null 2> tests/vm/pt-grow-stk-sc.errors > tests/vm/pt-grow-stk-sc.output
# perl -I../.. ../../tests/vm/pt-grow-stk-sc.ck tests/vm/pt-grow-stk-sc tests/vm/pt-grow-stk-sc.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/pt-grow-bad:pt-grow-bad --swap-disk=4 -- -q   -f run pt-grow-bad < /dev/null 2> tests/vm/pt-grow-bad.errors > tests/vm/pt-grow-bad.output
# perl -I../.. ../../tests/vm/pt-grow-bad.ck tests/vm/pt-grow-bad tests/vm/pt-grow-bad.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/pt-grow-stack:pt-grow-stack --swap-disk=4 -- -q   -f run pt-grow-stack < /dev/null 2> tests/vm/pt-grow-stack.errors > tests/vm/pt-grow-stack.output
# perl -I../.. ../../tests/vm/pt-grow-stack.ck tests/vm/pt-grow-stack tests/vm/pt-grow-stack.result

# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/pt-bad-addr:pt-bad-addr --swap-disk=4 -- -q   -f run pt-bad-addr < /dev/null 2> tests/vm/pt-bad-addr.errors > tests/vm/pt-bad-addr.output
# perl -I../.. ../../tests/vm/pt-bad-addr.ck tests/vm/pt-bad-addr tests/vm/pt-bad-addr.result

# pintos -v -k -T 60 -m 20 --fs-disk=10 -p tests/vm/mmap-close:mmap-close -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q -f run mmap-close < /dev/null 2> tests/vm/mmap-close.errors > tests/vm/mmap-close.output
# perl -I../.. ../../tests/vm/mmap-close.ck tests/vm/mmap-close tests/vm/mmap-close.result
# objdump -h tests/vm/mmap-close | less
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-read:mmap-read -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-read < /dev/null 2> tests/vm/mmap-read.errors > tests/vm/mmap-read.output
# perl -I../.. ../../tests/vm/mmap-read.ck tests/vm/mmap-read tests/vm/mmap-read.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-close:mmap-close -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-close < /dev/null 2> tests/vm/mmap-close.errors > tests/vm/mmap-close.output
# perl -I../.. ../../tests/vm/mmap-close.ck tests/vm/mmap-close tests/vm/mmap-close.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-clean:mmap-clean -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-clean < /dev/null 2> tests/vm/mmap-clean.errors > tests/vm/mmap-clean.output
# perl -I../.. ../../tests/vm/mmap-clean.ck tests/vm/mmap-clean tests/vm/mmap-clean.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-overlap:mmap-overlap -p tests/vm/zeros:zeros --swap-disk=4 -- -q   -f run mmap-overlap < /dev/null 2> tests/vm/mmap-overlap.errors > tests/vm/mmap-overlap.output
# perl -I../.. ../../tests/vm/mmap-overlap.ck tests/vm/mmap-overlap tests/vm/mmap-overlap.result

# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-kernel:mmap-kernel -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-kernel < /dev/null 2> tests/vm/mmap-kernel.errors > tests/vm/mmap-kernel.output
# perl -I../.. ../../tests/vm/mmap-kernel.ck tests/vm/mmap-kernel tests/vm/mmap-kernel.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-bad-off:mmap-bad-off -p ../../tests/vm/large.txt:large.txt --swap-disk=4 -- -q   -f run mmap-bad-off < /dev/null 2> tests/vm/mmap-bad-off.errors > tests/vm/mmap-bad-off.output
# perl -I../.. ../../tests/vm/mmap-bad-off.ck tests/vm/mmap-bad-off tests/vm/mmap-bad-off.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-off:mmap-off -p ../../tests/vm/large.txt:large.txt --swap-disk=4 -- -q   -f run mmap-off < /dev/null 2> tests/vm/mmap-off.errors > tests/vm/mmap-off.output
# perl -I../.. ../../tests/vm/mmap-off.ck tests/vm/mmap-off tests/vm/mmap-off.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-zero-len:mmap-zero-len --swap-disk=4 -- -q   -f run mmap-zero-len < /dev/null 2> tests/vm/mmap-zero-len.errors > tests/vm/mmap-zero-len.output
# perl -I../.. ../../tests/vm/mmap-zero-len.ck tests/vm/mmap-zero-len tests/vm/mmap-zero-len.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-bad-fd3:mmap-bad-fd3 --swap-disk=4 -- -q   -f run mmap-bad-fd3 < /dev/null 2> tests/vm/mmap-bad-fd3.errors > tests/vm/mmap-bad-fd3.output
# perl -I../.. ../../tests/vm/mmap-bad-fd3.ck tests/vm/mmap-bad-fd3 tests/vm/mmap-bad-fd3.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-bad-fd2:mmap-bad-fd2 --swap-disk=4 -- -q   -f run mmap-bad-fd2 < /dev/null 2> tests/vm/mmap-bad-fd2.errors > tests/vm/mmap-bad-fd2.output
# perl -I../.. ../../tests/vm/mmap-bad-fd2.ck tests/vm/mmap-bad-fd2 tests/vm/mmap-bad-fd2.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-zero:mmap-zero --swap-disk=4 -- -q   -f run mmap-zero < /dev/null 2> tests/vm/mmap-zero.errors > tests/vm/mmap-zero.output
# perl -I../.. ../../tests/vm/mmap-zero.ck tests/vm/mmap-zero tests/vm/mmap-zero.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-remove:mmap-remove -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-remove < /dev/null 2> tests/vm/mmap-remove.errors > tests/vm/mmap-remove.output
# perl -I../.. ../../tests/vm/mmap-remove.ck tests/vm/mmap-remove tests/vm/mmap-remove.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-over-stk:mmap-over-stk -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-over-stk < /dev/null 2> tests/vm/mmap-over-stk.errors > tests/vm/mmap-over-stk.output
# perl -I../.. ../../tests/vm/mmap-over-stk.ck tests/vm/mmap-over-stk tests/vm/mmap-over-stk.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-over-data:mmap-over-data -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-over-data < /dev/null 2> tests/vm/mmap-over-data.errors > tests/vm/mmap-over-data.output
# perl -I../.. ../../tests/vm/mmap-over-data.ck tests/vm/mmap-over-data tests/vm/mmap-over-data.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-over-code:mmap-over-code -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-over-code < /dev/null 2> tests/vm/mmap-over-code.errors > tests/vm/mmap-over-code.output
# perl -I../.. ../../tests/vm/mmap-over-code.ck tests/vm/mmap-over-code tests/vm/mmap-over-code.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-null:mmap-null -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-null < /dev/null 2> tests/vm/mmap-null.errors > tests/vm/mmap-null.output
# perl -I../.. ../../tests/vm/mmap-null.ck tests/vm/mmap-null tests/vm/mmap-null.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-misalign:mmap-misalign -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-misalign < /dev/null 2> tests/vm/mmap-misalign.errors > tests/vm/mmap-misalign.output
# perl -I../.. ../../tests/vm/mmap-misalign.ck tests/vm/mmap-misalign tests/vm/mmap-misalign.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-inherit:mmap-inherit -p ../../tests/vm/sample.txt:sample.txt -p tests/vm/child-inherit:child-inherit --swap-disk=4 -- -q   -f run mmap-inherit < /dev/null 2> tests/vm/mmap-inherit.errors > tests/vm/mmap-inherit.output
# perl -I../.. ../../tests/vm/mmap-inherit.ck tests/vm/mmap-inherit tests/vm/mmap-inherit.result


# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-bad-fd:mmap-bad-fd --swap-disk=4 -- -q   -f run mmap-bad-fd < /dev/null 2> tests/vm/mmap-bad-fd.errors > tests/vm/mmap-bad-fd.output
# perl -I../.. ../../tests/vm/mmap-bad-fd.ck tests/vm/mmap-bad-fd tests/vm/mmap-bad-fd.result
# pintos -v -k -T 600 -m 20   --fs-disk=10 -p tests/vm/mmap-shuffle:mmap-shuffle --swap-disk=4 -- -q   -f run mmap-shuffle < /dev/null 2> tests/vm/mmap-shuffle.errors > tests/vm/mmap-shuffle.output
# perl -I../.. ../../tests/vm/mmap-shuffle.ck tests/vm/mmap-shuffle tests/vm/mmap-shuffle.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-ro:mmap-ro -p ../../tests/vm/large.txt:large.txt --swap-disk=4 -- -q   -f run mmap-ro < /dev/null 2> tests/vm/mmap-ro.errors > tests/vm/mmap-ro.output
# perl -I../.. ../../tests/vm/mmap-ro.ck tests/vm/mmap-ro tests/vm/mmap-ro.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-write:mmap-write --swap-disk=4 -- -q   -f run mmap-write < /dev/null 2> tests/vm/mmap-write.errors > tests/vm/mmap-write.output
# perl -I../.. ../../tests/vm/mmap-write.ck tests/vm/mmap-write tests/vm/mmap-write.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-twice:mmap-twice -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-twice < /dev/null 2> tests/vm/mmap-twice.errors > tests/vm/mmap-twice.output
# perl -I../.. ../../tests/vm/mmap-twice.ck tests/vm/mmap-twice tests/vm/mmap-twice.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-overlap:mmap-overlap -p tests/vm/zeros:zeros --swap-disk=4 -- -q   -f run mmap-overlap < /dev/null 2> tests/vm/mmap-overlap.errors > tests/vm/mmap-overlap.output
# perl -I../.. ../../tests/vm/mmap-overlap.ck tests/vm/mmap-overlap tests/vm/mmap-overlap.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-unmap:mmap-unmap -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-unmap < /dev/null 2> tests/vm/mmap-unmap.errors > tests/vm/mmap-unmap.output
# perl -I../.. ../../tests/vm/mmap-unmap.ck tests/vm/mmap-unmap tests/vm/mmap-unmap.result



# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/pt-grow-stk-sc:pt-grow-stk-sc --swap-disk=4 -- -q   -f run pt-grow-stk-sc < /dev/null 2> tests/vm/pt-grow-stk-sc.errors > tests/vm/pt-grow-stk-sc.output
# perl -I../.. ../../tests/vm/pt-grow-stk-sc.ck tests/vm/pt-grow-stk-sc tests/vm/pt-grow-stk-sc.result
# # pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/page-merge-stk:page-merge-stk -p tests/vm/child-qsort:child-qsort --swap-disk=10 -- -q   -f run page-merge-stk < /dev/null 2> tests/vm/page-merge-stk.errors > tests/vm/page-merge-stk.output
# # perl -I../.. ../../tests/vm/page-merge-stk.ck tests/vm/page-merge-stk tests/vm/page-merge-stk.result
# # pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/page-merge-mm:page-merge-mm -p tests/vm/child-qsort-mm:child-qsort-mm --swap-disk=10 -- -q   -f run page-merge-mm < /dev/null 2> tests/vm/page-merge-mm.errors > tests/vm/page-merge-mm.output
# # perl -I../.. ../../tests/vm/page-merge-mm.ck tests/vm/page-merge-mm tests/vm/page-merge-mm.result


# # pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/child-mm-wrt:child-mm-wrt --swap-disk=4 -- -q   -f run child-mm-wrt < /dev/null 2> tests/vm/child-mm-wrt.errors > tests/vm/child-mm-wrt.output
# # perl -I../.. ../../tests/vm/mmap-exit.ck tests/vm/child-mm-wrt tests/vm/child-mm-wrt.result
# pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-exit:mmap-exit -p tests/vm/child-mm-wrt:child-mm-wrt --swap-disk=4 -- -q   -f run mmap-exit < /dev/null 2> tests/vm/mmap-exit.errors > tests/vm/mmap-exit.output
# perl -I../.. ../../tests/vm/mmap-exit.ck tests/vm/mmap-exit tests/vm/mmap-exit.result
# pintos -v -k -T 60 -m 20   --fs-disk=10  --swap-disk=4 -- -q  -threads-tests -f run priority-donate-chain < /dev/null 2> tests/threads/priority-donate-chain.errors > tests/threads/priority-donate-chain.output
# perl -I../.. ../../tests/threads/priority-donate-chain.ck tests/threads/priority-donate-chain tests/threads/priority-donate-chain.result
pintos -v -k -T 180 -m 8   --fs-disk=10 -p tests/vm/swap-file:swap-file -p ../../tests/vm/large.txt:large.txt --swap-disk=10 -- -q   -f run swap-file < /dev/null 2> tests/vm/swap-file.errors > tests/vm/swap-file.output
perl -I../.. ../../tests/vm/swap-file.ck tests/vm/swap-file tests/vm/swap-file.result
pintos -v -k -T 180 -m 10   --fs-disk=10 -p tests/vm/swap-anon:swap-anon --swap-disk=30 -- -q   -f run swap-anon < /dev/null 2> tests/vm/swap-anon.errors > tests/vm/swap-anon.output
perl -I../.. ../../tests/vm/swap-anon.ck tests/vm/swap-anon tests/vm/swap-anon.result
pintos -v -k -T 180 -m 10   --fs-disk=10 -p tests/vm/swap-iter:swap-iter -p ../../tests/vm/large.txt:large.txt --swap-disk=50 -- -q   -f run swap-iter < /dev/null 2> tests/vm/swap-iter.errors > tests/vm/swap-iter.output
perl -I../.. ../../tests/vm/swap-iter.ck tests/vm/swap-iter tests/vm/swap-iter.result
pintos -v -k -T 600 -m 40   --fs-disk=10 -p tests/vm/swap-fork:swap-fork -p tests/vm/child-swap:child-swap --swap-disk=200 -- -q   -f run swap-fork < /dev/null 2> tests/vm/swap-fork.errors > tests/vm/swap-fork.output
perl -I../.. ../../tests/vm/swap-fork.ck tests/vm/swap-fork tests/vm/swap-fork.result