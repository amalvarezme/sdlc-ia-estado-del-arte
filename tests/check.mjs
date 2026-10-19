import fs from 'node:fs';
import assert from 'node:assert/strict';
const src=fs.readFileSync(new URL('../src.tsx',import.meta.url),'utf8');
const js=fs.readFileSync(new URL('../app.js',import.meta.url),'utf8');
for (const term of ['Gentle-AI','Engram','ODD','RDD','Spec Kit','OpenSpec','BMAD','TDD','METR','ISO/IEC 25010'])
  assert(src.includes(term),`Ausente: ${term}`);
assert(js.includes('createRoot'),'La salida debe usar React');
assert(fs.existsSync(new URL('../index.html',import.meta.url)));
console.log('✓ Estructura y secciones fundamentales verificadas');
