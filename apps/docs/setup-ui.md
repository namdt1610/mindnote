Reusable UI Library với ShadCN, TypeScript, TSX.

Không bị lỗi .js khi import (bởi vì đã build trước).

Dùng được trong bất kỳ app nào trong workspace.

Có alias @ui/*, hỗ trợ build, dev, và publish luôn nếu muốn.

package.json
- thêm những dòng sau:
"main": "dist/index.js",
  "module": "dist/index.js",
  "types": "dist/index.d.ts",
  "files": ["dist"],
  "scripts": {
    "dev": "tsup src/index.ts --watch",
    "build": "tsup src/index.ts"
  },

tsconfig.json
"module": "ESNext",
"moduleResolution": "node",

* Phải build ra dist trước rồi mới index đc
- tsup sẽ build tsx thành .js, .d.ts.

tsup.config.ts