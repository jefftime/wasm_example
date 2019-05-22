wasm.js: main.wasm
	@echo -e wasm.js: compiling...
	@truncate -s 0 wasm.js
	@echo -n export const wasm_src = \' >> wasm.js
	@base64 -w 0 main.wasm >> wasm.js
	@echo \'\; >> wasm.js
	@echo -e wasm.js: done!

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
