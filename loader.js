'use strict';

import { wasm_src } from './wasm.js';

function compile_wasm() {
  let src = Uint8Array.from(atob(wasm_src), c => c.charCodeAt(0)).buffer;
  const module = new WebAssembly.Module(src);
  const instance = new WebAssembly.Instance(module);
  return instance;
}

function main() {
  const wasm = compile_wasm();
  console.log(`Wasm time: ${wasm.exports.add_three(1, 2, 3)}`);
}

main();
