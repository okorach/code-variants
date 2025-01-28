
x86_64: variants.c
# x86_64 is a 64 bits little endian target
	mkdir -p targets/x86_64/
	clang variants.c -o targets/x86_64/bin-x86_64 


ppc: variants.c
# PowerPC is a 32 bits big endian target
	mkdir -p targets/ppc
	clang variants.c -DTARGET_PPC -o targets/ppc/bin-ppc

clean:
	rm -rf targets