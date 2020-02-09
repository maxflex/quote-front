---
to: src/router/routes/<%= name %>s.js
---
import <%= Name %>Index from "@/pages/<%= Name %>/Index"
import <%= Name %>Show from "@/pages/<%= Name %>/Show"

export default [
  {
    path: "/<%= name %>s",
    name: "<%= Name %>Index",
    component: <%= Name %>Index
  },
  {
    path: "/<%= name %>s/:id",
    name: "<%= Name %>Show",
    component: <%= Name %>Show
  }
]
