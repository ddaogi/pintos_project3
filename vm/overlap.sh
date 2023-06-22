
make clean
cd ..
cd vm
make
cd build
gcc -c ../../tests/vm/mmap-overlap.c -o tests/vm/mmap-overlap.o -g -msoft-float -O0 -fno-omit-frame-pointer -mno-red-zone -mcmodel=large -fno-plt -fno-pic -mno-sse -fno-stack-protector -fno-stack-protector -Wno-builtin-declaration-mismatch -nostdinc -I../.. -I../../include/lib -I../../include -I../../include/lib/kernel -I../../include/lib/user -I. -Wall -W -Wstrict-prototypes -Wmissing-prototypes -Wsystem-headers -MMD -MF tests/vm/mmap-overlap.d
gcc -g -msoft-float -O0 -fno-omit-frame-pointer -mno-red-zone -mcmodel=large -fno-plt -fno-pic -mno-sse -fno-stack-protector -fno-stack-protector -Wno-builtin-declaration-mismatch -nostdlib -static -Wl,-T,../../lib/user/user.lds tests/vm/mmap-overlap.o tests/lib.o tests/main.o lib/user/entry.o libc.a -o tests/vm/mmap-overlap
dd if=/dev/zero of=tests/vm/zeros bs=1024 count=6
pintos -v -k -T 120 -m 20  --fs-disk=10 -p tests/vm/mmap-overlap:mmap-overlap -p tests/vm/zeros:zeros --swap-disk=4 -- -q  -f run mmap-overlap < /dev/null 2> tests/vm/mmap-overlap.errors > tests/vm/mmap-overlap.output
perl -I../.. ../../tests/vm/mmap-overlap.ck tests/vm/mmap-overlap tests/vm/mmap-overlap.result

pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-exit:mmap-exit -p tests/vm/child-mm-wrt:child-mm-wrt --swap-disk=4 -- -q   -f run mmap-exit < /dev/null 2> tests/vm/mmap-exit.errors > tests/vm/mmap-exit.output
perl -I../.. ../../tests/vm/mmap-exit.ck tests/vm/mmap-exit tests/vm/mmap-exit.result

pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-read:mmap-read -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-read < /dev/null 2> tests/vm/mmap-read.errors > tests/vm/mmap-read.output
perl -I../.. ../../tests/vm/mmap-read.ck tests/vm/mmap-read tests/vm/mmap-read.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-close:mmap-close -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-close < /dev/null 2> tests/vm/mmap-close.errors > tests/vm/mmap-close.output
perl -I../.. ../../tests/vm/mmap-close.ck tests/vm/mmap-close tests/vm/mmap-close.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-clean:mmap-clean -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-clean < /dev/null 2> tests/vm/mmap-clean.errors > tests/vm/mmap-clean.output
perl -I../.. ../../tests/vm/mmap-clean.ck tests/vm/mmap-clean tests/vm/mmap-clean.result


pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-kernel:mmap-kernel -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-kernel < /dev/null 2> tests/vm/mmap-kernel.errors > tests/vm/mmap-kernel.output
perl -I../.. ../../tests/vm/mmap-kernel.ck tests/vm/mmap-kernel tests/vm/mmap-kernel.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-bad-off:mmap-bad-off -p ../../tests/vm/large.txt:large.txt --swap-disk=4 -- -q   -f run mmap-bad-off < /dev/null 2> tests/vm/mmap-bad-off.errors > tests/vm/mmap-bad-off.output
perl -I../.. ../../tests/vm/mmap-bad-off.ck tests/vm/mmap-bad-off tests/vm/mmap-bad-off.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-off:mmap-off -p ../../tests/vm/large.txt:large.txt --swap-disk=4 -- -q   -f run mmap-off < /dev/null 2> tests/vm/mmap-off.errors > tests/vm/mmap-off.output
perl -I../.. ../../tests/vm/mmap-off.ck tests/vm/mmap-off tests/vm/mmap-off.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-zero-len:mmap-zero-len --swap-disk=4 -- -q   -f run mmap-zero-len < /dev/null 2> tests/vm/mmap-zero-len.errors > tests/vm/mmap-zero-len.output
perl -I../.. ../../tests/vm/mmap-zero-len.ck tests/vm/mmap-zero-len tests/vm/mmap-zero-len.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-bad-fd3:mmap-bad-fd3 --swap-disk=4 -- -q   -f run mmap-bad-fd3 < /dev/null 2> tests/vm/mmap-bad-fd3.errors > tests/vm/mmap-bad-fd3.output
perl -I../.. ../../tests/vm/mmap-bad-fd3.ck tests/vm/mmap-bad-fd3 tests/vm/mmap-bad-fd3.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-bad-fd2:mmap-bad-fd2 --swap-disk=4 -- -q   -f run mmap-bad-fd2 < /dev/null 2> tests/vm/mmap-bad-fd2.errors > tests/vm/mmap-bad-fd2.output
perl -I../.. ../../tests/vm/mmap-bad-fd2.ck tests/vm/mmap-bad-fd2 tests/vm/mmap-bad-fd2.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-zero:mmap-zero --swap-disk=4 -- -q   -f run mmap-zero < /dev/null 2> tests/vm/mmap-zero.errors > tests/vm/mmap-zero.output
perl -I../.. ../../tests/vm/mmap-zero.ck tests/vm/mmap-zero tests/vm/mmap-zero.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-remove:mmap-remove -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-remove < /dev/null 2> tests/vm/mmap-remove.errors > tests/vm/mmap-remove.output
perl -I../.. ../../tests/vm/mmap-remove.ck tests/vm/mmap-remove tests/vm/mmap-remove.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-over-stk:mmap-over-stk -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-over-stk < /dev/null 2> tests/vm/mmap-over-stk.errors > tests/vm/mmap-over-stk.output
perl -I../.. ../../tests/vm/mmap-over-stk.ck tests/vm/mmap-over-stk tests/vm/mmap-over-stk.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-over-data:mmap-over-data -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-over-data < /dev/null 2> tests/vm/mmap-over-data.errors > tests/vm/mmap-over-data.output
perl -I../.. ../../tests/vm/mmap-over-data.ck tests/vm/mmap-over-data tests/vm/mmap-over-data.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-over-code:mmap-over-code -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-over-code < /dev/null 2> tests/vm/mmap-over-code.errors > tests/vm/mmap-over-code.output
perl -I../.. ../../tests/vm/mmap-over-code.ck tests/vm/mmap-over-code tests/vm/mmap-over-code.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-null:mmap-null -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-null < /dev/null 2> tests/vm/mmap-null.errors > tests/vm/mmap-null.output
perl -I../.. ../../tests/vm/mmap-null.ck tests/vm/mmap-null tests/vm/mmap-null.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-misalign:mmap-misalign -p ../../tests/vm/sample.txt:sample.txt --swap-disk=4 -- -q   -f run mmap-misalign < /dev/null 2> tests/vm/mmap-misalign.errors > tests/vm/mmap-misalign.output
perl -I../.. ../../tests/vm/mmap-misalign.ck tests/vm/mmap-misalign tests/vm/mmap-misalign.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/vm/mmap-inherit:mmap-inherit -p ../../tests/vm/sample.txt:sample.txt -p tests/vm/child-inherit:child-inherit --swap-disk=4 -- -q   -f run mmap-inherit < /dev/null 2> tests/vm/mmap-inherit.errors > tests/vm/mmap-inherit.output
perl -I../.. ../../tests/vm/mmap-inherit.ck tests/vm/mmap-inherit tests/vm/mmap-inherit.result