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


pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/fork-once:fork-once --swap-disk=4 -- -q   -f run fork-once < /dev/null 2> tests/userprog/fork-once.errors > tests/userprog/fork-once.output
perl -I../.. ../../tests/userprog/fork-once.ck tests/userprog/fork-once tests/userprog/fork-once.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/fork-multiple:fork-multiple --swap-disk=4 -- -q   -f run fork-multiple < /dev/null 2> tests/userprog/fork-multiple.errors > tests/userprog/fork-multiple.output
perl -I../.. ../../tests/userprog/fork-multiple.ck tests/userprog/fork-multiple tests/userprog/fork-multiple.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/fork-recursive:fork-recursive --swap-disk=4 -- -q   -f run fork-recursive < /dev/null 2> tests/userprog/fork-recursive.errors > tests/userprog/fork-recursive.output
perl -I../.. ../../tests/userprog/fork-recursive.ck tests/userprog/fork-recursive tests/userprog/fork-recursive.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/fork-read:fork-read -p ../../tests/userprog/sample.txt:sample.txt --swap-disk=4 -- -q   -f run fork-read < /dev/null 2> tests/userprog/fork-read.errors > tests/userprog/fork-read.output
perl -I../.. ../../tests/userprog/fork-read.ck tests/userprog/fork-read tests/userprog/fork-read.result
pintos -v -k -T 60 -m 20   --fs-disk=10 -p tests/userprog/fork-boundary:fork-boundary --swap-disk=4 -- -q   -f run fork-boundary < /dev/null 2> tests/userprog/fork-boundary.errors > tests/userprog/fork-boundary.output
perl -I../.. ../../tests/userprog/fork-boundary.ck tests/userprog/fork-boundary tests/userprog/fork-boundary.result
