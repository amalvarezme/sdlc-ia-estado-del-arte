import fs from 'node:fs';
import path from 'node:path';
import { createRequire } from 'node:module';
const require = createRequire(import.meta.url);
let ts;
try { ts = require('typescript'); }
catch { ts = require('/opt/nvm/versions/node/v22.16.0/lib/node_modules/typescript/lib/typescript.js'); }
const root = path.resolve(import.meta.dirname, '..');
const src = fs.readFileSync(path.join(root,'src.tsx'),'utf8');
const compiled = ts.transpileModule(src,{ fileName:'src.tsx', compilerOptions:{target:ts.ScriptTarget.ES2022,module:ts.ModuleKind.ES2022,jsx:ts.JsxEmit.React,allowJs:true}, reportDiagnostics:true });
const errors = (compiled.diagnostics||[]).filter(x=>x.category===ts.DiagnosticCategory.Error);
if(errors.length) { for(const e of errors) console.error(ts.flattenDiagnosticMessageText(e.messageText,'\n')); process.exit(1); }
fs.writeFileSync(path.join(root,'app.js'),compiled.outputText);
console.log('✓ React TSX compilado a app.js ('+compiled.outputText.length+' bytes)');
