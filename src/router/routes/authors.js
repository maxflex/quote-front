import AuthorIndex from "@/pages/Author/Index"
import AuthorShow from "@/pages/Author/Show"
import AuthorEdit from "@/pages/Add/Author"

export default [
  {
    path: "/authors",
    name: "AuthorIndex",
    component: AuthorIndex,
  },
  {
    path: "/authors/:id",
    name: "AuthorShow",
    component: AuthorShow,
  },
  {
    path: "/authors/:id/edit",
    name: "AuthorEdit",
    component: AuthorEdit,
  },
]
