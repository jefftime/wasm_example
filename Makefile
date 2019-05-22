wasm.js: main.wasm
	@echo -e $@: compiling...
	@truncate -s 0 $@
	@echo -n export const wasm_src = \' >> $@
	@base64 -w 0 main.wasm >> $@
	@echo \'\; >> $@
	@echo -e $@: done!

main.o: main.c
	@echo -e $@: compiling...
	@clang -c --target=wasm32 -O3 main.c
	@echo -e $@: compiled!

main.wasm: main.o
	@echo -e $@: linking...
	@wasm-ld --no-entry --export=add_two --export=add_three -o main.wasm main.o
	@echo -e $@: linked!

.PHONY: clean
clean:
	@rm -f wasm.js *.o *.wasm
